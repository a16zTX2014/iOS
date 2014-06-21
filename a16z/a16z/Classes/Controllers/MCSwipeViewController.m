//
//  MCSwipeViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCSwipeViewController.h"
#import "MCMatchProfileView.h"

@interface MCSwipeViewController ()

@property (nonatomic) UIPanGestureRecognizer    *panGestureRecognizer;

@property (nonatomic) MCMatchProfileView *currentProfileView;
@property (nonatomic) MCMatchProfileView *nextProfileView;

@property (nonatomic) UIView *acceptView;
@property (nonatomic) UIView *rejectView;

@end



@implementation MCSwipeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didRecognizePanGesture:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    self.nextProfileView = [[MCMatchProfileView alloc]initWithFrame:self.view.frame];
    self.currentProfileView = [[MCMatchProfileView alloc]initWithFrame:self.view.frame];
    
    self.acceptView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.acceptView.backgroundColor = [UIColor greenColor];
    self.acceptView.alpha = 0.0;
    
    self.rejectView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.rejectView.backgroundColor = [UIColor redColor];
    self.rejectView.alpha = 0.0;
    
    [self.view addSubview:self.nextProfileView];
    [self.view addSubview:self.acceptView];
    [self.view addSubview:self.rejectView];
    [self.view addSubview:self.currentProfileView];
}

- (void)didRecognizePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint delta = [gestureRecognizer locationInView:self.view];
    
    
    
}


@end
