//
//  MCLoginViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Parse/Parse.h>
#import "MCLoginViewController.h"

@interface MCLoginViewController ()

@end

@implementation MCLoginViewController

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
    
    // Delegate shit
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [self.signinButton setEnabled:NO];
    [self.signupButton setEnabled:NO];
    
    // SigninButton Styling
    self.signinButton.backgroundColor = [UIColor colorWithRed:8/255.0
                                                        green:60/255.0                                                blue:188/255.0                                 alpha:.2];
    self.signinButton.layer.cornerRadius = 10;
    [self.signinButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
    
    // SignupButton Styling
    self.signupButton.backgroundColor = [UIColor colorWithRed:216/255.0
                                                        green:27/255.0                                               blue:20/255.0                                 alpha:.2];
    self.signupButton.layer.cornerRadius = 10;
    [self.signupButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)didChangeUsernameField:(id)sender {
    NSString *usernameText = self.usernameTextField.text;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:usernameText];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count > 0) {
                [self highlightSignin];
            } else {
                [self highlightSignup];
            }
        } else {
            // TODO(matthewe): Fuck this failed. What should we do?
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void) highlightSignin
{
    [self.signinButton setEnabled:YES];
    self.signinButton.backgroundColor = [UIColor colorWithRed:8/255.0
                                                        green:60/255.0                                                blue:188/255.0                                 alpha:.7];
    [self.signupButton setEnabled:YES];
    self.signupButton.backgroundColor = [UIColor colorWithRed:216/255.0
                                                        green:27/255.0                                               blue:20/255.0                                 alpha:.2];
}

- (void) highlightSignup
{
    [self.signinButton setEnabled:NO];
    self.signinButton.backgroundColor = [UIColor colorWithRed:8/255.0
                                                        green:60/255.0                                                blue:188/255.0                                 alpha:.2];
    [self.signupButton setEnabled:YES];
    self.signupButton.backgroundColor = [UIColor colorWithRed:216/255.0
                                                        green:27/255.0                                               blue:20/255.0                                 alpha:.7];
}

- (IBAction)didTouchUpInsideButton:(UIButton *)sender {
    // TODO(matthewe): Hook up buttons
    NSLog(@"touchedUpInsideThatShit");
    
    if (sender == self.signinButton) {
        [self attemptToSignUserIn];
    } else if (sender == self.signupButton) {
        [self attemptToSignUserUp];
    }
    return;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    if(textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

- (void) attemptToSignUserIn
{
    // Check to make sure the username textfield has been filled out
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [self displayAlert:@"You need to enter a username."];
        return;
    }
         
    // Check to make sure the password textfield has been filled out
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [self displayAlert:@"You need to enter a password."];
        return;
    }
    
    // Everything is valid at this point, attempt parse login
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text
                                 password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {     // User exists, present the main view
                                            NSLog(@"Log in successful");
                                            [self loginOrSignupSuccessful];
                                        } else {        // Login failed. Display error.
                                            // TODO(matthewe): Display more specific error message.
                                            [self displayAlert:@"Uh oh! Something messed up."];
                                        }
                                    }];
}

- (void) attemptToSignUserUp
{
    // TODO(matthewe): This logic is the same in both. Perhaps factor these checks out.
    // Check to make sure the username textfield has been filled out
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [self displayAlert:@"You need to enter a username."];
        return;
    }
    
    // Check to make sure the password textfield has been filled out
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [self displayAlert:@"You need to enter a password."];
        return;
    }
    
    PFUser *user = [PFUser user];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [self loginOrSignupSuccessful];
            NSLog(@"Log in successful");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [self displayAlert:errorString];
        }
    }];
}


- (void) loginOrSignupSuccessful
{
    // TODO(matthewe): Present the next stuff because the magic happened.
    NSLog(@"Present the next stuff. You should probably do this.");
}

- (void) displayAlert:(NSString *)alertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nice Try."
                                                    message:alertMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
