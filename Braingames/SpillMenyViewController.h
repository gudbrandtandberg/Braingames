//
//  SpillMenyViewController.h
//  Farger
//
//  Created by Gudbrand Tandberg on 18/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashLineViewController.h"
#import "MemoryViewController.h"
#import "SpillViewControllerDelegateProtocol.h"
#import "HighScoreView.h"

#define FLASHLINE 1
#define MEMORY 2

@interface SpillMenyViewController : UIViewController <SpillViewControllerDelegate>

@property int game;
@property NSMutableDictionary* highscores;
@property HighScoreView* highscoreView;

- (void)reloadHighscores;
- (id)initWithGame:(int)game;
- (void) spill;


@end
