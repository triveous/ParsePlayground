//
//  STKAllUsersViewController.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKAllUsersViewController.h"
#import "STKFormViewController.h"
#import "STKApiConstants.h"

static NSString * const kCellID = @"cellID";

@interface STKAllUsersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *users;

@end

@implementation STKAllUsersViewController

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

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:kUserUsername];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Oops"
                                        message:[NSString stringWithFormat:@"This went wrong: %@", error.localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"Go Away"
                              otherButtonTitles:nil] show];
        } else {
            self.users = objects;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    PFUser *user = self.users[indexPath.row];
    
    cell.textLabel.text = user.username;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[STKFormViewController alloc] initWithUser:self.users[indexPath.row]] animated:YES];
}

@end
