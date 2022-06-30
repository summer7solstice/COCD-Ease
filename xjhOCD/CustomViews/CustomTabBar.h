//
//  CustomTabBar.h
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTabBarDelegate<NSObject>
- (void)customTabBarClickButtonAtIndex:(NSInteger)index;
@end
@interface CustomTabBar : UITabBar
@property (nonatomic, weak) id<CustomTabBarDelegate> customDelegate;
@end
