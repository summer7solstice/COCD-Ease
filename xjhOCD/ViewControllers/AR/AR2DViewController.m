//
//  AR2DViewController.m
//  xjhOCD
//
//  Created by xjhuang on 15/07/2022.
//

#import "AR2DViewController.h"
#import "EvaluationViewController.h"
#import "Scene.h"
@interface AR2DViewController ()<ARSKViewDelegate>
@property (nonatomic, strong) IBOutlet ARSKView *sceneView;
@property (nonatomic, strong) RACDisposable *disposable;
@property (nonatomic, assign) NSInteger seconds;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@end

@implementation AR2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the view's delegate
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and node count
    self.sceneView.showsFPS = YES;
//    self.sceneView.showsNodeCount = YES;
    
    // Load the SKScene from 'Scene.sks'
    Scene *scene = (Scene *)[SKScene nodeWithFileNamed:@"Scene"];
    
    // Present the scene
    [self.sceneView presentScene:scene];
    
    [self startCount];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self endCount];
    // Pause the view's session
    [self.sceneView.session pause];
}

#pragma mark - ARSKViewDelegate

- (SKNode *)view:(ARSKView *)view nodeForAnchor:(ARAnchor *)anchor {
    UIImage *image = [UIImage imageNamed:@"icon_update_rocket"];
    SKTexture *texture = [SKTexture textureWithImage:image];
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture size:CGSizeMake(20, 40)];
    return node;
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

#pragma mark - Count Func
- (void)startCount
{
    self.seconds = 0;
    @weakify(self);
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        self.seconds ++;
        NSInteger minutes = self.seconds / 60;
        NSInteger seconds = self.seconds % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", minutes, seconds];
    }];
}
- (void)endCount
{
    [self.disposable dispose];
}

#pragma mark - Actions
- (IBAction)finishButtonClick:(UIButton *)sender {
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
@end
