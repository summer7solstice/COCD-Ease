//
//  BaseTabBarController.m
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "CustomTabBar.h"
#import "HomeViewController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) CustomTabBar        *customTabBar;
@property (nonatomic, strong) HomeViewController  *homeVc;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = UIColor.clearColor;
    self.customTabBar = [[CustomTabBar alloc]init];
    [self setValue:self.customTabBar forKeyPath:@"tabBar"];
    [self setupViewControllers];
    
    // 适配iOS13导致的bug
    if (@available(iOS 13.0, *)) {
        // iOS 13以上
        self.tabBar.tintColor = kColor_Main;
    } else {
        // iOS 13以下
    }
    
}
- (void)setupViewControllers{
    HomeViewController *vc0;
    NSArray *titleArray;
    NSArray *imageArr_un;
    NSArray *imageArr_sel;
    
    vc0 = kHomeStoryboardWithID(@"HomeViewController");
    self.homeVc = vc0;
    self.customTabBar.customDelegate = self.homeVc;
    imageArr_un = @[@"icon_tab_back",@"icon_tab_set",@"icon_tab_home",@"icon_tab_mine",@"icon_tab_fast"];
    imageArr_sel = @[@"icon_tab_back",@"icon_tab_set",@"icon_tab_home",@"icon_tab_mine",@"icon_tab_fast"];
    
    NSArray *vcArray = @[vc0];
    NSMutableArray *naviArray = [NSMutableArray array];
    [vcArray enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [naviArray addObject:[self addChildVc:obj title:titleArray[idx] image:imageArr_un[idx] selectedImage:imageArr_sel[idx]]];
    }];
    self.viewControllers = naviArray;
}
- (BaseNavigationController *)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColor_Gray} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : HexColor(@"#65AE75")} forState:UIControlStateSelected];
    BaseNavigationController *navigationVc = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    return navigationVc;
}
#pragma mark - delegate
/* 系统代理 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger selIndex = [self.tabBar.items indexOfObject:item];
    __block NSInteger index = 0;
    //找到tabbar的被点击的subview
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (selIndex == index) {
                [self addAnimationForView:obj];
            }
            index++;
        }
    }];
}
/* 增加动画 */
- (void)addAnimationForView:(UIView *)view
{
    //缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.duration = 0.2;
    NSValue *value00 = [NSNumber numberWithFloat:1.0];
    NSValue *value01 = [NSNumber numberWithFloat:1.1];
    NSValue *value02 = [NSNumber numberWithFloat:1.2];
    NSValue *value03 = [NSNumber numberWithFloat:1.1];
    NSValue *value04 = [NSNumber numberWithFloat:1.0];
    scaleAnimation.values = @[value00,value01,value02,value03,value04];
    [view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
@end
