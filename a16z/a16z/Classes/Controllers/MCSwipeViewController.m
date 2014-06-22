//
//  MCSwipeViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <CRToast/CRToast.h>
#import "MCSwipeViewController.h"
#import "MCMatchProfileView.h"
#import "UIImage+ImageEffects.h"


@interface MCSwipeViewController ()

@property (nonatomic) UIPanGestureRecognizer    *panGestureRecognizer;

@property (nonatomic) PFUser    *currentMatchUser;
@property (nonatomic) PFUser    *nextMatchUser;

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
    
    self.rejectView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.rejectView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.nextProfileView];
    [self.view addSubview:self.acceptView];
    [self.view addSubview:self.rejectView];
    [self.view addSubview:self.currentProfileView];
}

- (void)didRecognizePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint delta = [gestureRecognizer translationInView:self.view];
    
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan ||
        gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        self.currentProfileView.center = CGPointMake(self.view.center.x + delta.x, self.view.center.y);
        
        CGFloat deltaPercent = MIN(1.0, 0.3 * CGRectGetWidth(self.view.bounds) / MIN(fabs(delta.x), 0.3 * CGRectGetWidth(self.view.bounds)));
        if (delta.x < 0.0) {
            // accept
            self.acceptView.alpha = 1.0;
            self.acceptView.backgroundColor = [UIColor colorWithRed:0.0 green:deltaPercent blue:0.0 alpha:1.0];
            self.rejectView.alpha = 0.0;
        } else if (delta.x > 0.0) {
            // reject
            self.rejectView.alpha = 1.0;
            self.rejectView.backgroundColor = [UIColor colorWithRed:deltaPercent green:0.0 blue:0.0 alpha:1.0];
            self.acceptView.alpha = 0.0;
        }
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled ||
               gestureRecognizer.state == UIGestureRecognizerStateFailed    ||
               gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        // Swiping right
        if (delta.x > 0.3 * CGRectGetWidth(self.view.bounds)) {
            [UIView animateWithDuration:0.3 animations:^{
                self.currentProfileView.frame = CGRectOffset(self.view.bounds, CGRectGetWidth(self.view.bounds), 0);
                self.rejectView.alpha = 0.0;
                self.acceptView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self incrementCurrentMatchUser];
                self.currentProfileView.frame = self.view.bounds;
            }];
            
        // Swiping left
        } else if (delta.x < -0.3 * CGRectGetWidth(self.view.bounds)) {
            [UIView animateWithDuration:0.3 animations:^{
                [self attemptToMatchUser:self.currentMatchUser];
                self.currentProfileView.frame = CGRectOffset(self.view.bounds, -CGRectGetWidth(self.view.bounds), 0);
                self.rejectView.alpha = 0.0;
                self.acceptView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self incrementCurrentMatchUser];
                self.currentProfileView.frame = self.view.bounds;
            }];
            
        // Let go of swipe early
        } else {
        
            [UIView animateWithDuration:0.3 animations:^{
                self.currentProfileView.frame = self.view.frame;
            } completion:^(BOOL finished) {
                self.rejectView.alpha = 0.0;
                self.acceptView.alpha = 0.0;
            }];
        }
    }
}

#define kwantsToBeMatched 1
#define kMatched 2
- (void) attemptToMatchUser:(PFUser *)user
{
    PFQuery *queryWantsToBeMatched = [PFQuery queryWithClassName:@"Match"];
    [queryWantsToBeMatched whereKey:@"matchee" equalTo:user];
    [queryWantsToBeMatched whereKey:@"matcher" equalTo:[PFUser currentUser]];
    [queryWantsToBeMatched whereKey:@"status" equalTo:@1];
    [queryWantsToBeMatched findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // TODO(matthewe): Maybe you should handle errors yo.
        } else {
            if (objects.count > 0) {
                // TODO(matthewe): You found a person. Should send a push notification to them?
                NSDictionary *options = @{
                                          kCRToastTextKey : @"You found a match!",
                                          kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                          kCRToastBackgroundColorKey : [UIColor blueColor],
                                          kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                                          kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                                          kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                                          kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight)
                                          };
                [CRToastManager showNotificationWithOptions:options
                                            completionBlock:^{
                                                NSLog(@"Completed");
                                            }];
                
                NSLog(@"Wow that user was looking for you. Found you someone.");
                PFObject *firstMatch = objects[0];
                firstMatch[@"status"] = @2;
                [firstMatch saveInBackground];
            } else {
                // There are no matches time to create a new match.
                NSLog(@"That user is not looking. Create match object.");
                PFObject *newMatch = [PFObject objectWithClassName:@"Match"];
                newMatch[@"matchee"] = [PFUser currentUser];
                newMatch[@"matcher"] = user;
                newMatch[@"status"] = @1;
                [newMatch saveInBackground];
            }
        }
    }];
     
}

- (void)reloadData
{
    self.currentMatchUser = [self.dataSource nextMatchUser];
    self.nextMatchUser = [self.dataSource nextMatchUser];
    
    [self updateProfileView:self.currentProfileView withUser:self.currentMatchUser];
    [self updateProfileView:self.nextProfileView withUser:self.nextMatchUser];
}

- (void)incrementCurrentMatchUser
{
    self.currentMatchUser = self.nextMatchUser;
    self.nextMatchUser = [self.dataSource nextMatchUser];
    
    [self updateProfileView:self.currentProfileView withUser:self.currentMatchUser];
    [self updateProfileView:self.nextProfileView withUser:self.nextMatchUser];
}

- (void)updateProfileView:(MCMatchProfileView *)profileView withUser:(PFUser *)user
{
    if (user) {
        profileView.imageView.image = [UIImage imageWithData:user[@"image"]];
        profileView.nameLabel.text = user[@"name"];
        profileView.schoolLabel.text = user[@"school"];
    } else {
        profileView.imageView.image = nil;
        profileView.nameLabel.text = nil;
        profileView.schoolLabel.text = nil;
    }
}

@end
