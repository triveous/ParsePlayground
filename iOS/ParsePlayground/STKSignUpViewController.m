//
//  STKSignUpViewController.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKSignUpViewController.h"
#import "STKFormViewController.h"

@interface STKSignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation STKSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Sign Up";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitTapped:(id)sender
{
    if ([self formValidated]) {
        [self createUser];
    }
}

- (void)createUser
{
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    if ([self.email hasText]) {
        user.email = self.email.text;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[NSString stringWithFormat:@"This happened: %@", error.localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"Fine."
                              otherButtonTitles:nil] show];
        } else {
            STKFormViewController *form = [[STKFormViewController alloc] initWithUser:user];
            [self.navigationController pushViewController:form animated:YES];
        }
    }];
}

- (BOOL)formValidated
{
    BOOL result = YES;
    if (![self.username hasText]) {
        result = NO;
    }
    
    if (![self.password hasText]) {
        result = NO;
    }
    
    if (!result) {
        [[[UIAlertView alloc] initWithTitle:@"Fill out the fields!"
                                    message:@"Username and Password required"
                                   delegate:nil
                          cancelButtonTitle:@"Abide"
                          otherButtonTitles:nil] show];
    }
    
    return result;
}

- (IBAction)backgroundTap:(id)sender
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.email resignFirstResponder];
}

@end
