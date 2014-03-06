//
//  NSDictionary+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//


@interface NSDictionary (Nerdery)

/**
 Returns the object for the given key, if it is in the dictionary, else nil.
 @discussion This is useful when using SBJSON, as that will return `[NSNull null]` if the value was @c null in the parsed JSON.
 @param aKey The key to use.
 @return The object or, if the object was not set in the dictionary or was NSNull, nil
*/
- (id)objectOrNilForKey:(id)aKey;

@end
