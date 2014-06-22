//
//  MatchProfileTableViewCell.m
//  a16z
//
//  Created by Comyar Zaheri on 6/22/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCMatchProfileTableViewCell.h"

@implementation MCMatchProfileTableViewCell

- (void)awakeFromNib
{
    self.profileImageView.layer.cornerRadius = 0.5 * CGRectGetWidth(self.profileImageView.bounds);
    self.profileImageView.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{

}

- (IBAction)callButtonSelected:(id)sender {
    // TODO(matthewe): Does this work? I don't actually know because simulator doesn't have. 
    NSLog(@"Call Button Selected. But currently cannot call on simulator.");
    NSString *phoneNumber = [@"telprompt:" stringByAppendingString:self.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
