//
//  MCSwipeViewController.h
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MCMatchProfile;

@protocol MCSwipeDataSource <NSObject>

- (MCMatchProfile *)nextMatchProfile;

@end



@interface MCSwipeViewController : UIViewController

@property (nonatomic) id<MCSwipeDataSource> dataSource;

@end
