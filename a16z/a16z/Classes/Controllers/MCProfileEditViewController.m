//
//  MCProfileEditViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/22/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCProfileEditViewController.h"
#import <Parse/Parse.h>

@interface MCProfileEditViewController () <UITextFieldDelegate>

@property (nonatomic) UITextField *textField;

@end

@implementation MCProfileEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Edit";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(8, 72, CGRectGetWidth(self.view.bounds) - 16.0, 44.0)];
    self.textField.keyboardType = UIKeyboardTypeAlphabet;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.editType == MCProfileEditNameType) {
        [PFUser currentUser][@"name"] = textField.text;
    } else if (self.editType == MCProfileEditSchoolType) {
        [PFUser currentUser][@"school"] = textField.text;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (self.editType == MCProfileEditNameType) {
        self.textField.text = [PFUser currentUser][@"name"];
    } else if (self.editType == MCProfileEditSchoolType) {
        self.textField.text = [PFUser currentUser][@"school"];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[PFUser currentUser]saveInBackground];
    [self.textField resignFirstResponder];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
