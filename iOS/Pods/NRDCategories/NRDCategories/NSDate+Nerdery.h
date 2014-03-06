//
//  NSDate+Nerdery.h
//
//  Copyright 2014 The Nerdery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Nerdery)

/**
 *  Returns a date from the current date by adding the number of days.
 *
 *  @param days The number of days to add.
 *
 *  @return The new @c NSDate.
 *  @author Erik Weiss
 */
- (NSDate *)dateByAddingDays:(NSInteger)days;

/**
 *  Helper function to determine if the date is after another.
 *  Improved readability over the regular comparisons.
 *
 *  @param comparisonDate The date to see if we're after.
 *
 *  @return @c YES if this date is after the @c comparisonDate.
 *  @author Erik Weiss
 */
- (BOOL)isAfterDate:(NSDate *)comparisonDate;

@end
