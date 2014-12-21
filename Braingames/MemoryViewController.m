//
//  MemoryViewController.m
//  Farger
//
//  Created by Gudbrand Tandberg on 17/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "MemoryViewController.h"

@interface MemoryViewController ()

@end

@implementation MemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    //initialiserer spillvariabler

	self.trykkNummer = 0;
	self.snudd = [[NSMutableArray alloc] init];
	self.antForsok = 0;

	
	//først lager vi en rekke med lengde 20 som inneholder tallene fra 0 til 9
	//to ganger hver, så stokker vi om på denne på en tilfeldig måte.

	NSMutableArray* tallene = [[NSMutableArray alloc] init];
	self.tallene = tallene;
	
	for (int i=0; i<10; i++) {
		for (int j=0; j<2; j++) {
			[tallene addObject:[NSNumber numberWithInt:i]];
		}
	}
	for (NSInteger i=0; i<20;	i++){
		NSInteger bytterIgjen = 20-i;
		NSInteger skalByttes = i + arc4random_uniform((u_int32_t) bytterIgjen);
		[tallene exchangeObjectAtIndex:i withObjectAtIndex:skalByttes];
	}
	
	
	CGFloat w = self.view.frame.size.width;
	CGFloat h = self.view.frame.size.height;
	
	self.feltene = [[NSMutableArray alloc] init];
	
	for (int i=0; i<5; i++) {
		for (int j=0; j<4; j++) {
			
			MemoryFelt* knappen = [MemoryFelt buttonWithType:UIButtonTypeRoundedRect];
			
			CGRect rute = CGRectMake(0, 0, w/4., h/5.);
			knappen.frame = rute;
			knappen.center = CGPointMake(w/8 + j*w/4, h/10 + i*h/5);
			
			[knappen addTarget:self action:@selector(trykk:) forControlEvents:UIControlEventTouchDown];
			
			knappen.tag = [[self.tallene objectAtIndex:4*i+j] intValue];
			knappen.indeks = 4*i+j;

			knappen.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"memmain.png"]];
			
			[self.feltene addObject:knappen];
			
		}
	}
	
	for (UIButton* knapp in self.feltene) {
		[self.view addSubview:knapp];
	}
}

- (void)trykk: (MemoryFelt*) knappen{
	
	if ([self.snudd containsObject:[NSNumber numberWithInteger:knappen.indeks]]){
		return;
	}
	if (self.trykkNummer == 0) {
		
		[self snu:knappen];
		self.knapp1 = knappen;
		self.trykkNummer = 1;
	}
	else {
		self.knapp2 = knappen;
		
		if (self.knapp1.indeks == self.knapp2.indeks){
			[self dismissViewControllerAnimated:YES completion:nil];
			return;
		}
		
		[self snu:knappen];
		self.trykkNummer = 0;
		
		if (self.knapp1.tag == self.knapp2.tag) {
			
			self.antForsok++;
			self.antRiktig++;
			[self.snudd addObject:[NSNumber numberWithInteger:self.knapp1.indeks]];
			[self.snudd addObject:[NSNumber numberWithInteger:self.knapp2.indeks]];
			
		}
		else {
			
			self.antForsok++;
			[self performSelector:@selector(nullstill:) withObject:self.knapp1 afterDelay:0.8];
			[self performSelector:@selector(nullstill:) withObject:self.knapp2 afterDelay:0.8];
			
		}
	}
	
	if (self.antRiktig == 10) {
		
		[self performSelector:@selector(createPopUp) withObject:nil afterDelay:0.8];
		
	}
}

- (void)createPopUp {
	
	CGFloat w = self.view.frame.size.width;
	CGFloat h = self.view.frame.size.height;
	
	FerdigPopUpView *popUpView = [[FerdigPopUpView alloc] initWithFrame:CGRectMake(0, 0, 3*w/4, h/2)
																   game:2
																  poeng:self.antForsok];
	popUpView.center = self.view.center;
	popUpView.delegate = self;
	self.ferdigPopUpView = popUpView;
	
	
	[self.view addSubview:popUpView];
}

- (void)snu:(MemoryFelt*) knappen {
	
	[UIView transitionWithView:knappen
					  duration:0.5
					   options:UIViewAnimationOptionTransitionFlipFromRight
					animations:^{knappen.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"mem%d.png", (int)knappen.tag+1]]];}
					completion:nil];

	//knappen.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"mem%d.png", (int)knappen.tag+1]]];
}

- (void) nullstill:(MemoryFelt*) knappen {
	[UIView transitionWithView:knappen
					  duration:0.5
					   options:UIViewAnimationOptionTransitionFlipFromRight
					animations:^{knappen.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"memmain.png"]];}
					completion:nil];

//knappen.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"memmain.png"]];
}

-(void) meny {
	[self.delegate reloadHighscores];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void) igjen {
	
	[self.ferdigPopUpView removeFromSuperview];
	self.antRiktig = 0;
	self.antForsok = 0;
	self.snudd = [[NSMutableArray alloc] init];
	
	[self resetMemoryFelts];
	
}

-(void)resetMemoryFelts {
	
	for (MemoryFelt* felt in self.feltene) {
		[self nullstill:felt];
	}
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
