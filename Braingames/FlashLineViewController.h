//
//  SpillViewController.h
//  Farger
//
//  Created by Gudbrand Tandberg on 14/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FerdigPopUpView.h"
#import "SpillViewControllerDelegateProtocol.h"

@interface FlashLineViewController : UIViewController <FerdigPopUpViewDelegate>

-(void) animer;
-(void) blink: (UIButton *) knapp;
-(void) trykk: (UIButton *) knapp;
-(void) meny;
-(void) igjen;

@property (nonatomic, weak) id<SpillViewControllerDelegate> delegate;
@property FerdigPopUpView* ferdigPopUpView;

@property (nonatomic, strong) NSMutableArray *feltene;
@property (nonatomic, strong) NSMutableArray *rekken;
@property (nonatomic, strong) UILabel *poengLabel;

@property int antall;
@property int antTrykk;

@property AVAudioPlayer *riktigPlayer;
@property AVAudioPlayer *feilPlayer;

@end
