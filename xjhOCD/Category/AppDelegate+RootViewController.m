//
//  AppDelegate+RootViewController.m
//  AWJ
//
//  Created by 黄晓军 on 2019/7/9.
//  Copyright © 2019 xjhuang. All rights reserved.
//

#import "AppDelegate+RootViewController.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@implementation AppDelegate (RootViewController)

- (void)initializeRootViewControllerWithApplication:(UIApplication *)application
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    // 关闭深色模式，解决深色模式下状态栏颜色
    if (@available(iOS 13.0, *)) {
        window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    self.window = window;
    
    
//    [self checkLogin:^(BOOL flag) {
//        if (flag)
//        {
//            // 已登录
//            self.window.rootViewController = [BaseTabBarController new];
//        }
//        else
//        {
//            self.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:kLoginStoryboardWithID(@"LoginViewController")];
//        }
//    }];
    self.window.rootViewController = [BaseTabBarController new];
    [self.window makeKeyAndVisible];
}
/* 判断登录与否 */
- (void)checkLogin:(BoolBlock)isLogin
{
    NSInteger login = [[NSUserDefaults standardUserDefaults] integerForKey:@"userLogin"];
    isLogin(login);
}
@end
