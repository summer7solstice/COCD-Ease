//
//  BaseRequestManager.m
//  ZNZNew
//
//  Created by xjhuang on 2018/9/20.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "BaseRequestManager.h"

@implementation BaseRequestManager
/* 子类覆写方法 */
+ (RACSignal *)requestWithParams:(NSDictionary *)params
{
    return [RACSignal empty];
}
@end
