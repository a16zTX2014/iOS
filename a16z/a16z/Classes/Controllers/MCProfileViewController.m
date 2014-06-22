//
//  MCProfileViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/22/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCProfileViewController.h"
#import <Parse/Parse.h>

@interface MCProfileViewController ()

@property (nonatomic) UITableView *tableView;

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
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Basic Information";
    }
    return nil;
}


@end
