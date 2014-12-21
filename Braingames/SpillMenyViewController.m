//
//  SpillMenyViewController.m
//  Farger
//
//  Created by Gudbrand Tandberg on 18/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "SpillMenyViewController.h"

@interface SpillMenyViewController ()

@end

@implementation SpillMenyViewController

- (id)initWithGame:(int)game {
	self = [super init];
	if (self) {
		
		self.game = game;
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		self.highscores = [defaults objectForKey:[NSString stringWithFormat:@"HighscoresForGame%d", self.game]];
		
		return self;
	}
	return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor colorWithRed:252/255. green:252/255. blue:128/255. alpha:1.0];
	
	CGFloat w = self.view.frame.size.width;
	CGFloat h = self.view.frame.size.height;
	
	//en tittel
	
	UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, 100)];
	logoView.center = CGPointMake(self.view.center.x, 90);
	
	if (self.game == 1) {
		logoView.image = [UIImage imageNamed:@"flashlineknapp.png"];
	}
	else if (self.game ==2){
		logoView.image = [UIImage imageNamed:@"memoryknapp.png"];
	}
	[self.view addSubview:logoView];
	
	//en startknapp midt i
	UIButton* startknapp = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[startknapp setBackgroundImage:[UIImage imageNamed:@"playknapp.png"] forState:UIControlStateNormal];
	startknapp.frame = CGRectMake(0, 0, 160, 60);
	startknapp.center = CGPointMake(self.view.center.x, self.view.center.y - 65);
	[startknapp addTarget:self action:@selector(spill) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:startknapp];
	
	//en tilbake-knapp
	
	UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 60)];
	[backButton setBackgroundImage:[UIImage imageNamed:@"mainmenuknapp.png"] forState:UIControlStateNormal];
	backButton.center = CGPointMake(self.view.center.x, self.view.center.y);
	[backButton addTarget:self action:@selector(mainmenu) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:backButton];
	
	//en highsoretabell

	HighScoreView* hsView = [[HighScoreView alloc] initWithFrame:CGRectMake(0, 0, 3*w/4, h/3)];
	hsView.center = CGPointMake(self.view.center.x, self.view.center.y+130);
	hsView.game = self.game;
	self.highscoreView = hsView;
	[self reloadHighscores];
	
	[self.view addSubview:hsView];

}

- (void) mainmenu {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadHighscores {
	
	self.highscores = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"HighscoresForGame%d", self.game]];
	
	NSString *medPlayer = [[self.highscores objectForKey:@"names"] objectAtIndex:1];
	NSInteger medValue = [[[self.highscores objectForKey:@"scores"] objectAtIndex:1] integerValue];
	
	[self.highscoreView.medLabel setText:[NSString stringWithFormat:@"%@: %d", medPlayer, (int)medValue]];
	
	NSString *highPlayer = [[self.highscores objectForKey:@"names"] objectAtIndex:0];
	NSInteger highValue = [[[self.highscores objectForKey:@"scores"] objectAtIndex:0] integerValue];
	
	[self.highscoreView.highLabel setText:[NSString stringWithFormat:@"%@: %d", highPlayer, (int)highValue]];
	
	NSString *lowPlayer = [[self.highscores objectForKey:@"names"] objectAtIndex:2];
	NSInteger lowValue = [[[self.highscores objectForKey:@"scores"] objectAtIndex:2] integerValue];
	[self.highscoreView.lowLabel setText:[NSString stringWithFormat:@"%@: %d", lowPlayer, (int)lowValue]];

	
}

- (void)spill {
	
	if (self.game == 1) {
		FlashLineViewController *flashlineSpillViewController = [[FlashLineViewController alloc] init];
		flashlineSpillViewController.delegate = self;
		[self presentViewController:flashlineSpillViewController animated:YES completion:nil];
	}
	
	else if (self.game ==2){
		MemoryViewController *memorySpillViewController = [[MemoryViewController alloc] init];
		memorySpillViewController.delegate = self;
		[self presentViewController:memorySpillViewController animated:YES completion:nil];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
