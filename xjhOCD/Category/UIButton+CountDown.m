//
//  UIButton+CountDown.m
//  ZNZNew
//
//  Created by xjhuang on 2018/8/29.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "UIButton+CountDown.h"
#import <objc/Runtime.h>
static const char *key = "placeHolderString";

@implementation UIButton (CountDown)
- (void)countDownSeconds:(int)seconds
{
    @weakify(self);
    __block int time = seconds;
    __block RACDisposable *disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        time --;
        NSString *string = time > 0 ? [NSString stringWithFormat:@"Start in %ds",time] : XJStringIsNotEmpty([self placeHolderString]) ? [self placeHolderString] : @"Start";
        [self setTitle:string forState:UIControlStateNormal];
        self.userInteractionEnabled = time == 0 ? true : false;
        if (time == 0) {
            [disposable dispose];
        }
    }];
}
- (void)setPlaceHolderString:(NSString *)placeHolderString
{
    objc_setAssociatedObject(self, key, placeHolderString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)placeHolderString
{
    return objc_getAssociatedObject(self, key);
}
@end
