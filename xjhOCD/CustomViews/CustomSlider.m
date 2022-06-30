//
//  CustomSlider.m
//  xjhOCD
//
//  Created by xjhuang on 16/06/2022.
//

#import "CustomSlider.h"

@implementation CustomSlider

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), 27);
}

@end
