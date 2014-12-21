//
//  SpillViewControllerDelegateProtocol.h
//  Farger
//
//  Created by Gudbrand Tandberg on 18/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#ifndef Farger_SpillViewControllerDelegateProtocol_h
#define Farger_SpillViewControllerDelegateProtocol_h

@protocol SpillViewControllerDelegate <NSObject>

- (void)reloadHighscores;

@property NSDictionary* highscores;

@end

#endif
