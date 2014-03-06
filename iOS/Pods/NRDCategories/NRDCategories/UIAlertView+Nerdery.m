//
//  UIAlertView+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "UIAlertView+Nerdery.h"


@implementation UIAlertView (Nerdery)

+ (UIAlertView*)quickAlertWithTitle:(NSString*)title message:(NSString*)message delegate:(id<UIAlertViewDelegate>)delegate dismissButtonTitle:(NSString*)dismissTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                      delegate:delegate 
                             cancelButtonTitle:dismissTitle
                             otherButtonTitles:nil];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [alert show];
    }];
    return alert;
}



@end
