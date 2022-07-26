//
//  UIButton+CountDown.h
//  ZNZNew
//
//  Created by xjhuang on 2018/8/29.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)
- (void)countDownSeconds:(int)seconds;
- (void)setPlaceHolderString:(NSString *)placeHolderString;
@end
