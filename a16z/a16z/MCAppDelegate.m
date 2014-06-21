//
//  AppDelegate.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Parse/Parse.h>

#import "MCAppDelegate.h"
#import <Parse/Parse.h>
#import "MCDiscoverViewController.h"
#import "MCProfileViewController.h"
#import "MCLoginViewController.h"
#import "MCMatchesViewController.h"


@interface MCAppDelegate ()

@property (nonatomic) UITabBarController *tabBarController;

@end


@implementation MCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Parse setup
    [Parse setApplicationId:@"OZZ5mGxl3vDzZwzEIeGJ19u0PTg16NE7E7xqQn7C"
                  clientKey:@"59ix5pPVpQkXAPN3jAsHvaWVkwVpGEXSfN2Xohii"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    self.tabBarController = [UITabBarController new];
    self.tabBarController.viewControllers = @[[MCDiscoverViewController new],
                                              [MCMatchesViewController new],
                                              [MCProfileViewController new]];
    
    self.tabBarController.selectedIndex = 0;
    
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
#define TEST_LOGIN NO
    if (![PFUser currentUser]) {
#if TEST_LOGIN
        MCLoginViewController *loginViewController = [[MCLoginViewController alloc] init];
        [self.tabBarController presentViewController:loginViewController
                                            animated:YES
                                          completion:nil];
#endif
    }
    return YES;
}

@end
