//
//  UINavigationController+Nerdery.h
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

@interface UINavigationController (Nerdery)

/**
 Undocumented
 @param viewController UNDOCUMENTED
 @param animated UNDOCUMENTED
 @author Jay Peyer
*/
- (void)replaceTopViewControllerWithViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 Pop all view controllers and push a new root view controller, optionally animated
 @param viewController UNDOCUMENTED
 @param animated UNDOCUMENTED
 @author Jay Peyer
 */
- (void)popViewControllersAndPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
