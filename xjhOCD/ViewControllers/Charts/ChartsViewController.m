//
//  ChartsViewController.m
//  xjhOCD
//
//  Created by xjhuang on 30/06/2022.
//

#import "ChartsViewController.h"
#import "LineChartViewController.h"

@interface ChartsViewController ()

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Charts"];
}
- (IBAction)button0Click:(UIButton *)sender {
    LineChartViewController *vc = kHomeStoryboardWithID(@"LineChartViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_ShakingHands;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)button1Click:(UIButton *)sender {
    LineChartViewController *vc = kHomeStoryboardWithID(@"LineChartViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_DoorHandles;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)button2Click:(UIButton *)sender {
    LineChartViewController *vc = kHomeStoryboardWithID(@"LineChartViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_DirtyMoney;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)button3Click:(UIButton *)sender {
    LineChartViewController *vc = kHomeStoryboardWithID(@"LineChartViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_DirtyObjects;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)button4Click:(UIButton *)sender {
    LineChartViewController *vc = kHomeStoryboardWithID(@"LineChartViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_AllInOne;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
