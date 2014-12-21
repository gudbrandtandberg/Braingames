//
//  HighScoreView.m
//  Farger
//
//  Created by Gudbrand Tandberg on 19/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "HighScoreView.h"

@implementation HighScoreView

- (id)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];

	self.backgroundColor = [UIColor colorWithRed:252/255. green:252/255. blue:128/255. alpha:1.0];
	CGFloat ww = frame.size.width;
	CGFloat hh = frame.size.height;
	
	//tittel
	
	UILabel *highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
	highScoreLabel.center = CGPointMake(ww/2, 1*hh/5);
	[highScoreLabel setText:@"Highscores:"];
	highScoreLabel.textAlignment = NSTextAlignmentCenter;
	highScoreLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
	highScoreLabel.textColor = [UIColor grayColor];
	
	[self addSubview:highScoreLabel];
	
	// Highest score
	UILabel *highLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15*8, 20)];
	highLabel.center = CGPointMake(ww/2, 2*hh/5);
	highLabel.textAlignment = NSTextAlignmentCenter;
	highLabel.textColor = [UIColor grayColor];
	self.highLabel = highLabel;
	
	[self addSubview:highLabel];
	
	// Medium score
	UILabel *medLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15*8, 20)];
	medLabel.center = CGPointMake(ww/2, 3*hh/5);
	medLabel.textAlignment = NSTextAlignmentCenter;
	medLabel.textColor = [UIColor grayColor];
	self.medLabel = medLabel;
	
	[self addSubview:medLabel];
	
	// Lowest score
	UILabel *lowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15*8, 20)];
	lowLabel.center = CGPointMake(ww/2, 4*hh/5);
	lowLabel.textAlignment = NSTextAlignmentCenter;
	lowLabel.textColor = [UIColor grayColor];
	self.lowLabel = lowLabel;
	
	[self addSubview:lowLabel];
	
	return self;
}

@end
