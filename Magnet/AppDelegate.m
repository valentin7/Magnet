//
//  AppDelegate.m
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"sdfs dfsdf sdf");
    [Parse setApplicationId:@"fCRM0CEXdoWkzlEv9QxTZUJKEmVf96Cz4rhsbw7Y"
                  clientKey:@"0GTQI2saJL5yvbLCRN0RGOOTQTak3UDzGFpqbeoR"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];

    PFObject *testObject = [PFObject objectWithClassName:@"What"];
    testObject[@"foo"] = @"bar";
    //[testObject saveInBackground];
    [PFUser logOut];
    if (![PFUser currentUser])
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        SignUpViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"signUpController"];
        self.window.rootViewController = vc;
        
    }
    // don't do anything; it's a normal case.
    ///   [self showWalkthrough];
   // PFUser *user = [PFUser currentUser];
    return YES;
}

#pragma mark - openURL methods


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{ /* Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface. */
    
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

-(void)applicationWillTerminate:(UIApplication *)application
{ /* Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:. */
    [[PFFacebookUtils session] close];
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


@end
