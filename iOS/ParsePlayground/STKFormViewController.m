//
//  STKFormViewController.m
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKFormViewController.h"
#import "STKPhotosDataSource.h"
#import "STKApiConstants.h"

@interface STKFormViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet STKPhotosDataSource *dataSource;

@property (strong, nonatomic) PFUser *user;

@end

@implementation STKFormViewController

- (instancetype)initWithUser:(PFUser *)user
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (user) {
            self.user = user;
        } else if ([PFUser currentUser]) {
            self.user = [PFUser currentUser];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Wait" message:@"Who are you? No user found" delegate:nil cancelButtonTitle:@"Go Find Yourself" otherButtonTitles:nil] show];
        }
        
        self.title = self.user.username;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutTapped:)];
    UIBarButtonItem *takePhoto = [[UIBarButtonItem alloc] initWithTitle:@"Photo" style:UIBarButtonItemStylePlain target:self action:@selector(cameraTapped:)];
    self.navigationItem.rightBarButtonItems = @[logout, takePhoto];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"STKPhotoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kPhotoCellID];
    
    self.username.text = self.user.username;
    self.password.text = self.user.password;
    self.email.text = self.user.email;
    self.firstName.text = self.user[kUserFirstName];
    self.lastName.text = self.user[kUserLastName];
    
    [self loadPhotos];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self saveUser];
    
}

- (void)logoutTapped:(id)sender
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cameraTapped:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)saveUser
{
    if ([PFUser currentUser] != self.user) {
        return;
    }
    
    self.user.username = self.username.text;
    [self.user setObject:self.firstName.text forKey:kUserFirstName];
    [self.user setObject:self.lastName.text forKey:kUserLastName];
    
    [self.user saveInBackground];
}

#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        image = [self scaledImage:image];
        NSData *imageData = UIImagePNGRepresentation(image);
        NSString *name = [NSString stringWithUUID];
        PFFile *imageFile = [PFFile fileWithName:name data:imageData];
        
        PFObject *imageObject = [PFObject objectWithClassName:kPhotoClassName];
        imageObject[kPhotoFile] = imageFile;
        imageObject[kPhotoUser] = self.user;
        
        [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"Ahhhhhh!"
                                            message:[NSString stringWithFormat:@"Error error: %@", error.localizedDescription]
                                           delegate:nil
                                  cancelButtonTitle:@"Thanks, robot"
                                  otherButtonTitles:nil] show];
            } else {
                [self loadPhotos];
            }
        }];
    }];
}

- (UIImage *)scaledImage:(UIImage *)image
{
    CGSize size = CGSizeMake(floorf(image.size.width / 4), floorf(image.size.height / 4));
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Blehhhhhh

- (void)loadPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassName];
    [query whereKey:kPhotoUser equalTo:self.user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dataSource.photos = objects;
        
        [self.collectionView reloadData];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
