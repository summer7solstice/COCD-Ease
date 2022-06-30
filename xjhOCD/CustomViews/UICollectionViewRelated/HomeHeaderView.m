//
//  HomeHeaderView.m
//  xjhOCD
//
//  Created by xjhuang on 14/06/2022.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView
- (IBAction)revealButtonClick:(UIButton *)sender {
    self.isShow = !self.isShow;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.quoteLabel.alpha = self.isShow ? 1 : 0;
        self.normalLabel.alpha = self.isShow ? 0 : 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)moodButtonClick:(UIButton *)sender {
    if (self.moodBlock) {
        self.moodBlock();
    }
}
- (IBAction)erpButtonClick:(UIButton *)sender {
    if (self.erpBlock) {
        self.erpBlock();
    }
}

@end
