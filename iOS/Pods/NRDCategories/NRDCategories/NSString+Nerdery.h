//
//  NSString+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface NSString (Nerdery)

/**
 Returns the MD5 hash of the receiver.
 @return MD5 hash of the receiver
 @author Jay Peyer
*/
- (NSString*)MD5Hash;

/**
 Returns the SHA1 hash of the receiver.
 @return SHA1 hash of the receiver
 @author Jay Peyer
 */
- (NSString*)SHA1Hash;

/**
 Checks to see if the receiver is not empty string (@"").
 @return YES if the receiver is not empty string (@""), else NO.
 @author Jay Peyer
 */
- (BOOL)isNotEmpty;


/*!
 TODO: Is this ifdef checking for an IOS SDK version?  Better to check for selector presence; can we define this method either way? [jhemingw]
 */
#ifdef UI_USER_INTERFACE_IDIOM

/**
 Calculates the best font size to fit a given string into specific size.
 @param font Font type to be returned
 @param minimumFontSize The minimum font size. Must be greater than 0
 @param constrainedSize Dimensions that the font must fit in.
 @return A UIFont object correctly sized for the constraining area
 @author Ben Dolmar
 */
- (UIFont*)fittedFontSizeForFont:(UIFont *)font minimumFontSize:(CGFloat)minimumFontSize contrainedToSize:(CGSize)constrainedSize;

#endif


/**
 Returns a path to the documents directory with given path appended to the end (using -[NSString stringByAppendingPathComponent:]).
 @param path The path to append to the end of the NSDocuments directory
 @return A NSString path to the documents directory with given path appended to the end (using -[NSString stringByAppendingPathComponent:]).
 @author Jay Peyer
 */
+ (NSString*)documentsDirectoryWithAppendedPath:(NSString *)path;

/**
 Returns a new UUID string, created using CFUUID.
 @return A new UUID string.
 @see CFUUID
 @author Jay Peyer
 */
+ (NSString*)stringWithUUID;

/**
 Returns a normalized version of the receiver.
 @discussion First uses CFStringNormalize with parameter kCFStringNormalizationFormD.
 Then folds the string to remove case distinctions, accents and other diacritics, and normalize width (by mapping 
 characters in the range U+FF00-U+FFEF to their ordinary equivalents).
 @return A normalized version of the receiver.
 @see CFStringNormalize
 @see CFStringFold
 @see https://devforums.apple.com/message/363871#363871
 @author Jay Peyer
 */
- (NSString*)normalizedString;

/**
 Returns the string created by deobfuscating the given bytes & length (obfuscated using -[NSData(Nerdery) obfuscateOrDeobfuscateWithKey:]) using the given key.
 @discussion Relies on NRDCategory defined in NSData+Nerdery.
 @param bytes The obfuscated bytes (obfuscated using -[NSData(Nerdery) obfuscateOrDeobfuscateWithKey:])
 @param length The length of the obfuscated bytes
 @param key The key to deobfuscate the data
 @return The deobfuscated string
 @see NSData+Nerdery
 @author Jay Peyer
 */
+ (NSString*)deobfuscatedStringWithBytes:(const void *)bytes length:(NSUInteger)length key:(NSString *)key;

/**
 Is this NSString a valid email address?
 @return YES if valid, NO if invalid
 @author Josh Klun
 */
- (BOOL)isValidEmailAddress;

/**
 Compare two version strings in dotted form <major>.<minor>[.<build>[.<revision>[...]]]. If the dotted component counts do not match, "0" will be assumed for each position in the string with fewer components.
 @return An NSComparisonResult indicating whether versionA is less than, equal to or greater than versionB
 @author Jesse Hemingway
 */
+ (NSComparisonResult)compareVersionString:(NSString*)versionA toString:(NSString*)versionB;

/**
 This method returns the device model as a string representation in the form <device><generation>,<sub-generation>, although this is not particularly consistent.  
 @discussion An updated list of common model strings is out of scope for this discussion.  For more complete solutions, check out http://github.com/erica/uidevice-extension/.  Note that this should NOT be used to determine feature availability.  This should only be used to predict levels of hardware performance not easily queried or measured, or for custom analytics.  This is a simple implementation that relies on a call to uname(), if you want to look it up.
 @return A string representing the device model
 @author Jesse Hemingway
 */
+ (NSString*)deviceModelAsString;

/**
 Formats a time interval into a string representation
 @return A time interval formatted as hh:mm:ss
 @author Jesse Hemingway
 */
+ (NSString*)stringWithDuration:(NSTimeInterval)duration;

/*!
 @methodgroup Simple CSV Parsing
 */
#pragma mark - Simple CSV Parsing

/**
 Block callback definition for use with parseCSVWithDelimiterSet:lineComplete
 @param fields An array of fields parsed sequentially for the current line
 @param error Parse error, if any (unimplemented)
 @return YES to abort processing; NO otherwise
 */
typedef BOOL (^NRDCSVParserLineCompleteBlock)(NSArray *fields, NSError *error);

/**
 Parse a common subset of CSV formatted files to extract fields on a line-by-line basis to be processed by the caller supplied block.
 @discussion Handles quoted values delimted by double-quoted characters only.  Error reporting is not implemented.  Code example:
 {@code
    __block NSInteger nRecordsProcessed = 0;
    NRDCSVParserLineCompleteBlock block = ^BOOL(NSArray *fields, NSError *error) {
        if (nRecordsProcessed++ == 0) {
            // skip header row
            return NO;
        }
        // do stuff with the fields array
        return NO;
    };

    [recordsString parseCSVWithDelimiterSet: [NSCharacterSet characterSetWithCharactersInString:@","] lineComplete:block];
 }
 @param fieldDelimiter Characters to be treated as field delimiters.  Whitespace and newline sets are already handled.
 @param lineComplete A block reference to handle processing a row of fields
 @return Whether or not the parsing completed successfully (unimplemented; always YES)
 @author Jesse Hemingway
 */
- (BOOL)parseCSVWithDelimiterSet:(NSCharacterSet*)fieldDelimiter lineComplete:(NRDCSVParserLineCompleteBlock)lineComplete;

@end
