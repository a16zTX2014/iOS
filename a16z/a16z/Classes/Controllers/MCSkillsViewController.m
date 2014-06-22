//
//  MCSkillsViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Parse/Parse.h>
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

- (IBAction)didTouchUpInsideButton:(id)sender {
    if (sender == self.doneButton) {
        // Save all of the user's information
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"name"] = [MCProfileManager sharedManager].name;
        currentUser[@"school"] = [MCProfileManager sharedManager].school;
        
        NSData *imageData = UIImageJPEGRepresentation([MCProfileManager sharedManager].image, 0.05f);
        currentUser[@"image"] = imageData;
        [currentUser saveInBackground];
        
        [self.navigationController.presentingViewController dismissViewControllerAnimated:YES
                                                                               completion:nil];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
