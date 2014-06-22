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
#import "MCProfileCreationManager.h"

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
        currentUser[@"name"] = [MCProfileCreationManager sharedManager].name;
        currentUser[@"school"] = [MCProfileCreationManager sharedManager].school;
        currentUser[@"phone"] = [MCProfileCreationManager sharedManager].phone;
        
        NSData *imageData = UIImageJPEGRepresentation([MCProfileCreationManager sharedManager].image, 0.05f);
        currentUser[@"image"] = imageData;
        
        NSMutableArray *skillz = [[NSMutableArray alloc] init];
        for (NSString *key in [[MCProfileCreationManager sharedManager].skills allKeys]) {
            if ([[MCProfileCreationManager sharedManager].skills[key]  isEqual: @(YES)]) {
                [skillz addObject:key];
            }
        }
        currentUser[@"skills"] = [NSArray arrayWithArray:skillz];
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
    if ([[MCProfileCreationManager sharedManager].skills[skill]  isEqual: @(NO)]) {
        NSMutableDictionary *newDict = [[MCProfileCreationManager sharedManager].skills mutableCopy];
        newDict[skill] = @(YES);
        [MCProfileCreationManager sharedManager].skills = newDict;
        [self selectButton: button];
        
    } else if ([[MCProfileCreationManager sharedManager].skills[skill] isEqual: @(YES)]) {
        NSMutableDictionary *newDict = [[MCProfileCreationManager sharedManager].skills mutableCopy];
        newDict[skill] = @(NO);
        [MCProfileCreationManager sharedManager].skills = newDict;
        [self unselectButton:button];
    }

}

- (void) selectButton:(UIButton *)button
{
    button.titleLabel.textColor = self.backgroundColor;
    button.backgroundColor = [UIColor colorWithRed:1
                                             green:1
                                              blue:1
                                             alpha:1.0];
}

- (void) unselectButton:(UIButton*)button
{
    button.titleLabel.textColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor colorWithRed:0
                                             green:0
                                              blue:0
                                             alpha:0];
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
