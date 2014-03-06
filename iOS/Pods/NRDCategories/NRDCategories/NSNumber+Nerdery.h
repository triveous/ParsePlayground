//
//  NSNumber+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface NSNumber (Nerdery)

/**
 Returns an NSComparisonResult value that is the opposite of -[NSNumber compare:] (except for '==' which is the same).
 @param aNumber The number with which to compare the receiver.
 @return NSOrderedAscending if the value of aNumber is less than than the receiver’s, NSOrderedSame if they’re equal, and NSOrderedDescending if the value of aNumber is greater than the receiver’s.
 @author Jay Peyer
*/
- (NSComparisonResult)reverseCompare:(NSNumber *)aNumber;

@end
