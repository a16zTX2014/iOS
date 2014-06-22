//
//  MCPersonalViewController.h
//  a16z
//
//  Created by Matthew Ebeweber on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCPersonalViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end
