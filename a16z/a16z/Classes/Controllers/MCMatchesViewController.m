//
//  MCMatchesViewController.m
//  a16z
//
//  Created by Comyar Zaheri on 6/21/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MCMatchesViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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
    [combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects) {
            NSMutableArray *matches = [NSMutableArray new];
            
            for (PFObject *match in objects) {
                if (match[@"matchee"] == [PFUser currentUser]) {
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MatchesTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MatchesTableViewCell"];
    }
    
    PFUser *user = self.matches[indexPath.section];
    cell.textLabel.text = user[@"name"];
    cell.detailTextLabel.text = user[@"school"];
    cell.imageView.image = [UIImage imageWithData:user[@"image"]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.matches count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


@end
