//
//  BaseViewController.m
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()



@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInitialize];
}
/* common initialize */
- (void)commonInitialize
{
    self.view.backgroundColor = UIColor.whiteColor;
    
    if (![self isNavigationRootViewController]) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"icon_common_back"] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(0, 0, 40, 40);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
//    [self addBgLayer];

}
- (void)addBgLayer
{
    CAGradientLayer *bgLayer = [[CAGradientLayer alloc] init];
    bgLayer.colors = @[
        (__bridge id)[UIColor colorWithHexString:@"#ABEBC5" alpha:0.68].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#84FFE9" alpha:0.68].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#ABEBC5" alpha:0.4433].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#ABEBC5" alpha:0.3577].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#ABEBC5" alpha:0].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#BEF9FD" alpha:0.0531].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#BEF9FD" alpha:0.0531].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#BEF9FD" alpha:0.0531].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#BEF9FD" alpha:0.0531].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#ADF9FF" alpha:0.0531].CGColor,
    ];
    
    bgLayer.locations = @[@0.36, @1, @1, @1, @1, @1, @1, @1, @1];
    
    bgLayer.startPoint = CGPointMake(0.25, 0.5);
    bgLayer.endPoint = CGPointMake(0.75, 0.5);
    bgLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMake(0, 1, -1, 0, 1, 0));
    bgLayer.frame = self.view.bounds;
    bgLayer.position = self.view.center;
//    [self.view.layer addSublayer:bgLayer];
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:navigationBarHidden];
    }
}
/* 可覆写方法 */
- (void)setupUI{
}
- (void)setupPageMode{
    
}
- (void)setupRac{
}
- (void)setupNaviBarItems{
}
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:true];
}
- (void)hideNaviBottomLine
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)showNaviBottomLine
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)dealloc
{
    XJDealloc;
}
#pragma mark - mark
- (BOOL)isNavigationRootViewController
{
    if (self.navigationController && [self.navigationController.viewControllers firstObject] == self) {
        return true;
    }else{
        return false;
    }
}

- (void)showPermissionAlertWithDescription:(NSString *)accessDescription {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:accessDescription message:@"To give permission tap on 'Change Settings' button." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
    }];
    [alertController addAction:settingsAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
