//
//  NSDictionary+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "NSDictionary+Nerdery.h"


@implementation NSDictionary (Nerdery)

- (id)objectOrNilForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
