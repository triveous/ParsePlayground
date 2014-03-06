//
//  STKLoginViewController.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKLoginViewController.h"
#import "STKFormViewController.h"

@interface STKLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation STKLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Log In";
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
        
        [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"Error"
                                            message:[NSString stringWithFormat:@"Something went wrong. This: %@", error.localizedDescription]
                                           delegate:nil
                                  cancelButtonTitle:@"Get out of here"
                                  otherButtonTitles:nil] show];
            } else {
                STKFormViewController *form = [[STKFormViewController alloc] initWithUser:nil];
                [self.navigationController pushViewController:form animated:YES];
            }
        }];
        
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Bah!"
                                    message:@"Username and Password required."
                                   delegate:nil
                          cancelButtonTitle:@"Alright"
                          otherButtonTitles:nil] show];
    }
}

- (BOOL)formValidated
{
    BOOL valid = YES;
    
    if (![self.username hasText]) {
        valid = NO;
    }
    
    if (![self.password hasText]) {
        valid = NO;
    }
    
    return valid;
}

- (IBAction)backgroudTap:(id)sender
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

@end
