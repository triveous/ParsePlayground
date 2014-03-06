//
//  UIAlertView+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface UIAlertView (Nerdery)

/**
 Convenience method for displaying a typical alert dialog
 @discussions Other variations would be useful in the future.
 @param title The alert title
 @param message The alert message
 @param delegate The alert delegate
 @param dismissTitle The title of the dismiss button
 @return The resulting UIAlertView
 @author Jesse Hemingway
 */
+ (UIAlertView*)quickAlertWithTitle:(NSString*)title message:(NSString*)message delegate:(id<UIAlertViewDelegate>)delegate dismissButtonTitle:(NSString*)dismissTitle;

@end
