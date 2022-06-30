//
//  UIViewController+Navigation.m
//  BaseProject
//
//  Created by RockyYe on 2017/9/3.
//  Copyright © 2017年 RockyYe. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import "BaseNavigationController.h"

@implementation UIViewController (Navigation)

- (void)popToRootAndPushViewController:(UIViewController *)viewController
{
    NSMutableArray *viewControllers;
    if ([self isKindOfClass:[UINavigationController class]]) {
        viewControllers = [NSMutableArray arrayWithArray:[(UINavigationController *)self viewControllers]];
    }else{
        viewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    }
    UIViewController * rootViewController = [viewControllers objectAtIndex:0];
    [viewControllers removeAllObjects];
    [viewControllers addObject:rootViewController];
    [viewControllers addObject:viewController];
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self setViewControllers:viewControllers animated:YES];
    }else{
        [self.navigationController setViewControllers:viewControllers animated:YES];
    }
}

- (UIViewController *)findViewControllerWithClass:(Class)aClass
{
    for (UIViewController * viewController in self.navigationController.viewControllers)
    {
        if ([viewController isKindOfClass:aClass])
        {
            return viewController;
        }
    }
    return nil;
}

- (void)popToViewControllerWithClass:(Class)aClass
{
    for (UIViewController * viewController in self.navigationController.viewControllers)
    {
        if ([viewController isKindOfClass:aClass])
        {
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }
    }
}

@end
