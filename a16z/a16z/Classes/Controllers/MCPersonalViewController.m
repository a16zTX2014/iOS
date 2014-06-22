//
//  MCPersonalViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCPersonalViewController.h"
#import "MCSkillsViewController.h"
#import "MCProfileManager.h"

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
    
}

- (IBAction)didTouchUpInsideButton:(id)sender {
    if (sender == self.nextButton) {
        [MCProfileManager sharedManager].name = self.nameTextField.text;
        [MCProfileManager sharedManager].school = self.schoolTextField.text;

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
        [self.schoolTextField resignFirstResponder];
    }
    return YES;
}

@end
