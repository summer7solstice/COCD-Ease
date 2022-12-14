//
//  AR3DViewController.m
//  xjhOCD
//
//  Created by xjhuang on 15/07/2022.
//

#import "AR3DViewController.h"
#import "EvaluationViewController.h"
#import "ARGestureControl.h"
#import <Photos/Photos.h>
#import "AlertViewController.h"

@interface AR3DViewController ()<ARSCNViewDelegate>

@property (nonatomic, strong) RACDisposable *disposable;
@property (nonatomic, assign) NSInteger seconds;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (nonatomic, strong) ARGestureControl *gestureControl;
@property (nonatomic, assign) ARPlaneDetection planeDetection;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeButton;

@end

@implementation AR3DViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    if (ARWorldTrackingConfiguration.isSupported)
    {
        [self startSession];
        if (self.challengeType == ChallengeType_DoorHandles)
        {
//            self.sceneName = @"ARAssets.scnassets/cockroach.dae";
        }
        else if (self.challengeType == ChallengeType_ShakingHands)
        {
//            self.sceneName = @"ARAssets.scnassets/hand4.dae";
        }
        else if (self.challengeType == ChallengeType_DirtyMoney)
        {
//            self.sceneName = @"ARAssets.scnassets/usdModelScn.scn";
        }
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Sorry, AR is not supported by your device." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self endCount];
    [self.sceneView.session pause];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.gestureControl = [[ARGestureControl alloc] init];
    self.gestureControl.viewController = self;
    [self.gestureControl setupGestureRecognizer];
}
- (void)setupUI
{
    self.sceneView.delegate = self;
    self.sceneView.showsStatistics = NO;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.debugOptions = SCNDebugOptionNone;
    
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
    
}

- (void)startSession
{
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = self.planeDetection;
    [self.sceneView.session runWithConfiguration:configuration];
}
- (void)refreshSession
{
    for (SCNNode *node in self.sceneNode) {
        [node removeFromParentNode];
    }
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = self.planeDetection;
    [self.sceneView.session runWithConfiguration:configuration options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];

}
#pragma mark - ARSCNViewDelegate
- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showToastHUD:@"Surface detected, tap to place the object."];
    });
}
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}
- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    [self showToastHUD:@"Please try refresh the session."];
}

- (void)sessionWasInterrupted:(ARSession *)session {
    [self showToastHUD:@"Session interrupted."];
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    [self refreshSession];
}

#pragma mark - Count Func
- (void)startCount
{
    if (!XJObjectIsNil(self.disposable)) {
        return;
    }
    self.seconds = 0;
    @weakify(self);
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        self.seconds ++;
        NSInteger minutes = self.seconds / 60;
        NSInteger seconds = self.seconds % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", minutes, seconds];
    }];
    self.backToHomeButton.hidden = YES;
}
- (void)endCount
{
    [self.disposable dispose];
}

#pragma mark - Actions
- (IBAction)finishButtonClick:(UIButton *)sender {
    if (self.seconds == 0) {
//        [self showToastHUD:@"You havn't started the challenge, why not have a try."];
        AlertViewController *vc = kHomeStoryboardWithID(@"AlertViewController");
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vc.content = self.content;
        [self presentViewController:vc animated:YES completion:NULL];
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Do you want to finish this challenge?" message:@"The data will be stored locally." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Keep going" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm finish" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self endCount];
        EvaluationViewController *vc = kHomeStoryboardWithID(@"EvaluationViewController");
        vc.hidesBottomBarWhenPushed = YES;
        vc.tempDict = @{
            @"date"             : [DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"],
            @"time"             : [DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"],
            @"challengeType"    : @(self.challengeType).description,
            @"timeLength"       : @(self.seconds).description,
        };
        [self.navigationController popToRootAndPushViewController:vc];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)snapshotAction:(id)sender {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
            // ????????? ????????????????????????
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSPhotoLibraryUsageDescription"];
                [self showPermissionAlertWithDescription:accessDescription];
            });
            return;
        }
    }];
    
    UIImage *image = [self.sceneView snapshot];
    [kDataManager saveImageToLocalDevice:image];
}
- (IBAction)backToHomeButtonClick:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSMutableArray<SCNNode *> *)sceneNode
{
    if (!_sceneNode)
    {
        _sceneNode = [NSMutableArray array];
    }
    return _sceneNode;
}
- (ARPlaneDetection)planeDetection
{
    if (self.challengeType == ChallengeType_DoorHandles)
    {
        return ARPlaneDetectionVertical;
    }
    else if (self.challengeType == ChallengeType_ShakingHands)
    {
        return ARPlaneDetectionVertical;
    }
    else if (self.challengeType == ChallengeType_DirtyMoney)
    {
        return ARPlaneDetectionHorizontal;
    }
    else if (self.challengeType == ChallengeType_DirtyBugs)
    {
        return ARPlaneDetectionHorizontal;
    }
    return ARPlaneDetectionNone;
}
@end
