//
//  NSNumber+Nerdery.m
//
//  Copyright (c) 2012 The Nerdery. All rights reserved.
//

#import "NSNumber+Nerdery.h"

@implementation NSNumber (Nerdery)

- (NSComparisonResult)reverseCompare:(NSNumber *)aNumber
{
    return [aNumber compare:self];
}

@end
