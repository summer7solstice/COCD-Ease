//
//  UIViewController+Navigation.h
//  BaseProject
//
//  Created by RockyYe on 2017/9/3.
//  Copyright © 2017年 RockyYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigation)

- (void)popToRootAndPushViewController:(UIViewController *)viewController;

- (UIViewController *)findViewControllerWithClass:(Class)aClass;

- (void)popToViewControllerWithClass:(Class)aClass;

@end
