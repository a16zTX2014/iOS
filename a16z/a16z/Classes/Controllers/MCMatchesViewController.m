//
//  MCMatchesViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCMatchesViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "MCMatchProfileTableViewCell.h"
#import "UIImage+ImageEffects.h"

@interface MCMatchesViewController ()

@property (nonatomic) NSArray       *matches;
@property (nonatomic) UITableView   *tableView;

@end


@implementation MCMatchesViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Matches";
    }
    return self;
}

- (void)helpButtonSelected
{
    NSLog(@"Help button selected.");
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"skills" equalTo:@"Help"];
    [query whereKey:@"username" notEqualTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // Whelp shit.
        } else {
            NSMutableArray *matches = [NSMutableArray new];
            
            for (PFObject *user in objects) {
                [matches addObject:user];
            }
            
            self.matches = matches;
            [self.tableView reloadData];
        }
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.opaque = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSData *imageData = [PFUser currentUser][@"image"];
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[[UIImage imageWithData:imageData] applyExtraLightEffect]];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.frame = self.view.frame;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 64.0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64.0) style:UITableViewStylePlain];
    self.tableView.rowHeight = 120;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = backgroundImageView;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *helpButton = [[UIBarButtonItem alloc] initWithTitle:@"Help"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(helpButtonSelected)];
    self.navigationItem.rightBarButtonItem = helpButton;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.animationType = MBProgressHUDAnimationFade;
    HUD.labelText = @"Updating";
    HUD.minShowTime = 1.0;
    
    
    PFQuery *queryMatchee = [PFQuery queryWithClassName:@"Match"];
    PFQuery *queryMatcher = [PFQuery queryWithClassName:@"Match"];
    [queryMatchee whereKey:@"matchee" equalTo:[PFUser currentUser]];
    [queryMatcher whereKey:@"matcher" equalTo:[PFUser currentUser]];
    
    PFQuery *combinedQuery = [PFQuery orQueryWithSubqueries:@[queryMatchee, queryMatcher]];
    [combinedQuery whereKey:@"status" equalTo:@(2)];
    [combinedQuery includeKey:@"matchee"];
    [combinedQuery includeKey:@"matcher"];
    [combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects) {
            NSMutableArray *matches = [NSMutableArray new];
            
            for (PFObject *match in objects) {
                if ([((PFUser *)match[@"matchee"]).username isEqualToString:[PFUser currentUser].username]) {
                    [matches addObject:match[@"matcher"]];
                } else {
                    [matches addObject:match[@"matchee"]];
                }
            }
            
            self.matches = matches;
            [self.tableView reloadData];
        } else {
            // fucked up
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (MCMatchProfileTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCMatchProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MatchesTableViewCell"];
    if (!cell) {
        NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"MCMatchProfileTableViewCell" owner:nil options:nil];
        if ([views count] > 0) {
            cell = views[0];
            cell.callButton.layer.cornerRadius = 4.0;
            cell.callButton.layer.borderWidth = 1.0;
            cell.callButton.layer.borderColor = [UIColor colorWithWhite:0.76/255.0 alpha:1.0].CGColor;
            
            cell.textButton.layer.cornerRadius = 4.0;
            cell.textButton.layer.borderWidth = 1.0;
            cell.textButton.layer.borderColor = [UIColor colorWithWhite:0.76/255.0 alpha:1.0].CGColor;
        }
    }
    
    PFUser *user = self.matches[indexPath.row];
    NSArray *skills = [user valueForKey:@"skills"];
    if (skills != NULL) {
        if ([skills containsObject:@"Help"]) {
            NSLog(@"NO");
            cell.helperLabel.hidden = NO;
            cell.helperLabel.layer.cornerRadius = 6;
        } else {
            cell.helperLabel.hidden = YES;
            NSLog(@"YES");
        }
    } else {
        cell.helperLabel.hidden = YES;
    }
    
    cell.nameLabel.text = user[@"name"];
    cell.schoolLabel.text = user[@"school"];
    cell.profileImageView.image = [UIImage imageWithData:user[@"image"]];
    cell.phoneNumber = user[@"phone"];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.matches count];
}


@end
