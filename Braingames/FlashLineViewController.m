//
//  SpillViewController.m
//  Farger
//
//  Created by Gudbrand Tandberg on 14/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "FlashLineViewController.h"

@interface FlashLineViewController ()

@end

@implementation FlashLineViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self resetSpillVariabler];
	self.feltene = [NSMutableArray array];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	NSURL *riktigLyd = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"riktig" ofType:@"wav"]];
	NSURL *feilLyd = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"feil" ofType:@"wav"]];
	
	self.riktigPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:riktigLyd error:nil];
	self.feilPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:feilLyd error:nil];
	
	CGFloat w = self.view.frame.size.width;
	CGFloat h = self.view.frame.size.height;
	
	//Lag fargefeltene
	for (int i=0; i<3; i++) {
		for (int j=0; j<2; j++){
			
			UIButton * knappen = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			
			CGRect rute = CGRectMake(0, 0, w/2, h/3);
			knappen.frame = rute;
			
			knappen.center = CGPointMake(w/4 + j*w/2, h/6 + i*h/3);
			[knappen addTarget:self action:@selector(trykk:) forControlEvents:UIControlEventTouchDown];
			
			double r = (arc4random() % 255)/255.0;
			double g = (arc4random() % 255)/255.0;
			double b = (arc4random() % 255)/255.0;
			
			knappen.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
			[self.feltene addObject:knappen];
			
			knappen.tag = i*2+j;
			
		}
	}
	
	//Legg til fargefeltene
	for (UIButton* knapp in self.feltene) {
		[self.view addSubview:knapp];
	}
	
	//Lag poengteller
	
	UILabel *poengLabel = [[UILabel alloc] initWithFrame:CGRectMake(w-20, 20, 20, 20)];
	[poengLabel setText:[NSString stringWithFormat:@"%d", self.antall]];
	poengLabel.textColor = [UIColor whiteColor];
	self.poengLabel = poengLabel;
	[self.view addSubview:poengLabel];
	
	//start hovedloop
	[self performSelector:@selector(animer) withObject:nil afterDelay:1.0];
	
}


- (void)animer{
	
	//legger til tall i rekka
	NSNumber *tall = [NSNumber numberWithInt:arc4random() % 6];
	[self.rekken addObject:tall];
	self.antall++;
	
	//animer rekken
	for (int i=0; i<self.antall; i++) {
		NSUInteger ruteindeks = [[self.rekken objectAtIndex:i] integerValue];
		UIButton *knappen = [self.feltene objectAtIndex:ruteindeks];
		[self performSelector:@selector(blink:) withObject:knappen afterDelay:i*0.5];
	}
	
}

- (void)blink:(UIButton *)knapp {
	
	[UIView animateWithDuration:0.5
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{knapp.alpha = 0.0; knapp.alpha = 1.0;}
					 completion:nil];
	
}

- (void)trykk:(UIButton *)knapp {
	
	self.antTrykk++;
	[self blink:knapp];
	
	if (self.antTrykk <= self.antall) {
		
		if (knapp.tag == [[self.rekken objectAtIndex:self.antTrykk-1] intValue]) {
			
			if (self.antTrykk < self.antall){
				//en riktig, lag en vinnerlyd
				if ([self.riktigPlayer isPlaying]) {
					[self.riktigPlayer stop];
				}
				[self.riktigPlayer play];
			}
			
			else {
				//La rekken gro
				[self.riktigPlayer play];
				[self blink:knapp];
				
				[self.poengLabel setText:[NSString stringWithFormat:@"%d", self.antall]];
				self.antTrykk = 0;
				
				[self performSelector:@selector(animer) withObject:nil afterDelay:1.5];
			}
		}
		
		else {
			//spill tapelyd og gå tilbake til meny
			
			[self.feilPlayer play];
			[self blink:knapp];

			
			//Lager en pop-up valgmeny
			
			CGFloat w = self.view.frame.size.width;
			CGFloat h = self.view.frame.size.height;
			
			FerdigPopUpView *popUpView = [[FerdigPopUpView alloc]initWithFrame:CGRectMake(0, 0, 3*w/4, h/2)
																		  game:1
																		 poeng:self.antall-1];
			
			popUpView.center = self.view.center;
			popUpView.delegate = self;
			self.ferdigPopUpView = popUpView;
			
			[self.view addSubview:popUpView];


		}
	}
	else{[self dismissViewControllerAnimated:YES completion:nil];}
}

- (void)meny {
	[self.delegate reloadHighscores];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)igjen {

	[self.ferdigPopUpView removeFromSuperview];
	[self resetSpillVariabler];
	[self performSelector:@selector(animer) withObject:nil afterDelay:0.5];
}

- (void)resetSpillVariabler {
	self.antall = 0;
	self.antTrykk = 0;
	self.rekken = [NSMutableArray array];
	[self.poengLabel setText:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
