//
//  UILabel+Nerdery.m
//
//  Copyright (c) 2012 The Nerdery. All rights reserved.
//

#import "UILabel+Nerdery.h"

static const CGFloat kMaxFontSize = 200;
static const CGFloat kMinFontSize = 1;

@interface UILabel(NerderyPrivate)
- (CGFloat)fontSizeThatFitsStartingWith:(CGFloat)startSize;
- (BOOL)doesFont:(UIFont *)font fitInRect:(CGRect)rect;
@end

@implementation UILabel (Nerdery)

- (void)resizeTextToFit
{
    CGRect maxRect = {CGPointZero, self.frame.size};
    
    if ([self doesFont:self.font fitInRect:maxRect] == NO) {
        self.font = [self.font fontWithSize:[self fontSizeThatFitsStartingWith:self.font.pointSize]];
    }
}

- (CGFloat)maxFontSizeThatFits
{
    return [self fontSizeThatFitsStartingWith:kMaxFontSize];
}

- (CGFloat)fontSizeThatFitsStartingWith:(CGFloat)startSize
{
    CGRect maxRect = {CGPointZero, self.frame.size};
    UIFont *maxFont = [self.font fontWithSize:startSize];
    
    while (maxFont.pointSize > kMinFontSize && [self doesFont:maxFont fitInRect:maxRect] == NO) {
        maxFont = [maxFont fontWithSize:maxFont.pointSize - 1];
    }

    return maxFont.pointSize;
}

- (BOOL)doesFont:(UIFont *)font fitInRect:(CGRect)rect
{
    CGSize boundingSize = rect.size;
    boundingSize.height = CGFLOAT_MAX;
    // You must pass in CGFLOAT_MAX (or a big number) for the height, otherwise your text will never flow outside of the boundingSize.
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_1
    // iPhone 7.0 code here
    CGSize currentSize = [self.text boundingRectWithSize:CGSizeMake(boundingSize.width, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName : font}
                                                    context:nil].size;
#else
    CGSize currentSize = [self.text sizeWithFont:font constrainedToSize:boundingSize lineBreakMode:self.lineBreakMode];
#endif

    
    
    
    CGRect currentRect = {CGPointZero, currentSize};    
    
    return CGRectContainsRect(rect, currentRect);
}

@end
