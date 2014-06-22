//
//  MCMatchDetailViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/22/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCMatchDetailViewController.h"
#import "MCMatchProfileView.h"

@interface MCMatchDetailViewController ()

@property (nonatomic) MCMatchProfileView *profileView;

@end

@implementation MCMatchDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.profileView = [[MCMatchProfileView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.profileView];
    
}

@end
