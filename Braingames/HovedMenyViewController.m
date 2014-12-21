//
//  ViewController.m
//  Farger
//
//  Created by Gudbrand Tandberg on 13/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "HovedMenyViewController.h"

@interface HovedMenyViewController ()

@end

@implementation HovedMenyViewController

- (void) viewDidLoad {
	
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor colorWithRed:252/255. green:252/255. blue:128/255. alpha:1.0];
	
	//logoen
	UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	logoView.center = CGPointMake(self.view.center.x, 90);
	
	logoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"braingameslogo.png"]];
	[self.view addSubview:logoView];
	
	//spill Flashline knapp
	UIButton* startknapp = [UIButton buttonWithType:UIButtonTypeCustom];

	[startknapp setBackgroundImage:[UIImage imageNamed:@"flashlineknapp.png"] forState:UIControlStateNormal];
	startknapp.frame = CGRectMake(0, 0, 160, 60);
	startknapp.center = self.view.center;
	[startknapp addTarget:self action:@selector(flashline) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:startknapp];
	
	//spill Memory knapp
	UIButton* startMemoryKnapp = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[startMemoryKnapp setBackgroundImage:[UIImage imageNamed:@"memoryknapp.png"] forState:UIControlStateNormal];
	startMemoryKnapp.frame = CGRectMake(0, 0, 160, 60);
	startMemoryKnapp.center = CGPointMake(self.view.center.x, self.view.center.y+60);
	
	[startMemoryKnapp addTarget:self action:@selector(memory) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:startMemoryKnapp];
	
}

- (void) flashline {
	
	SpillMenyViewController *spillMenyVC = [[SpillMenyViewController alloc] initWithGame:1];
	[self presentViewController:spillMenyVC animated:YES completion:nil];

}

-(void) memory {
	
	SpillMenyViewController *spillMenyVC = [[SpillMenyViewController alloc] initWithGame:2];
	[self presentViewController:spillMenyVC animated:YES completion:nil];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
