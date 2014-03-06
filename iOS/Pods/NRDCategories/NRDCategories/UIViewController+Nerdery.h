//
//  UIViewController+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//


@interface UIViewController (Nerdery)

/**
 Convenience method to add a child view controller to a content view controller.
 @discussion Alternative to framework's addChildViewController: method, properly calling childVC's didMoveToParentViewController: method. childVC.view is automatically added as a subview of self.view (via addSubview:) and sized to self.view.bounds.  The frame and view index can be safely and efficiently modified after call and before presentation.
 @param childVC A UIViewController to add to receiver's view controller chain
 @author Jesse Hemingway
 */
- (void)addChildVC:(UIViewController*)childVC;

/**
 Convenience method to add a child view controller to a content view controller, targeting a particular subview for containment.
 @discussion Alternative to framework's addChildViewController: method, properly calling childVC's didMoveToParentViewController: method. childVC.view is automatically added as a subview of self.view (via addSubview:) and sized to self.view.bounds.  The frame and view index can be safely and efficiently modified after call and before presentation.
 @param childVC A UIViewController to add to receiver's view controller chain
 @param parentView A UIView that the childVC's view should be added to as a subview. The childVC's view's frame will be set to parentView's bounds.
 @author Joshua Sullivan
 */
- (void)addChildVC:(UIViewController *)childVC inView:(UIView *)parentView;
 
/**
 Convenience method to remove a child view controller from a content view controller.
 @discussion Alternative to framework's removeFromParentViewController: method, properly calling childVC's willMoveToParentViewController: method. childVC.view is automatically removed from superview.
 @param childVC A UIViewController to remove from receiver's view controller chain
 @author Jesse Hemingway
 */
- (void)removeChildVC:(UIViewController*)childVC;

@end
