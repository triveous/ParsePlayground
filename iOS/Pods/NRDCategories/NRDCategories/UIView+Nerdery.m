//
//  UIView+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "UIView+Nerdery.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Nerdery)


- (void)setLayerAnchorPoint:(CGPoint)anchorPoint
{
    CGRect frame = self.frame;
    CGFloat xDif = anchorPoint.x - self.layer.anchorPoint.x;
    CGFloat yDif = anchorPoint.y - self.layer.anchorPoint.y;
    frame.origin.x += xDif * frame.size.width;
    frame.origin.y += yDif * frame.size.height;
    self.frame = frame;
    self.layer.anchorPoint = anchorPoint;
}

- (void)setLayerAnchorPointReverseX:(CGPoint)anchorPoint
{
    CGRect frame = self.frame;
    CGFloat xDif = anchorPoint.x - self.layer.anchorPoint.x;
    CGFloat yDif = anchorPoint.y - self.layer.anchorPoint.y;
    frame.origin.x -= xDif * frame.size.width;
    frame.origin.y += yDif * frame.size.height;
    self.frame = frame;
    self.layer.anchorPoint = anchorPoint;
}

- (void)setLayerAnchorPointReverseY:(CGPoint)anchorPoint
{
    CGRect frame = self.frame;
    CGFloat xDif = anchorPoint.x - self.layer.anchorPoint.x;
    CGFloat yDif = anchorPoint.y - self.layer.anchorPoint.y;
    frame.origin.x += xDif * frame.size.width;
    frame.origin.y -= yDif * frame.size.height;
    self.frame = frame;
    self.layer.anchorPoint = anchorPoint;
}

- (void)setLayerAnchorPointReverseXY:(CGPoint)anchorPoint
{
    CGRect frame = self.frame;
    CGFloat xDif = anchorPoint.x - self.layer.anchorPoint.x;
    CGFloat yDif = anchorPoint.y - self.layer.anchorPoint.y;
    frame.origin.x -= xDif * frame.size.width;
    frame.origin.y -= yDif * frame.size.height;
    self.frame = frame;
    self.layer.anchorPoint = anchorPoint;
}

+ (NSArray*)sortViewArrayByTag:(NSArray*)viewArray
{
    return [viewArray sortedArrayUsingComparator:
             ^(id v1, id v2) {
                 int viewIndex1 = ((UIView*)v1).tag;
                 int viewIndex2 = ((UIView*)v2).tag;
                 if (viewIndex1 < viewIndex2) {
                     return NSOrderedAscending;
                 }
                 if (viewIndex1 > viewIndex2) {
                     return NSOrderedDescending;
                 }
                 return NSOrderedSame;
             }];
}

+ (NSArray*)sortViewArrayByIndex:(NSArray*)viewArray
{
	return [viewArray sortedArrayUsingComparator:
					   ^(id v1, id v2) {
						   int viewIndex1 = [((UIView*)v1).superview.subviews indexOfObject:v1];
						   int viewIndex2 = [((UIView*)v2).superview.subviews indexOfObject:v2];
						   if (viewIndex1 < viewIndex2) {
							   return NSOrderedAscending;
						   }
						   if (viewIndex1 > viewIndex2) {
							   return NSOrderedDescending;
						   }
						   return NSOrderedSame;
					   }];
}

- (void)recursivelySetLayerContentScale:(CGFloat)scale depth:(NSInteger)depth
{
    if (depth < 0) {
        return;
    }
    
    self.layer.contentsScale = scale;
    for (UIView *subview in self.subviews) {
        [subview recursivelySetLayerContentScale:scale depth:depth-1];
    }
}

- (UIImage *)imageFromViewAfterUpdates:(BOOL)afterUpdates
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, self.window.screen.scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

- (UIView *)addRoundedCornersWithCornerRadius:(NSInteger)radius andCorners:(UIRectCorner)corners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}

@end
