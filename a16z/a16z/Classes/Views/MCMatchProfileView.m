//
//  MCMatchProfileView.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCMatchProfileView.h"

@implementation MCMatchProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"MCMatchProfileView" owner:nil options:nil];
    
    if ([views count] == 0) {
        return nil;
    }
    
    self = views[0];
    self.frame = frame;
    
    self.imageView.layer.cornerRadius = 0.5 * CGRectGetWidth(self.imageView.bounds);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    
    return self;
}

@end
