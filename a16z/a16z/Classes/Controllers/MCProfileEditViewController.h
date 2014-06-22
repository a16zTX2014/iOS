//
//  MCProfileEditViewController.h
//  a16z
//
//  Created by Comyar Zaheri on 6/22/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCProfileEditType) {
    MCProfileEditNameType = 0,
    MCProfileEditSchoolType
};


@interface MCProfileEditViewController : UIViewController


@property (nonatomic) MCProfileEditType editType;

@end
