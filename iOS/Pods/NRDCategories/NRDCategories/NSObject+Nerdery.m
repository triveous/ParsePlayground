//
//  NSObject+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//


#import <objc/runtime.h>
#import "NSObject+Nerdery.h"


@implementation NSObject (Nerdery)

- (NSInvocation*) invocationWithSelector:(SEL)selector object:(NSObject*)object
{
	NSArray *array = object ? [NSArray arrayWithObject:object] : nil;
	return [self invocationWithSelector:selector objects:array];
}

- (NSInvocation*) invocationWithSelector:(SEL)selector objects:(NSArray*)objects 
{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:self];
	for (int i = 0; i < objects.count; i++) {
		NSObject *object = [objects objectAtIndex:i];
		[invocation setArgument:&object atIndex:i + 2];
	}

    return invocation;
}

- (NSInvocation*) invocationWithSelector:(SEL)selector primitive:(void*)object
{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:self];
	[invocation setArgument:object atIndex:2];
	
    return invocation;
}

- (NSArray*)allPropertyNames
{
    NSString *propertyName;
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [array addObject:propertyName];
    }
    free(properties);
    
    return array;
}

@end
