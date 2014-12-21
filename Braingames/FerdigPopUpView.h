//
//  FerdigPopUpView.h
//  Farger
//
//  Created by Gudbrand Tandberg on 16/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FerdigPopUpViewDelegate <NSObject>

- (void) meny;
- (void) igjen;

@end

@interface FerdigPopUpView : UIView <UITextFieldDelegate>

- (id) initWithFrame:(CGRect)frame game:(int)game poeng:(int)poeng;

@property int poeng;
@property int game;
@property id<FerdigPopUpViewDelegate> delegate;
@property NSMutableDictionary* highscores;
@property UILabel* tittel;

@end
