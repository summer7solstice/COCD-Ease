//
//  UIView+Radius.h
//  Radius
//
//  Created by xjhuang on 2019/5/15.
//  Copyright © 2019 xjhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Radius)
/// 边线颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
/// 边线宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/// 脚半径
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

- (void)xj_radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end

NS_ASSUME_NONNULL_END
