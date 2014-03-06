//
//  NSMutableDictionary+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//


@interface NSMutableDictionary (Nerdery)

/**
 Sets the given object, or [NSNull null] if it is nil, for the given key in the reciever.
 @discussion This is useful when generating dictionaries to turn into JSON.
 @param anObject The object to set, or nil.
 @param aKey The key to associate the object/null with 
 @author Jay Peyer
*/
- (void)setNullOrObject:(id)anObject forKey:(id)aKey;

/**
 Sets the given object, or an empty string @"" if it is nil, for the given key in the reciever.
 @discussion This is useful when generating dictionaries to turn into JSON.
 @param anObject The object to set, or nil.
 @param aKey The key to associate the object/null with 
 @author Jay Peyer
*/
- (void)setEmptyStringOrObject:(id)anObject forKey:(id)aKey;

/*!
 Sets the given object, or `[NSNumber numberWithInt:0]` if it is @c nil, for the given key in the reciever.
 @discussion This is useful when generating dictionaries to turn into JSON.
 @param anObject The object to set, or nil.
 @param aKey The key to associate the object/null with 
 @author Jay Peyer
*/
- (void)setZeroOrObject:(id)anObject forKey:(id)aKey;

@end
