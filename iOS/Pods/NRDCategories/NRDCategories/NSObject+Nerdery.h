//
//  NSObject+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface NSObject (Nerdery)

/*!
 @methodgroup Invocation Convenience
 */
#pragma mark - Invocation Convenience

/*!
 Create an invocation for an arbitrary selector on receiver with the given object as a parameter (beware retain loops)
 @discussion Here is a snippet to create a baked invocation that could be called at any time during its stakeholders' lifecycles; in this case we'll call it immediately, zum beispiel:
 {@code
    SEL sel = NSSelectorFromString(boomBoxTrackSelectorString);
    NSInvocation *invocation = [boomBox invocationWithSelector:sel object:bodybodyMovinModelObject];
    [invocation invoke];
 }
 @param selector A selector supported by receiver
 @param object An object to send as a parameter to the selector invocation
 @return A prepared invocation
 @author Jesse Hemingway
 */
- (NSInvocation*)invocationWithSelector:(SEL)selector object:(NSObject*)object;

/**
 Create an invocation for an arbitrary selector on receiver with the objects in the given array as parameters
 @see invocationWithSelector:object: for general details.
 @param selector A selector supported by receiver
 @param object An array of objects to send as parameters to the selector invocation
 @return A prepared invocation
 @author Jesse Hemingway
 */
- (NSInvocation*)invocationWithSelector:(SEL)selector objects:(NSArray*)objects;

/**
 Create an invocation for an arbitrary selector on receiver with given primitive as a parameter
 @see invocationWithSelector:object: for general details.
 @param selector A selector supported by receiver
 @param primitive A primitive value to send as a parameter to the selector invocation
 @return A prepared invocation
 @author Jesse Hemingway
 */
- (NSInvocation*)invocationWithSelector:(SEL)selector primitive:(void*)primitive;

/*!
 @methodgroup Property Convenience
 */
#pragma mark - Property Convenience

/**
 Retrieve an array of all properties defined for receiver.
 @discussion Here is a useful example to automate continuous introspection (for us introverts):
 {@code
     NSArray *properties = [self allPropertyNames];
     for (NSString *propertyName in properties) {
         [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:nil];
     }
 }
 @return An array of properties names
 @author Jesse Hemingway
 */
- (NSArray*)allPropertyNames;

@end
