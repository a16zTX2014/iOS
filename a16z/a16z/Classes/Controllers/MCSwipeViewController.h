//
//  MCSwipeViewController.h
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@protocol MCSwipeDataSource <NSObject>

- (PFUser *)nextMatchUser;

@end


@interface MCSwipeViewController : UIViewController

- (void)reloadData;

@property (nonatomic) id<MCSwipeDataSource> dataSource;

@end
