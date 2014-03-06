//
//  NSData+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "NSData+Nerdery.h"


@implementation NSData (Nerdery)

// Inspiration from: http://iphonedevelopertips.com/cocoa/obfuscation-encryption-of-string-nsstring.html
- (void)obfuscateOrDeobfuscateWithKey:(NSString *)key
{
    // Get pointer to data to obfuscate
    char *dataPtr = (char *) [self bytes];
    
    // Get pointer to key data
    char *keyData = (char *) [[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    // Points to each char in sequence in the key
    char *keyPtr = keyData;
    int keyIndex = 0;
    
    // For each character in data, xor with current value in key
    for (int x = 0; x < [self length]; x++) {
        // Replace current character in data with current character xor'd with current key value.
        // Bump each pointer to the next character.
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        
        // If at end of key data, reset count and set key pointer back to start of key value
        if (++keyIndex == [key length]) {
            keyIndex = 0, keyPtr = keyData;
        }
    }
}

- (NSString *)hexString
{
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([self length] * 2)];
    const unsigned char *dataBuffer = [self bytes];
    for (NSUInteger index = 0; index < [self length]; index++) {
        [stringBuffer appendFormat:@"%02X", (unsigned char)dataBuffer[index]];
    }
    return [stringBuffer copy];
}

@end
