//
//  UIView+Radius.m
//  Radius
//
//  Created by xjhuang on 2019/5/15.
//  Copyright © 2019 xjhuang. All rights reserved.
//

#import "UIView+Radius.h"

@implementation UIView (Radius)
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
//    self.layer.rasterizationScale = UIScreen.ff_scale;
//    self.layer.shouldRasterize = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)xj_radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *maskLayer  = [[CAShapeLayer alloc] init];
    maskLayer.frame          = self.bounds;
    maskLayer.path           = maskPath.CGPath;
    self.layer.mask          = maskLayer;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = maskLayer.path;
    shapeLayer.strokeColor   = borderColor.CGColor;
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth     = borderWidth;
    [self.layer addSublayer:shapeLayer];
}
@end
