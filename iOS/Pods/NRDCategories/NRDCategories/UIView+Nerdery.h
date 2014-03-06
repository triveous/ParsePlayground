//
//  UIView+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface UIView (Nerdery)

/*!
 @methodgroup Sorting UIView Subviews
 */
#pragma mark - Sorting UIView Subviews

/**
 Sorts an array of views (e.g. IBOutletCollection) by view tags
 @param viewArray An array of UIView objcects
 @author Jesse Hemingway
 */
+ (NSArray*)sortViewArrayByTag:(NSArray*)viewArray;

/**
 Sorts an array of views (e.g. IBOutletCollection) by view index
 @param viewArray An array of UIView objcects
 @author Jesse Hemingway
 */
+ (NSArray*)sortViewArrayByIndex:(NSArray*)viewArray;


// If QuartzCore is included
#ifdef QUARTZCORE_H

/*!
 @methodgroup Setting view anchor points
*/
#pragma mark - Setting view anchor points

/**
 Set a view's transformation anchor point without shifting view frame
 @param anchorPoint A point whose x and y attributes are normalized to the [0, 1] range, where (0.5, 0.5) represents the center of the view's frame
 @author Jesse Hemingway
 */
- (void)setLayerAnchorPoint:(CGPoint)anchorPoint;

/**
 UNDOCUMENTED - TODO: If use case can be shown, recommend expanding setLayerAnchorPoint: and deprecating this method [jhemingw]
 @param anchorPoint A point whose x and y attributes are normalized to the [0, 1] range, where (0.5, 0.5) represents the center of the view's frame
 @author ??
 */
- (void)setLayerAnchorPointReverseX:(CGPoint)anchorPoint;

/**
 UNDOCUMENTED - TODO: If use case can be shown, recommend expanding setLayerAnchorPoint: and deprecating this method [jhemingw]
 @param anchorPoint A point whose x and y attributes are normalized to the [0, 1] range, where (0.5, 0.5) represents the center of the view's frame
 @author ??
 */
- (void)setLayerAnchorPointReverseY:(CGPoint)anchorPoint;

/**
 UNDOCUMENTED - TODO: If use case can be shown, recommend expanding setLayerAnchorPoint: and deprecating this method [jhemingw]
 @param anchorPoint A point whose x and y attributes are normalized to the [0, 1] range, where (0.5, 0.5) represents the center of the view's frame
 @author ??
 */
- (void)setLayerAnchorPointReverseXY:(CGPoint)anchorPoint;

/*!
 @methodgroup Screen Scale Convenience
 */
#pragma mark - Screen Scale Convenience

/**
 Loops through a CALayer and all of it's children layer to the specified depth and sets the contentScale property to the value specified.
 @discussion This is primarily useful when transforming and then rendering a CALayer to a graphics context. In that case the layer can have insufficient resolution to render smoothly. In order to address this the layer's content scale can be set to a value that will generate a sufficient number of pixels for sharp display. NOTE: If this is done a view that is intended to be a part visible user interface, the content scale should always be set back to the main screen's scale (i.e. 1.0 on a non-retina screen or 1.0 on a retina screen).
 @param scale The scale to use when mapping a point in the interface to a pixel for the drawing context.
 @param depth The number of steps down the layer heirarchy to traverse. This number is intended to create a ceiling on the recursive function.
 @author Ben Dolmar
 */
- (void)recursivelySetLayerContentScale:(CGFloat)scale depth:(NSInteger)depth; 

#endif  //#ifdef QUARTZCORE_H

/**
 *  Takes a screenshot of the @c UIView and returns it as a @c UIImage.
 *
 *  @param afterUpdates If the screenshot should be taken after updates.
 *
 *  @return UIImage of the screen.
 *  @author Erik Weiss
 */
- (UIImage *)imageFromViewAfterUpdates:(BOOL)afterUpdates NS_AVAILABLE_IOS(7_0);

/**
 *  Rounds the specified corners on a @c UIView.
 *
 *  @param radius  The radius of the corners.
 *  @param corners The corners to make rounded.
 *
 *  @return @c UIView with the specified rounded corners.
 *  @author Erik Weiss
 */
- (UIView *)addRoundedCornersWithCornerRadius:(NSInteger)radius andCorners:(UIRectCorner)corners;

@end
