//
//  NSAttributedString+Nerdery.m
//
//  Copyright 2014 The Nerdery. All rights reserved.
//

#import "NSAttributedString+Nerdery.h"

@implementation NSAttributedString (Nerdery)

+ (NSAttributedString *)attributedStringWithText:(NSString *)text
                                               fontName:(NSString *)name
                                               fontSize:(CGFloat)size
                                                  color:(UIColor *)color
                                                kerning:(NSNumber *)kerning
{
    NSParameterAssert(text);
    NSParameterAssert(color);
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:@{NSFontAttributeName : [UIFont fontWithName:name size:size],
                                                 NSForegroundColorAttributeName : color}];
    attributedString = [attributedString attributedStringWithKerningInPhotoshopUnits:kerning];
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithKerning:(NSNumber *)kernValue
{
    NSMutableAttributedString *attributedText = [self mutableCopy];
    [attributedText addAttribute:NSKernAttributeName
                           value:kernValue
                           range:NSMakeRange(0, [attributedText length])];
    return attributedText;
}

- (NSMutableAttributedString *)attributedStringWithKerningInPhotoshopUnits:(NSNumber *)kernValue
{
    UIFont *font = [self attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    CGFloat kernInPoints = [kernValue floatValue] * .001 * font.pointSize;
    return [self attributedStringWithKerning:@(kernInPoints)];
}

- (NSMutableAttributedString *)attributedStringLineHeight:(NSNumber *)lineHeight
{
    NSMutableAttributedString *attributedText = [self mutableCopy];
    NSRange attributeRange = NSMakeRange(0, 0);
    NSUInteger currentIndex = 0;
    
    while(attributeRange.location + attributeRange.length < attributedText.length) {
        NSMutableParagraphStyle *paragraphStyle = [[attributedText attribute:NSParagraphStyleAttributeName
                                                                     atIndex:currentIndex
                                                              effectiveRange:&attributeRange] mutableCopy];
        if (!paragraphStyle) {
            paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        }
        paragraphStyle.minimumLineHeight = [lineHeight floatValue];
        paragraphStyle.maximumLineHeight = [lineHeight floatValue];
        paragraphStyle.lineSpacing = 0;
        [attributedText addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:attributeRange];
        currentIndex = attributeRange.location + attributeRange.length;
    }
    
    return attributedText;
}

@end
