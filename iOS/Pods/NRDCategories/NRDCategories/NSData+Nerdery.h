//
//  NSData+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//


@interface NSData (Nerdery)

/**
 Obfuscates/de-obfuscates the data using the given key. Important note: The data is changed directly.
 @param key The key to use in the obfuscation/de-obfuscation routine.
 @author Jay Peyer
*/
- (void)obfuscateOrDeobfuscateWithKey:(NSString*)key;

/**
 *  A hex representation of the receiver.
 *
 *  @return A hex representation of the receiver.
 *  @author Minh Vu
 */
- (NSString *)hexString;

@end
