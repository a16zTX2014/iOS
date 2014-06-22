//
//  MCProfileManager.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCProfileManager.h"

@implementation MCProfileManager

- (instancetype)_init
{
    if (self = [super init]) {
        [self initializeSkills];
        _name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
        
        _school = [[NSUserDefaults standardUserDefaults]objectForKey:@"school"];
        
        NSData *imageData = [[NSUserDefaults standardUserDefaults]objectForKey:@"image"];
        if (imageData) {
            _image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        }
        
    }
    return self;
}

- (void)initializeSkills
{
    NSData *skillsData = [[NSUserDefaults standardUserDefaults]objectForKey:@"skills"];
    if (skillsData) {
        _skills = [NSKeyedUnarchiver unarchiveObjectWithData:skillsData];
    }
    if (!_skills) {
        NSMutableDictionary *skills = [NSMutableDictionary new];
        NSArray *skillList = @[@"iOS"];
        for (NSString *skill in skillList) {
            skills[skill] = @(NO);
        }
    }
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Cannot initialize singleton"
                                 userInfo:nil];
}

+ (MCProfileManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static MCProfileManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MCProfileManager alloc]_init];
    });
    return sharedManager;
}

- (void)setName:(NSString *)name
{
    _name = name;
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"name"];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"image"];
}

- (void)setSchool:(NSString *)school
{
    _school = school;
    [[NSUserDefaults standardUserDefaults]setObject:school forKey:@"school"];
}

- (void)setSkills:(NSDictionary *)skills
{
    if (skills) {
        _skills = skills;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:skills];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"skills"];
    }
}

@end
