//
//  MCSkillsViewController.h
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSkillsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIButton *backendButton;
@property (weak, nonatomic) IBOutlet UIButton *iOSButton;
@property (weak, nonatomic) IBOutlet UIButton *frontendButton;
@property (weak, nonatomic) IBOutlet UIButton *androidButton;
@property (weak, nonatomic) IBOutlet UIButton *hardwareButton;
@property (weak, nonatomic) IBOutlet UIButton *designButton;

@property (weak, nonatomic) UIColor *backgroundColor;

@end
