//
//  STKAppDelegate.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKAppDelegate.h"
#import "STKMainViewController.h"

@implementation STKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // Initialize Parse, Facebook, and Twitter
    [FBSettings setDefaultAppID:@"255036771344586"];
    [Parse setApplicationId:@"YDpyIfE75kxnNUMmyTkZANz9ST8Sx6PFMBd8IbeX" clientKey:@"MzleRB2joEiuso29R0lqGtfevzashJRU1be6tzR4"];
    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey:@"NXxnrH0kjZ5BoZMgl0lbg" consumerSecret:@"dZrcI34kCWvTbRduUPj8JmFqrxRcbztgJO5ApjVAomc"];
    
    UINavigationController*navigation = [[UINavigationController alloc] initWithRootViewController:[[STKMainViewController alloc] init]];
    
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
