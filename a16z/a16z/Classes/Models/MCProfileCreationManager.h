//
//  MCProfileManager.h
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCProfileCreationManager : NSObject

+ (MCProfileCreationManager *)sharedManager;

@property (nonatomic) NSString      *name;
@property (nonatomic) UIImage       *image;
@property (nonatomic) NSString      *school;
@property (nonatomic) NSString      *phone;
@property (nonatomic, copy) NSDictionary  *skills;

@end
