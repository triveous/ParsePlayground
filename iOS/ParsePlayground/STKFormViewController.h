//
//  STKFormViewController.h
//  ParsePlayground
//
//  Created by Sean Kladek on 3/5/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STKFormViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

- (instancetype)initWithUser:(PFUser *)user;

@end
