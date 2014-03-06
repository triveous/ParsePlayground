//
//  UIImage+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface UIImage (Nerdery)

/**
 Undocumented
 @param view UNDOCUMENTED
 @author Thomas Martin
 @return An Image
*/
+ (UIImage *)imageFromView:(UIView *)view;

/**
 Undocumented
 @param view UNDOCUMENTED
 @param newSize UNDOCUMENTED
 @param contentMode UNDOCUMENTED 
 @author Thomas Martin
 @return An Image
 */
+ (UIImage *)imageFromView:(UIView *)view scaledToSize:(CGSize)newSize usingContentMode:(UIViewContentMode)contentMode;

/**
 Undocumented
 @param image UNDOCUMENTED
 @param newSize UNDOCUMENTED
 @param contentMode UNDOCUMENTED 
 @author Thomas Martin
 @return An Image
 */
+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize usingContentMode:(UIViewContentMode)contentMode;

/**
 Undocumented
 @author Thomas Martin
 @return An Image
 */
+ (UIImage *)screenshot NS_DEPRECATED_IOS(2_0, 7_0);

/**
 Undocumented
 @author Thomas Martin
 @return An Image
 */
- (UIImage *)fixOrientation;

@end
