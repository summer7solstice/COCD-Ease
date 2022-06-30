//
//  Block.m
//  ZNZNew
//
//  Created by xjhuang on 2018/9/19.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "Block.h"

CellForRowBlock     cellForRowBlock(CellForRowBlock block)
{
    return [block copy];
}
HeightForRowBlock   heightForRowBlock(HeightForRowBlock block)
{
    return [block copy];
}
DidSelectRowBlock   didSelectRowBlock(DidSelectRowBlock block)
{
    return [block copy];
}
