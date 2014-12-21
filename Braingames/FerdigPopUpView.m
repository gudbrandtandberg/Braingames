//
//  FerdigPopUpView.m
//  Farger
//
//  Created by Gudbrand Tandberg on 16/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "FerdigPopUpView.h"

@implementation FerdigPopUpView

- (id) initWithFrame:(CGRect)frame game:(int)game poeng:(int)poeng {
	
	self = [super initWithFrame:frame];
	
	self.poeng = poeng;
	self.game = game;
	
	NSMutableDictionary *highscores = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"HighscoresForGame%d", self.game]];
	
	self.highscores = highscores;
	
	CGFloat ww = self.frame.size.width;
	CGFloat hh = self.frame.size.height;
	
	if ([self checkIfIsHighscore:self.poeng]) {
		
		//en label og navneinputfelt
		UILabel *melding = [[UILabel alloc] init];
		melding.frame = CGRectMake(0, 0, 21*8, 20);
		melding.center = CGPointMake(ww/2, hh/8+15);
		[melding setText:[NSString stringWithFormat:@"Highscore! %d poeng!", self.poeng]];
		
		UITextField *navnFelt = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 3*ww/4, 25)];
		navnFelt.center = CGPointMake(ww/2, 3*hh/8-10);
		navnFelt.placeholder = @"Navn";
		navnFelt.delegate = self;
		navnFelt.backgroundColor = [UIColor whiteColor];
		navnFelt.returnKeyType = UIReturnKeyDone;
		self.tittel = melding;
		
		[self addSubview:navnFelt];
		[self addSubview:melding];
		
	}
	else {
		
		// bare en label
		UILabel *melding = [[UILabel alloc] init];
		melding.frame = CGRectMake(0, 0, 136, 20);
		melding.center = CGPointMake(ww/2, hh/4);
		[melding setText:[NSString stringWithFormat:@"Du fikk %d poeng!", self.poeng]];
		self.tittel = melding;
		
		[self addSubview:melding];
	}
	
	//og to knapper
	
	UIButton *igjenKnapp = [[UIButton alloc] init];
	UIButton *menyKnapp = [[UIButton alloc] init];
	
	igjenKnapp.frame = CGRectMake(0, 0, ww/2, 20);
	igjenKnapp.center = CGPointMake(ww/2, hh/2);
	[igjenKnapp addTarget: self.delegate action:@selector(igjen) forControlEvents:UIControlEventTouchUpInside];
	
	menyKnapp.frame = CGRectMake(0, 0, ww/2, 20);
	menyKnapp.center = CGPointMake(ww/2, 3*hh/4);
	[menyKnapp addTarget:self.delegate action:@selector(meny) forControlEvents:UIControlEventTouchUpInside];
	
	[igjenKnapp setTitle:@"Prøv igjen" forState:UIControlStateNormal];
	[menyKnapp setTitle:@"Tilbake" forState:UIControlStateNormal];
	
	self.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.7 alpha:1.0];
	
	[self addSubview:igjenKnapp];
	[self addSubview:menyKnapp];
	
	
	return self;
}

- (BOOL)checkIfIsHighscore:(int)poeng {
	
	BOOL hs;
	int forrigeLowscore;
	
	self.highscores = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"HighscoresForGame%d", self.game]];
	
	
	switch (self.game) {
		case 1:
			hs = (poeng > [[[self.highscores objectForKey:@"scores"] objectAtIndex:2] intValue]);
			break;
		
		case 2:
			forrigeLowscore = [[[self.highscores objectForKey:@"scores"] objectAtIndex:2] intValue];
			hs = (poeng < forrigeLowscore || forrigeLowscore == 0);
			break;
		
		default:
			break;
	}
	
	return (hs);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	//Legg til highscores i defaults
	
	NSMutableArray *scores = [self.highscores objectForKey:@"scores"];
	NSMutableArray *names = [self.highscores objectForKey:@"names"];
	
	NSString *name = textField.text;
	NSNumber *zero = [NSNumber numberWithInt:0];
	NSMutableArray *newNames = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
	NSMutableArray *newScores = [NSMutableArray arrayWithObjects:zero, zero, zero, nil];
	
	if (self.game == 1){
		
		if (self.poeng > [[scores objectAtIndex:1] intValue]) { //2. place or higher
			
			if (self.poeng > [[scores objectAtIndex:0] intValue]) { //1. place
				
				//shuffle along
				[newNames setObject:[names objectAtIndex:1] atIndexedSubscript:2];
				[newNames setObject:[names objectAtIndex:0] atIndexedSubscript:1];
				[newNames setObject:name atIndexedSubscript:0];
				
				[newScores setObject:[scores objectAtIndex:1] atIndexedSubscript:2];
				[newScores setObject:[scores objectAtIndex:0] atIndexedSubscript:1];
				[newScores setObject:[NSNumber numberWithInt:self.poeng] atIndexedSubscript:0];

			}
			
			else { // 2. place
				
				[newNames setObject:[names objectAtIndex:0] atIndexedSubscript:0];
				[newScores setObject:[scores objectAtIndex:0] atIndexedSubscript:0];
				
				//shuffle along
				[newNames setObject:name atIndexedSubscript:1];
				[newNames setObject:[names objectAtIndex:1] atIndexedSubscript:2];

				[newScores setObject:[NSNumber numberWithInt:self.poeng] atIndexedSubscript:1];
				[newScores setObject:[scores objectAtIndex:1] atIndexedSubscript:2];
				
			}
		}
		
		else { // 3. place
			
			[newNames setObject:[names objectAtIndex:0] atIndexedSubscript:0];
			[newScores setObject:[scores objectAtIndex:0] atIndexedSubscript:0];
			[newNames setObject:[names objectAtIndex:1] atIndexedSubscript:1];
			[newScores setObject:[scores objectAtIndex:1] atIndexedSubscript:1];
			
			// shuffle
			[newScores setObject:[NSNumber numberWithInt:self.poeng] atIndexedSubscript:2];
			[newNames setObject:name atIndexedSubscript:2];
			
		}
		
	}
	else if (self.game == 2){
		
		if (self.poeng < [[scores objectAtIndex:1] intValue]) { //2. place or higher
			
			if (self.poeng < [[scores objectAtIndex:0] intValue]) { //1. place
				
				//shuffle along
				[newNames setObject:[names objectAtIndex:1] atIndexedSubscript:2];
				[newNames setObject:[names objectAtIndex:0] atIndexedSubscript:1];
				[newNames setObject:name atIndexedSubscript:0];
				
				[newScores setObject:[scores objectAtIndex:1] atIndexedSubscript:2];
				[newScores setObject:[scores objectAtIndex:0] atIndexedSubscript:1];
				[newScores setObject:[NSNumber numberWithInt:self.poeng] atIndexedSubscript:0];
				
			}
			
			else { // 2. place
				
				[newNames setObject:[names objectAtIndex:0] atIndexedSubscript:0];
				[newScores setObject:[scores objectAtIndex:0] atIndexedSubscript:0];
				
				//shuffle along
				[newNames setObject:name atIndexedSubscript:1];
				[newNames setObject:[names objectAtIndex:1] atIndexedSubscript:2];
				
				[newScores setObject:[NSNumber numberWithInt:self.poeng] atIndexedSubscript:1];
				[newScores setObject:[scores objectAtIndex:1] atIndexedSubscript:2];
				
			}
		}
		
		else { // 3. place
			
			[newNames setObject:[names objectAtIndex:0] atIndexedSubscript:0];
			[newScores setObject:[scores objectAtIndex:0] atIndexedSubscript:0];
			[newNames setObject:[names objectAtIndex:1] atIndexedSubscript:1];
			[newScores setObject:[scores objectAtIndex:1] atIndexedSubscript:1];
			
			// shuffle
			[newScores setObject:[NSNumber numberWithInt:self.poeng] atIndexedSubscript:2];
			[newNames setObject:name atIndexedSubscript:2];
			
		}
	}
	
	//add and synchronize highscores
	NSMutableDictionary *newHighscores = [[NSMutableDictionary alloc] initWithObjectsAndKeys:newScores, @"scores", newNames, @"names", nil];
	
	[[NSUserDefaults standardUserDefaults] setObject:newHighscores forKey:[NSString stringWithFormat:@"HighscoresForGame%d", self.game]];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	
	[self removeTextField:textField];
	[textField resignFirstResponder];
	
	return YES;
	
}

- (void)removeTextField:(UITextField *)theTextField {
	
	CGFloat ww = self.frame.size.width;
	CGFloat hh = self.frame.size.height;
	[theTextField removeFromSuperview];
	self.tittel.center = CGPointMake(ww/2, hh/4);
	
}


@end
