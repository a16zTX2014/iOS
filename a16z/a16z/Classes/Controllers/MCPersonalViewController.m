//
//  MCPersonalViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCPersonalViewController.h"
#import "MCSkillsViewController.h"

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
    
}

- (IBAction)didTouchUpInsideButton:(id)sender {
    if (sender == self.nextButton) {
        MCSkillsViewController *skillsViewController = [[MCSkillsViewController alloc] init];
        [self.navigationController pushViewController:skillsViewController animated:YES];
    }
}


@end
