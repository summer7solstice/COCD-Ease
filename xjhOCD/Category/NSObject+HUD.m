//
//  NSObject+HUD.m
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "NSObject+HUD.h"

@implementation NSObject (HUD)
/* 文字提示 */
- (void)showToastHUD:(NSString *)string{
    dispatch_async(dispatch_get_main_queue(), ^{
        //显示信息之前，先隐藏已有的HUD
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:XJ_MAINWINDOW animated:true];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.numberOfLines = 0;
        if (XJStringIsEmpty(string))
        {
            HUD.label.text = @"";
        }
        else
        {
            HUD.label.text = string;
        }
        HUD.removeFromSuperViewOnHide = true;
        [HUD hideAnimated:YES afterDelay:5];
    });
}
@end
