//
//  BaseViewController.h
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
@property (assign, nonatomic) BOOL       navigationBarHidden;
/* 分页参数 */
@property (assign, nonatomic) NSInteger         currentPage;
@property (assign, nonatomic) BOOL              noMoreData;


/* 可覆写方法 */
- (void)setupUI;
- (void)setupPageMode;
- (void)setupRac;
- (void)setupNaviBarItems;
- (void)backButtonClick;
- (void)dealloc;
- (void)hideNaviBottomLine;
- (void)showNaviBottomLine;
- (void)showPermissionAlertWithDescription:(NSString *)accessDescription;
@end
