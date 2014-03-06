//
//  NSString+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "NSString+Nerdery.h"
#import "NSData+Nerdery.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/utsname.h>

typedef enum hashType {
    hashTypeSHA1 = 1,
    hashTypeMD5
} HashType;

@implementation NSString (Nerdery)

// See: http://www.kominak.com/iphone-sdk-ios/md5-hash-nsstring-nsdata.html and http://stackoverflow.com/a/3469033
+ (NSString *)hashString:(NSString *)string usingHashType:(HashType)hashType
{
    NSParameterAssert(hashType == hashTypeSHA1 || hashType == hashTypeMD5);
    
    NSUInteger length = (hashType == hashTypeSHA1) ? CC_SHA1_DIGEST_LENGTH : CC_MD5_DIGEST_LENGTH;
    unsigned char result[length];
    
    // Convert the string to a C-string and generate the hash
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (hashType == hashTypeSHA1) {
        CC_SHA1([stringData bytes], [stringData length], result);
    } else {
        CC_MD5([stringData bytes], [stringData length], result);
    }
    
    // The hash has been calculated and stored in 'result'
    
    // Convert the hash into a lowercase NSString
    NSMutableString *hash = [NSMutableString string];
    for (NSUInteger i = 0; i < length; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

- (NSString *)MD5Hash
{
    return [NSString hashString:self usingHashType:hashTypeMD5];
}

- (NSString *)SHA1Hash
{
    return [NSString hashString:self usingHashType:hashTypeSHA1];
}

- (BOOL)isNotEmpty 
{
    return [self length] > 0;
}

- (UIFont *)fittedFontSizeForFont:(UIFont *)font minimumFontSize:(CGFloat)minimumFontSize contrainedToSize:(CGSize)constrainedSize
{
    CGFloat currentFontSize = font.pointSize;
    UIFont *resultFont = font;
    while (currentFontSize >= minimumFontSize) {
        resultFont = [resultFont fontWithSize:currentFontSize];
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_1
        // iPhone 7.0 code here
        CGSize calculatedLabelSize = [self boundingRectWithSize:CGSizeMake(constrainedSize.width, MAXFLOAT)
                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                     attributes:@{NSFontAttributeName : resultFont}
                                                        context:nil].size;
#else
        CGSize calculatedLabelSize = [self sizeWithFont:resultFont constrainedToSize:CGSizeMake(constrainedSize.width, MAXFLOAT)];
#endif

        
        if (calculatedLabelSize.height <= constrainedSize.height) {
            break;
        }
        currentFontSize--;
    }
    
    return resultFont;
}

+ (NSString *)documentsDirectoryWithAppendedPath:(NSString *)path
{
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docsDirectory stringByAppendingPathComponent:path];
}

+ (NSString *)stringWithUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    NSString *uuid = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    
    return uuid;
}

- (NSString *)normalizedString
{
    NSMutableString *result = [NSMutableString stringWithString:self];
    CFStringNormalize((__bridge CFMutableStringRef)result, kCFStringNormalizationFormD);
    CFStringFold((__bridge CFMutableStringRef)result, kCFCompareCaseInsensitive | kCFCompareDiacriticInsensitive | kCFCompareWidthInsensitive, NULL);
    return result;
}

+ (NSString *)deobfuscatedStringWithBytes:(const void *)bytes length:(NSUInteger)length key:(NSString *)key
{
    NSData *deobfuscatedData = [NSData dataWithBytes:bytes length:length];
    [deobfuscatedData obfuscateOrDeobfuscateWithKey:key];
    return [[NSString alloc] initWithData:deobfuscatedData encoding:NSUTF8StringEncoding];
}

// Adapted from here: http://stackoverflow.com/questions/800123/best-practices-for-validating-email-address-in-objective-c-on-ios-2-0
// And here: http://cocoawithlove.com/2009/06/verifying-that-string-is-email-address.html
- (BOOL)isValidEmailAddress
{
    NSString *emailRegex = @"(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-"
    @"z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

+ (NSComparisonResult)compareVersionString:(NSString*)stringA toString:(NSString*)stringB
{
    NSArray *partsA = [stringA componentsSeparatedByString:@"."];
    NSArray *partsB = [stringB componentsSeparatedByString:@"."];
    NSInteger nParts = MAX(partsA.count, partsB.count);
    for (NSInteger i = 0; i < nParts; i++) {
        NSInteger valA = i < partsA.count ? [[partsA objectAtIndex:i] intValue] : 0;
        NSInteger valB = i < partsB.count ? [[partsB objectAtIndex:i] intValue] : 0;
        
        if (valA < valB) {
            return NSOrderedAscending;
        }
        else if (valA > valB) {
            return NSOrderedDescending;
        }
    }
    
    return NSOrderedSame;
}

+ (NSString*)deviceModelAsString
{
    struct utsname platform;
    int rc = uname(&platform);
    if (rc >= 0) {
        return [NSString stringWithCString:platform.machine encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

+ (NSString*)stringWithDuration:(NSTimeInterval)duration
{
    NSDate *dateA = [NSDate date];
    NSDate *dateB = [dateA dateByAddingTimeInterval:duration];
    if ([dateA isEqualToDate:dateB]) {
        return @"-:--";
    }
    
    // format a minimal expression of the duration, based on the common 'hh:mm:ss' interval/duration format
    unsigned int units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:units fromDate:dateA toDate:dateB options:0];
    if (comps.hour > 0) {
        return [NSString stringWithFormat:@"%d:%02d:%02d", comps.hour, comps.minute, comps.second];
    }
    else if (comps.minute > 0) {
        return [NSString stringWithFormat:@"%d:%02d", comps.minute, comps.second];
    } else {
        return [NSString stringWithFormat:@":%02d", comps.second];
    }
}

/*
 * This CSV parser handles many common cases but is incomplete; would require refactoring to expand support for CSV variations
 * This implementation may register poorly with some static analysis tools.  It's a bit stack/register optimized in this form.
 */
- (BOOL)parseCSVWithDelimiterSet:(NSCharacterSet*)fieldDelimiter lineComplete:(NRDCSVParserLineCompleteBlock)lineComplete;
{
    // used to track the maximum fields/row encountered, to optimize 'fields' related memory utilization
    __block NSInteger maxLineFields = 4;
    // error is unused at this time
    __block NSError *error = nil;
    
    // add the double-quote character to the delimiter set
    __block NSMutableCharacterSet *delimSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"\\\""];
    [delimSet formUnionWithCharacterSet:fieldDelimiter];
    NSCharacterSet *fieldTrimSet = [NSCharacterSet whitespaceCharacterSet];
    
    // loop over all lines
    [self enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        NSMutableArray *fields = [NSMutableArray arrayWithCapacity:maxLineFields];
        NSMutableString *field = [NSMutableString string];
        
        NSString *contentString = nil;
        NSString *delimiterString = nil;
        BOOL inQuote = NO;
        
        // loop over delimited content, parsing into fields using common parse cases (TODO: refactor and expand support)
        NSScanner *scanner = [NSScanner scannerWithString:line];
        scanner.charactersToBeSkipped = nil;
        while ([scanner scanUpToCharactersFromSet:delimSet intoString:&contentString] || scanner.scanLocation < line.length - 1) {
            
            // handle delimiters
            if ([scanner scanCharactersFromSet:delimSet intoString:&delimiterString]) {
                
                // skip escape characters
                if ([delimiterString characterAtIndex:0] == '\\') {
                    // encountered escape character; advance scanLocation
                    if (delimiterString.length >= 2) {
                        [field appendString:[delimiterString substringWithRange:(NSRange){1, 1}]];
                        scanner.scanLocation -= delimiterString.length - 2;
                    }
                }
                
                // else transition in or out of quote state
                else if ([delimiterString characterAtIndex:0] == '"') {
                    if (inQuote) {
                        if (contentString) {
                            [field appendString:contentString];
                        }
                        scanner.scanLocation -= MAX(1, delimiterString.length - 1);
                        inQuote = NO;
                    } else {
                        if (delimiterString.length > 1 && [delimiterString characterAtIndex:1] == '"') {
                            scanner.scanLocation -= MAX(1, delimiterString.length - 1);
                        }
                        inQuote = YES;
                    }
                }
                
                // else handle content start, continue, end
                else {
                    if (contentString) {
                        [field appendString:contentString];
                    }
                    if (!inQuote) {
                        scanner.scanLocation -= MAX(0, delimiterString.length - 1);
                        [fields addObject:[field stringByTrimmingCharactersInSet:fieldTrimSet]];
                        field = [NSMutableString string];
                    } else {
                        [field appendString:delimiterString];
                    }
                }
                
            }
            
            // else if no delimiters, handle string content
            else if (contentString.length) {
                // no delimiters; this is content
                [field appendString:contentString];
                [fields addObject:[field stringByTrimmingCharactersInSet:fieldTrimSet]];
            }
            contentString = nil;
        }
        
        // contentString only has content if field data was parsed
        if (contentString.length) {
            [field appendString:[contentString stringByTrimmingCharactersInSet:fieldTrimSet]];
            [fields addObject:field];
        }
        
        // continue or stop line scanning as indicated by block response
        BOOL shouldStop = lineComplete(fields, nil);
        if (shouldStop) {
            *stop = YES;
        } else {
            if (fields.count > maxLineFields) {
                maxLineFields = fields.count;
            }
        }
    }];
    
    // TODO: Add nice error support
    return error == nil;
}

@end
