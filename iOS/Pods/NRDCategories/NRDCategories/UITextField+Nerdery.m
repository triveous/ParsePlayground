//
//  UITextField+Nerdery.m
//
//  Copyright (c) 2012 The Nerdery. All rights reserved.
//

#import "UITextField+Nerdery.h"

@implementation UITextField (Nerdery)

- (BOOL)hasText
{
    NSString *trimmedOfWhiteSpaceAndNewlines = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedOfWhiteSpaceAndNewlines isEqualToString:@""] || self.text == nil) {
        return NO;
    } else {
        return YES;
    }
}


@end
