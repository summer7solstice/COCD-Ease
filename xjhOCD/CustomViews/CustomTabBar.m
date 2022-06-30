//
//  CustomTabBar.m
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#import "CustomTabBar.h"
#define buttonW  XJ_SCREEN_WIDTH/ 5.0
#define barHeight 49.0
@interface CustomTabBar()
@property (nonatomic,strong) UIButton        *button0;
@property (nonatomic,strong) UIButton        *button1;
@property (nonatomic,strong) UIButton        *button2;
@property (nonatomic,strong) UIButton        *button3;
@property (nonatomic,strong) UIButton        *button4;
@end
@implementation CustomTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button0];
        [self addSubview:self.button1];
        [self addSubview:self.button2];
        [self addSubview:self.button3];
        [self addSubview:self.button4];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.set frames of the buttons
    self.button2.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, barHeight/2.0 - 5);
    self.button1.center = CGPointMake(CGRectGetMinX(self.button2.frame) - 15 - self.button1.frame.size.width/2.0, barHeight/2.0 - 5);
    self.button3.center = CGPointMake(CGRectGetMaxX(self.button2.frame) + 15 + self.button3.frame.size.width/2.0, barHeight/2.0 - 5);
    self.button0.center = CGPointMake(CGRectGetMinX(self.button1.frame) - 12 - self.button0.frame.size.width/2.0, barHeight/2.0 - 5);
    self.button4.center = CGPointMake(CGRectGetMaxX(self.button3.frame) + 12 + self.button4.frame.size.width/2.0, barHeight/2.0 - 5);
    
    // 2.remove all UITabBarButtons
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            [child removeFromSuperview];
        }
    }
}
- (UIButton *)button0{
    @weakify(self);
    if (!_button0) {
        _button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"icon_tab_back"];
        [_button0 setImage:image forState:UIControlStateNormal];
        [_button0 setImage:image forState:UIControlStateHighlighted];
        _button0.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [_button0 bk_addEventHandler:^(id sender) {
            @strongify(self);
            [self addAnimationForView:self->_button0];
            if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(customTabBarClickButtonAtIndex:)]) {
                [self.customDelegate customTabBarClickButtonAtIndex:0];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button0;
}
- (UIButton *)button1{
    @weakify(self);
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"icon_tab_set"];
        [_button1 setImage:image forState:UIControlStateNormal];
        [_button1 setImage:image forState:UIControlStateHighlighted];
        _button1.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [_button1 bk_addEventHandler:^(id sender) {
            @strongify(self);
            [self addAnimationForView:self->_button1];
            if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(customTabBarClickButtonAtIndex:)]) {
                [self.customDelegate customTabBarClickButtonAtIndex:1];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}
- (UIButton *)button2{
    @weakify(self);
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"icon_tab_home"];
        [_button2 setImage:image forState:UIControlStateNormal];
        [_button2 setImage:image forState:UIControlStateHighlighted];
        _button2.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [_button2 bk_addEventHandler:^(id sender) {
            @strongify(self);
            [self addAnimationForView:self->_button2];
            if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(customTabBarClickButtonAtIndex:)]) {
                [self.customDelegate customTabBarClickButtonAtIndex:2];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}
- (UIButton *)button3{
    @weakify(self);
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"icon_tab_mine"];
        [_button3 setImage:image forState:UIControlStateNormal];
        [_button3 setImage:image forState:UIControlStateHighlighted];
        _button3.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [_button3 bk_addEventHandler:^(id sender) {
            @strongify(self);
            [self addAnimationForView:self->_button3];
            if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(customTabBarClickButtonAtIndex:)]) {
                [self.customDelegate customTabBarClickButtonAtIndex:3];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}
- (UIButton *)button4{
    @weakify(self);
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"icon_tab_fast"];
        [_button4 setImage:image forState:UIControlStateNormal];
        [_button4 setImage:image forState:UIControlStateHighlighted];
        _button4.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [_button4 bk_addEventHandler:^(id sender) {
            @strongify(self);
            [self addAnimationForView:self->_button4];
            if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(customTabBarClickButtonAtIndex:)]) {
                [self.customDelegate customTabBarClickButtonAtIndex:4];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4;
}
/* 增加动画 */
- (void)addAnimationForView:(UIView *)view
{
    //缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.duration = 0.2;
    NSValue *value00 = [NSNumber numberWithFloat:1.0];
    NSValue *value01 = [NSNumber numberWithFloat:1.1];
    NSValue *value02 = [NSNumber numberWithFloat:1.2];
    NSValue *value03 = [NSNumber numberWithFloat:1.1];
    NSValue *value04 = [NSNumber numberWithFloat:1.0];
    scaleAnimation.values = @[value00,value01,value02,value03,value04];
    [view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
@end
