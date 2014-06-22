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

@property (nonatomic) UINavigationController *navigationController;
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
    
    [UINavigationBar appearance].tintColor = [UIColor orangeColor];
    
    
    UINavigationController *profileNavigationController = [[UINavigationController alloc]initWithRootViewController:[MCProfileViewController new]];
    profileNavigationController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Profile"
                                                                          image:[UIImage imageNamed:@"profile"]
                                                                  selectedImage:[UIImage imageNamed:@"profile-active"]];
    
    UINavigationController *matchesNavigationController = [[UINavigationController alloc]initWithRootViewController:[MCMatchesViewController new]];
    matchesNavigationController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Matches"
                                                                          image:[UIImage imageNamed:@"matches"]
                                                                  selectedImage:[UIImage imageNamed:@"matches-active"]];
    
    MCDiscoverViewController *discoverViewController = [MCDiscoverViewController new];
    discoverViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Discover"
                                                                     image:[UIImage imageNamed:@"discover"]
                                                             selectedImage:[UIImage imageNamed:@"discover"]];
    
    self.tabBarController = [UITabBarController new];
    self.tabBarController.viewControllers = @[discoverViewController,
                                              matchesNavigationController,
                                              profileNavigationController];
    self.tabBarController.selectedIndex = 0;
    
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UITabBar appearance].tintColor = [UIColor orangeColor];
    [UITabBar appearance].barTintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    
    
    
    if (![PFUser currentUser]) {

        MCLoginViewController *loginViewController = [[MCLoginViewController alloc] init];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [self.tabBarController presentViewController:self.navigationController
                                            animated:YES
                                          completion:nil];
    }
    
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current Installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

@end
