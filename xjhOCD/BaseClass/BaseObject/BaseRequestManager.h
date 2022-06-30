//
//  BaseRequestManager.h
//  ZNZNew
//
//  Created by xjhuang on 2018/9/20.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequestManager : NSObject
+ (RACSignal *)requestWithParams:(NSDictionary *)params;
@end
