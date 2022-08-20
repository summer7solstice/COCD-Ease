//
//  EvaluationPopViewController.m
//  xjhOCD
//
//  Created by xjhuang on 21/07/2022.
//

#import "EvaluationPopViewController.h"

@interface EvaluationPopViewController ()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation EvaluationPopViewController

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
    self.scoreLabel.text = [NSString stringWithFormat:@"Your score is %ld seconds!",self.timelength];
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
    if (self.block) {
        self.block(1);
    }
}
@end
