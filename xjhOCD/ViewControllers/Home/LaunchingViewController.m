//
//  LaunchingViewController.m
//  xjhOCD
//
//  Created by xjhuang on 14/07/2022.
//

#import "LaunchingViewController.h"
#import "UIButton+CountDown.h"
#import "AR3DViewController.h"
#import "ModelSelViewController.h"

@interface LaunchingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *guidanceLabel;
@property (nonatomic, copy) NSString *content;

@end

@implementation LaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
            self.title = @"Shaking Hands";
            self.imageView.image = XJImageNamed(@"dirtyHand");
            break;
        case ChallengeType_DoorHandles:
            self.title = @"Door Handles";
            self.imageView.image = XJImageNamed(@"dirtyDoorHandle");
            break;
        case ChallengeType_DirtyMoney:
            self.title = @"Dirty Money";
            self.imageView.image = XJImageNamed(@"dirtyMoney");
            break;
        case ChallengeType_DirtyBugs:
            self.title = @"Dirty Bug";
            self.imageView.image = XJImageNamed(@"dirtyBug");
            break;
        default:
            break;
    }
    
    [self setupUI];
}
- (void)setupUI
{
    NSString *text;
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            [self.switchBtn setOn:kDataManager.remindShakeHands ? YES : NO animated:NO];
            
            text = @"1. Press 'start', select the hand model you like.\n2. Focus the camera on a vertical plane, detecting it.\n3. Tap screen to place the 'hand'.\n4. Scale, drag it as you like.\n5. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
            self.content = @"1. Focus the camera on a vertical plane, detecting it.\n2. Tap screen to place the 'hand'.\n3. Scale, drag it as you like.\n4. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
        }
            break;
        case ChallengeType_DoorHandles:
        {
            [self.switchBtn setOn:kDataManager.remindDoorHandles ? YES : NO animated:NO];
            
            text = @"1. Press 'start', select the door handle model you like.\n2. Focus the camera on a vertical plane, detecting it.\n3. Tap screen to place the 'door handle'.\n4. Scale, drag it as you like.\n5. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
            self.content = @"1. Focus the camera on a vertical plane, detecting it.\n2. Tap screen to place the 'door handle'.\n3. Scale, drag it as you like.\n4. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
        }
            break;
        case ChallengeType_DirtyMoney:
        {
            [self.switchBtn setOn:kDataManager.remindDirtyMoney ? YES : NO animated:NO];
            
            text = @"1. Press 'start'.\n2. Focus the camera on a horizontal plane, detecting it.\n3. Tap screen to place the 'money'.\n4. Scale, drag it as you like.\n5. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
            self.content = @"1. Focus the camera on a horizontal plane, detecting it.\n2. Tap screen to place the 'money'.\n3. Scale, drag it as you like.\n4. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
        }
            break;
        case ChallengeType_DirtyBugs:
        {
            [self.switchBtn setOn:kDataManager.remindDirtyObjects ? YES : NO animated:NO];
            
            text = @"1. Press 'start'.\n2. Focus the camera on a horizontal plane, detecting it.\n3. Tap screen to place the 'bug'.\n4. Scale, drag it as you like.\n5. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
            self.content = @"1. Focus the camera on a horizontal plane, detecting it.\n2. Tap screen to place the 'bug'.\n3. Scale, drag it as you like.\n4. All ready, feel it!\nWe believe you can beat the fear! Let's gogogo!";
        }
            break;
        default:
            break;
    }
    
    
    self.guidanceLabel.text = text;
}
- (IBAction)switchButtonClick:(UISwitch *)sender {
    BOOL flag = sender.isOn;
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            [[NSUserDefaults standardUserDefaults] setValue:@(flag) forKey:kRemindKeyShakeHands];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        case ChallengeType_DoorHandles:
        {
            [[NSUserDefaults standardUserDefaults] setValue:@(flag) forKey:kRemindKeyDoorHandles];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        case ChallengeType_DirtyMoney:
        {
            [[NSUserDefaults standardUserDefaults] setValue:@(flag) forKey:kRemindKeyDirtyMoney];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        case ChallengeType_DirtyBugs:
        {
            [[NSUserDefaults standardUserDefaults] setValue:@(flag) forKey:kRemindKeyDirtyObjects];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        default:
            break;
    }
}

- (IBAction)startButtonClick:(UIButton *)sender {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSCameraUsageDescription"];
            [self showPermissionAlertWithDescription:accessDescription];
        });
        return;
    }
    
    
    ModelSelViewController *vc = kHomeStoryboardWithID(@"ModelSelViewController");
    vc.modalPresentationStyle = UIModalPresentationPageSheet;
    vc.challengeType = self.challengeType;
    @weakify(self);

    
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            vc.block = ^(NSString *sceneName) {
                @strongify(self);
                AR3DViewController *vc = kHomeStoryboardWithID(@"AR3DViewController");
                vc.challengeType = self.challengeType;
                vc.sceneName = sceneName;
                vc.content = self.content;
                [self.navigationController pushViewController:vc animated:YES];
                
            };
            [self.tabBarController presentViewController:vc animated:YES completion:NULL];
            
        }
            break;
        case ChallengeType_DoorHandles:
        {
            vc.block = ^(NSString *sceneName) {
                @strongify(self);
                AR3DViewController *vc = kHomeStoryboardWithID(@"AR3DViewController");
                vc.challengeType = self.challengeType;
                vc.sceneName = sceneName;
                vc.content = self.content;
                [self.navigationController pushViewController:vc animated:YES];
                
            };
            [self.tabBarController presentViewController:vc animated:YES completion:NULL];
        }
            break;
        case ChallengeType_DirtyMoney:
        {
            AR3DViewController *vc = kHomeStoryboardWithID(@"AR3DViewController");
            vc.challengeType = self.challengeType;
            vc.sceneName = @"ARAssets.scnassets/usdModelScn.scn";
            vc.content = self.content;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ChallengeType_DirtyBugs:
        {
            AR3DViewController *vc = kHomeStoryboardWithID(@"AR3DViewController");
            vc.challengeType = self.challengeType;
            vc.sceneName = @"ARAssets.scnassets/cockroach.dae";
            vc.content = self.content;
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
