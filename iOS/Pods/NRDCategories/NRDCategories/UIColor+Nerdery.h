//
//  UIImage+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface UIColor (Nerdery)

/**
 Returns a UIColor with the RGB Hex. Alpha is set to 1.0
 @param rgbValue The value is in the the format 0xRRGGBB
 @return A UIColor with the appropriate color
 @author Jon Rexeisen
*/
+ (UIColor*)colorWithHex:(uint)rgbValue;

/**
 Returns a UIColor with the RGB Hex
 @param rgbValue The value is in the the format 0xRRGGBB
 @param alpha A value from 0.0 to 1.0.
 @return A UIColor with the appropriate color with the alpha already set
 @author Jon Rexeisen
 */
+ (UIColor*)colorWithHex:(uint)rgbValue alpha:(float)alpha;

@end
