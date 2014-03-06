//
//  UIViewController+Nerdery.m
//
//  Copyright 2013 The Nerdery. All rights reserved.
//

#import "UIViewController+Nerdery.h"

@implementation UIViewController (Nerdery)

- (void)addChildVC:(UIViewController *)childVC
{
    [self addChildVC:childVC inView:self.view];
}

- (void)addChildVC:(UIViewController *)childVC inView:(UIView *)parentView
{
    [self addChildViewController:childVC];
    childVC.view.frame = parentView.bounds;
    [parentView addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];
}

- (void)removeChildVC:(UIViewController*)childVC
{
    [childVC.view removeFromSuperview];
    [childVC willMoveToParentViewController:nil];
    [childVC removeFromParentViewController];
}


@end
