//
//  AlertViewController.m
//  xjhOCD
//
//  Created by xjhuang on 20/08/2022.
//

#import "AlertViewController.h"

@interface AlertViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AlertViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
    } completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI
{
    self.view.backgroundColor = UIColor.clearColor;
    self.contentLabel.text = self.content;
}
/* 点击灰色视图dismiss */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
}
- (void)dismiss
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}
#pragma mark - IBActions
- (IBAction)sureButtonClick:(UIButton *)sender {
    [self dismiss];
}


@end
