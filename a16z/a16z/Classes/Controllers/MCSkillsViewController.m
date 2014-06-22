//
//  MCSkillsViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MCSkillsViewController.h"
#import "MCProfileManager.h"

@interface MCSkillsViewController ()

@end

@implementation MCSkillsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)didTouchUpInsideButton:(id)sender
{
    if (sender == self.doneButton) {
        // Save all of the user's information
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"name"] = [MCProfileManager sharedManager].name;
        currentUser[@"school"] = [MCProfileManager sharedManager].school;
        currentUser[@"phone"] = [MCProfileManager sharedManager].phone;
        
        NSData *imageData = UIImageJPEGRepresentation([MCProfileManager sharedManager].image, 0.05f);
        currentUser[@"image"] = imageData;
        
        NSMutableArray *skillz = [[NSMutableArray alloc] init];
        for (NSString *key in [[MCProfileManager sharedManager].skills allKeys]) {
            if ([[MCProfileManager sharedManager].skills[key]  isEqual: @(YES)]) {
                [skillz addObject:key];
            }
        }
        currentUser[@"skiils"] = [NSArray arrayWithArray:skillz];
        [currentUser saveInBackground];
        
        [self.navigationController.presentingViewController dismissViewControllerAnimated:YES
                                                                               completion:nil];
    } else {
        [self buttonLoginShit:sender];
    }
}

- (void) buttonLoginShit:(UIButton *)button
{
    NSString *skill = button.titleLabel.text;
    if ([[MCProfileManager sharedManager].skills[skill]  isEqual: @(NO)]) {
        NSMutableDictionary *newDict = [[MCProfileManager sharedManager].skills mutableCopy];
        newDict[skill] = @(YES);
        [MCProfileManager sharedManager].skills = newDict;
        
        [self selectButton: button];
    } else if ([[MCProfileManager sharedManager].skills[skill] isEqual: @(YES)]) {
        NSMutableDictionary *newDict = [[MCProfileManager sharedManager].skills mutableCopy];
        newDict[skill] = @(NO);
        [MCProfileManager sharedManager].skills = newDict;
        
        [self unselectButton:button];
    }

}

- (void) selectButton:(UIButton *)button
{
    button.backgroundColor = [UIColor colorWithRed:1
                                             green:1
                                              blue:1
                                             alpha:1.0];
    button.titleLabel.textColor = self.backgroundColor;
}

- (void) unselectButton:(UIButton*)button
{
    button.backgroundColor = [UIColor colorWithRed:0
                                             green:0
                                              blue:0
                                             alpha:0];
    button.titleLabel.textColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.backgroundColor = [UIColor colorWithRed:26/255.0
                                                green:188/255.0
                                                 blue:156/255.0
                                                alpha:1];
    self.view.backgroundColor = self.backgroundColor;
    self.doneButton.backgroundColor = [UIColor colorWithRed:22/255.0
                                                      green:160/255.0
                                                       blue:133/255.0
                                                      alpha:1.0];
    
    NSArray *buttons = @[self.backendButton,
                        self.iOSButton,
                        self.frontendButton,
                        self.androidButton,
                        self.hardwareButton,
                        self.designButton];
    
    for (UIButton *button in buttons) {
        button.layer.borderWidth = 2.0f;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.backgroundColor = [UIColor colorWithRed:0
                                                 green:0
                                                  blue:0
                                                 alpha:0];
        button.titleLabel.textColor = [UIColor whiteColor];
        
        button.layer.cornerRadius = 10;
    }
        
}

@end
