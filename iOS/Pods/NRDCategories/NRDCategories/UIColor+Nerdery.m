//
//  UIImage+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "UIColor+Nerdery.h"

@implementation UIColor (Nerdery)

+ (UIColor *)colorWithHex:(uint)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)colorWithHex:(uint)rgbValue alpha:(float)alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

@end
