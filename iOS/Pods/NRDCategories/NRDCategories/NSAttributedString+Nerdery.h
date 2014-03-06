//
//  NSAttributedString+Nerdery.h
//
//  Copyright 2014 The Nerdery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Nerdery)

/**
 *  Creates an @c NSAttributedString.
 *
 *  @param text    The text of the string.
 *  @param name    The font name.
 *  @param size    The font size.
 *  @param color   The font color.
 *  @param kerning The kerning in Photoshop Units.
 *
 *  @return @c NSAttributedString
 *  @author Erik Weiss
 */
+ (NSAttributedString *)attributedStringWithText:(NSString *)text
                                        fontName:(NSString *)name
                                        fontSize:(CGFloat)size
                                           color:(UIColor *)color
                                         kerning:(NSNumber *)kerning;

/**
 *  Apply the kerning to the @c NSAttributedString.
 *
 *  @param kernValue Kerning value
 *
 *  @return @c NSMutableAttributedString with the kerning.
 *  @author Ben Dolmar
 */
- (NSMutableAttributedString *)attributedStringWithKerning:(NSNumber *)kernValue;

/**
 *  Apply the kerning to the @c NSAttributedString.
 *
 *  @param kernValue Kerning value in Photoshop Units
 *
 *  @return @c NSMutableAttributedString with the kerning.
 *  @author Ben Dolmar
 */
- (NSMutableAttributedString *)attributedStringWithKerningInPhotoshopUnits:(NSNumber *)kernValue;

/**
 *  Apply the line height to an @c NSAttributedString.
 *
 *  @param lineHeight The line height
 *
 *  @return @c NSMutableAttributedString with the line height.
 *  @author Ben Dolmar, Erik Weiss
 */
- (NSMutableAttributedString *)attributedStringLineHeight:(NSNumber *)lineHeight;

@end
