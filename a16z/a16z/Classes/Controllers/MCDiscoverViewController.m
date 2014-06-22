//
//  MCDiscoverViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCDiscoverViewController.h"
#import "MCSwipeViewController.h"


@interface MCDiscoverViewController ()

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
    [self.swipeViewController willMoveToParentViewController:self];
    self.swipeViewController.view.frame = self.view.frame;
    [self.view addSubview:self.swipeViewController.view];
    [self addChildViewController:self.swipeViewController];
    [self.swipeViewController didMoveToParentViewController:self];
    
}

- (MCMatchProfileViewModel *)nextMatchProfileViewModel
{
    return nil;
}

@end
