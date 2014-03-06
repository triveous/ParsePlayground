//
//  UINavigationController+Nerdery.m
//
//  Copyright (c) 2012 The Nerdery. All rights reserved.
//

#import "UINavigationController+Nerdery.h"

@implementation UINavigationController (Nerdery)

- (void)replaceTopViewControllerWithViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Push the new view controller and pop the current view controller
    NSMutableArray *updatedViewControllersStack = [self.viewControllers mutableCopy];
    [updatedViewControllersStack removeLastObject];
    [updatedViewControllersStack addObject:viewController];
    [self setViewControllers:updatedViewControllersStack animated:animated];
}

- (void)popViewControllersAndPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *viewControllers = nil;
    if (viewController) {
        viewControllers = [NSArray arrayWithObject:viewController];
    } else {
        viewControllers = [NSArray array];
    }
    
    [self setViewControllers:viewControllers animated:animated];
}

@end
