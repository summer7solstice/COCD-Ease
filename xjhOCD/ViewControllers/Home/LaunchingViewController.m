//
//  LaunchingViewController.m
//  xjhOCD
//
//  Created by xjhuang on 14/07/2022.
//

#import "LaunchingViewController.h"
#import "UIButton+CountDown.h"
#import "AR3DViewController.h"
#import "AR2DViewController.h"

@interface LaunchingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;


@end

@implementation LaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
            self.title = @"Shaking Hands";
            break;
        case ChallengeType_DoorHandles:
            self.title = @"Door Handles";
            break;
        case ChallengeType_DirtyMoney:
            self.title = @"Dirty Money";
            break;
        case ChallengeType_DirtyObjects:
            self.title = @"Dirty Objects";
            break;
        default:
            break;
    }
//    [self.startButton countDownSeconds:10];
    
    [self setupUI];
}
- (void)setupUI
{
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            [self.switchBtn setOn:kDataManager.remindShakeHands ? YES : NO animated:NO];
        }
            break;
        case ChallengeType_DoorHandles:
        {
            [self.switchBtn setOn:kDataManager.remindDoorHandles ? YES : NO animated:NO];
        }
            break;
        case ChallengeType_DirtyMoney:
        {
            [self.switchBtn setOn:kDataManager.remindDirtyMoney ? YES : NO animated:NO];
        }
            break;
        case ChallengeType_DirtyObjects:
        {
            [self.switchBtn setOn:kDataManager.remindDirtyObjects ? YES : NO animated:NO];
        }
            break;
        default:
            break;
    }
}
- (IBAction)switchButtonClick:(UISwitch *)sender {
    
}

- (IBAction)startButtonClick:(UIButton *)sender {
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            AR3DViewController *vc = kHomeStoryboardWithID(@"AR3DViewController");
            vc.challengeType = self.challengeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ChallengeType_DoorHandles:
        {
            AR3DViewController *vc = kHomeStoryboardWithID(@"AR3DViewController");
            vc.challengeType = self.challengeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ChallengeType_DirtyMoney:
        {
            AR2DViewController *vc = kHomeStoryboardWithID(@"AR2DViewController");
            vc.challengeType = self.challengeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ChallengeType_DirtyObjects:
        {
            AR2DViewController *vc = kHomeStoryboardWithID(@"AR2DViewController");
            vc.challengeType = self.challengeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (IBAction)nextTimeButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
