//
//  MCProfileViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/22/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCProfileViewController.h"
#import "MCProfileEditViewController.h"
#import <Parse/Parse.h>

@interface MCProfileViewController ()

@property (nonatomic) UITableView *tableView;

@property (nonatomic) MCProfileEditViewController *editViewController;

@end

@implementation MCProfileViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Profile";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    NSData *imageData = [PFUser currentUser][@"image"];
    
    UIView *imageViewContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 240.0)];
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:imageData]];
    self.imageView.frame = CGRectMake(0.0, 0.0, 180.0, 180.0);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 0.5 * CGRectGetWidth(self.imageView.bounds);
    self.imageView.layer.masksToBounds = YES;
    
    [imageViewContainer addSubview:self.imageView];
    self.imageView.center = imageViewContainer.center;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = imageViewContainer;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileTableViewCell"];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [PFUser currentUser][@"name"];
            cell.detailTextLabel.text = @"Name";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = [PFUser currentUser][@"school"];
            cell.detailTextLabel.text = @"School";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = [self formattedPhoneNumberWithString:[PFUser currentUser][@"phone"]];
            cell.detailTextLabel.text = @"Phone Number";
        }
    }
    
    return cell;
}

- (NSString *)formattedPhoneNumberWithString:(NSString *)phoneNumber
{
    if ([phoneNumber length] == 10) {
        return [NSString stringWithFormat:@"(%@) %@ - %@",
                [phoneNumber substringWithRange:NSMakeRange(0, 3)],
                [phoneNumber substringWithRange:NSMakeRange(3, 3)],
                [phoneNumber substringWithRange:NSMakeRange(6, 4)]];
    }
    return phoneNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Basic Information";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.editViewController) {
        self.editViewController = [MCProfileEditViewController new];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.editViewController.editType = MCProfileEditNameType;
        } else if (indexPath.row == 1) {
            self.editViewController.editType = MCProfileEditSchoolType;
        } else if (indexPath.row == 2) {
            self.editViewController.editType = MCProfileEditPhoneType;
        }
    }
    
    [self.navigationController pushViewController:self.editViewController animated:YES];
}


@end
