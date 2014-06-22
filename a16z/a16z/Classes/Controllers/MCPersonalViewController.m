//
//  MCPersonalViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCPersonalViewController.h"
#import "MCSkillsViewController.h"
#import "MCProfileCreationManager.h"

@interface MCPersonalViewController ()

@end

@implementation MCPersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    self.schoolTextField.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:46/255.0
                                                green:204/255.0
                                                 blue:113/255.0
                                                alpha:1.0];
    self.nextButton.backgroundColor = [UIColor colorWithRed:39/255.0
                                                      green:174/255.0
                                                       blue:96/255.0
                                                      alpha:1.0];
    UIColor *placeholderColor = [UIColor colorWithRed:1.0
                                                green:1.0
                                                 blue:1.0
                                                alpha:0.5];
    
    // Really wanted to change the placeholder text color. Don't try this at home.
    [self.nameTextField setValue:placeholderColor
                      forKeyPath:@"_placeholderLabel.textColor"];
    [self.schoolTextField setValue:placeholderColor
                      forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTextField setValue:placeholderColor
                      forKeyPath:@"_placeholderLabel.textColor"];

}

- (IBAction)didTouchUpInsideButton:(id)sender {
    if (sender == self.nextButton) {
        [MCProfileCreationManager sharedManager].name = self.nameTextField.text;
        [MCProfileCreationManager sharedManager].school = self.schoolTextField.text;
        [MCProfileCreationManager sharedManager].phone = self.phoneTextField.text;

        MCSkillsViewController *skillsViewController = [[MCSkillsViewController alloc] init];
        [self.navigationController pushViewController:skillsViewController animated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.nameTextField) {
        [self.schoolTextField becomeFirstResponder];
    } else if (textField == self.schoolTextField) {
        [self.phoneTextField becomeFirstResponder];
    } else if (textField == self.phoneTextField) { 
        [self.phoneTextField resignFirstResponder];
    }
    return YES;
}

@end
