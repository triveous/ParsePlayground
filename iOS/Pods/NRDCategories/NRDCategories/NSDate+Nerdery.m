//
//  NSDate+Nerdery.m
//
//  Copyright 2014 The Nerdery. All rights reserved.
//

#import "NSDate+Nerdery.h"

@implementation NSDate (Nerdery)

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = days;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    return [theCalendar dateByAddingComponents:dayComponent toDate:self options:0];
}

- (BOOL)isAfterDate:(NSDate *)comparisonDate
{
    return [self compare:comparisonDate] == NSOrderedDescending;
}

@end
