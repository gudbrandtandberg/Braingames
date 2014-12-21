//
//  AppDelegate.m
//  Farger
//
//  Created by Gudbrand Tandberg on 13/12/14.
//  Copyright (c) 2014 Duff Development. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ([defaults objectForKey:@"HighscoresForGame1"] == nil) {
		NSNumber *zero = [[NSNumber alloc] initWithInt:0];
		NSArray *scores = [NSArray arrayWithObjects:zero, zero, zero, nil];
		NSArray *names = [NSArray arrayWithObjects:@"Player1", @"Player2", @"Player3", nil];
		
		
		NSMutableDictionary *highscores = [[NSMutableDictionary alloc] initWithObjectsAndKeys:names, @"names", scores, @"scores", nil];
		
		[defaults setObject:highscores forKey:@"HighscoresForGame1"];
		[defaults synchronize];
	}
	if ([defaults objectForKey:@"HighscoresForGame2"] == nil) {
		
		NSNumber *zero = [[NSNumber alloc] initWithInt:50];
		NSArray *scores = [NSArray arrayWithObjects:zero, zero, zero, nil];
		NSArray *names = [NSArray arrayWithObjects:@"Player1", @"Player2", @"Player3", nil];
		
		
		NSMutableDictionary *highscores = [[NSMutableDictionary alloc] initWithObjectsAndKeys:names, @"names", scores, @"scores", nil];
		
		[defaults setObject:highscores forKey:@"HighscoresForGame2"];
		[defaults synchronize];
	}
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	HovedMenyViewController *initialVC = [[HovedMenyViewController alloc] init];
	self.window.rootViewController = initialVC;
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
