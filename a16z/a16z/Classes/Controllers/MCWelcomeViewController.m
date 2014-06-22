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
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
