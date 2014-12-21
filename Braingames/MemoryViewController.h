//
//  MemoryViewController.h
//  Farger
//
//  Created by Gudbrand Tandberg on 17/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoryFelt.h"
#import "FerdigPopUpView.h"
#import "SpillViewControllerDelegateProtocol.h"

@interface MemoryViewController : UIViewController <FerdigPopUpViewDelegate>

-(void) trykk: (UIButton*) knappen;
-(void) snu: (UIButton*) knappen;
-(void) nullstill:(UIButton*) knappen;
-(void) meny;
-(void) igjen;
-(void) resetMemoryFelts;

@property id<SpillViewControllerDelegate> delegate;

@property NSMutableArray* feltene;
@property NSMutableArray* tallene;
@property NSMutableArray* snudd;

@property BOOL trykkNummer;

@property MemoryFelt* knapp1;
@property MemoryFelt* knapp2;

@property int antRiktig;
@property int antForsok;

@property FerdigPopUpView* ferdigPopUpView;

@end
