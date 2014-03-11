//
//  STKMainViewController.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKMainViewController.h"
#import "STKLoginViewController.h"
#import "STKSignUpViewController.h"
#import "STKAllUsersViewController.h"
#import "STKFormViewController.h"
#import "STKAllPhotosViewController.h"

@interface STKMainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *currentUserButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *signUpInButtons;

@end

@implementation STKMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Main";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL isAuthenticated = [[PFUser currentUser] isAuthenticated];
    self.currentUserButton.enabled = isAuthenticated;
    
    for (UIButton *button in self.signUpInButtons) {
        button.enabled = !isAuthenticated;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)currentUserTapped:(id)sender
{
    [self pushUserForm];
}

- (IBAction)emailTapped:(id)sender
{
    STKLoginViewController *login = [[STKLoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)facebookTapped:(id)sender
{
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
        if (user) {
            [self pushUserForm];
        }
    }];
}

- (IBAction)twitterTapped:(id)sender
{
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (user) {
            [self pushUserForm];
        }
    }];
}

- (IBAction)allUsersTapped:(id)sender
{
    STKAllUsersViewController *allUsers = [[STKAllUsersViewController alloc] init];
    [self.navigationController pushViewController:allUsers animated:YES];
}

- (IBAction)signInTapped:(id)sender
{
    STKSignUpViewController *signUp = [[STKSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUp animated:YES];
}

- (IBAction)allPhotosTapped:(id)sender
{
    STKAllPhotosViewController *photos = [[STKAllPhotosViewController alloc] init];
    [self.navigationController pushViewController:photos animated:YES];
}

- (void)pushUserForm
{
    STKFormViewController *form = [[STKFormViewController alloc] initWithUser:nil];
    [self.navigationController pushViewController:form animated:YES];
}

- (IBAction)anonUser:(id)sender
{
    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (user) {
            [self pushUserForm];
        } else {
            DLog(@"Error: %@", error);
        }
    }];
}

@end
