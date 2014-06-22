//
//  MCWelcomeViewController.m
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCWelcomeViewController.h"
#import "MCPersonalViewController.h"
#import "MCProfileManager.h"

@interface MCWelcomeViewController ()

@end

@implementation MCWelcomeViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:52/255.0
                                                green:152/255.0
                                                 blue:219/255.0
                                                alpha:1.0];
    self.nextButton.backgroundColor = [UIColor colorWithRed:41/255.0
                                                      green:128/255.0
                                                       blue:185/255.0
                                                      alpha:1.0];
    [self.nextButton setTitleColor:[UIColor colorWithRed:1.0
                             green:1.0
                              blue:1.0
                             alpha:0.5]
                          forState:UIControlStateNormal];
    self.nextButton.enabled = NO;
}

- (IBAction)didTouchUpInsideButton:(id)sender {
    // TODO(matthewe): Add another button and camera selection mode
    if (sender == self.cameraButton) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:nil];
    } else if (sender == self.nextButton) {
        // Save the image
        [MCProfileManager sharedManager].image = self.profileImageView.image;
        
        MCPersonalViewController *welcomeViewController = [[MCPersonalViewController alloc] init];
        [self.navigationController pushViewController:welcomeViewController animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.nextButton.enabled = YES;
    [self.nextButton setTitleColor:[UIColor colorWithRed:1.0
                             green:1.0
                              blue:1.0
                             alpha:1.0]
                          forState:UIControlStateNormal];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
