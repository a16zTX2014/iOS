//
//  MCDiscoverViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCDiscoverViewController.h"
#import "MCSwipeViewController.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>


@interface MCDiscoverViewController ()

@property (nonatomic) NSMutableArray *discoverableUsers;
@property (nonatomic) MCSwipeViewController *swipeViewController;

@end



@implementation MCDiscoverViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Discover";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.swipeViewController = [[MCSwipeViewController alloc]initWithNibName:nil bundle:nil];
    self.swipeViewController.dataSource = self;
    [self.swipeViewController willMoveToParentViewController:self];
    self.swipeViewController.view.frame = self.view.frame;
    [self.view addSubview:self.swipeViewController.view];
    [self addChildViewController:self.swipeViewController];
    [self.swipeViewController didMoveToParentViewController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([PFUser currentUser] && ![self.discoverableUsers count]) {
        [self fetchDiscoverableUsers];
    }
}

- (void)fetchDiscoverableUsers
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.animationType = MBProgressHUDAnimationFade;
    HUD.labelText = @"Updating";
    HUD.minShowTime = 1.0;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" notEqualTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects) {
            self.discoverableUsers = [objects mutableCopy];
            [self.swipeViewController reloadData];
        } else {
            // fucked up
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (PFUser *)nextMatchUser
{
    PFUser *firstUser = [self.discoverableUsers firstObject];
    NSLog(@"%@", firstUser);
    if (firstUser) {
        [self.discoverableUsers removeObjectAtIndex:0];
    }
    return firstUser;
}

@end
