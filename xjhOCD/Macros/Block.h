//
//  Block.h
//  ZNZNew
//
//  Created by xjhuang on 2018/9/19.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 传值的BLOCK */
typedef void(^BoolBlock)(BOOL );
typedef void(^IntBlock)(NSInteger );
typedef void(^StringBlock)(NSString *);
typedef void(^IdBlock)(id );
/* 事件回调BLOCK */
typedef void(^ActionBlock)(void);

#define kCellID             @"__cellid"
#define kCellForRow         @"__cellForRow"
#define kCellHeightForRow   @"__heightForRow"
#define kCellDidSelectRow   @"__didSelectRow"

typedef void(^CellForRowBlock)(NSDictionary *dict, __kindof UIView *cell, NSIndexPath *indexPath);
typedef CGFloat(^HeightForRowBlock)(NSDictionary *dict, NSIndexPath *indexPath);
typedef void(^DidSelectRowBlock)(NSDictionary *dict, NSIndexPath *indexPath);

CellForRowBlock     cellForRowBlock(CellForRowBlock block);
HeightForRowBlock   heightForRowBlock(HeightForRowBlock block);
DidSelectRowBlock   didSelectRowBlock(DidSelectRowBlock block);
