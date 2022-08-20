//
//  AR3DViewController.h
//  xjhOCD
//
//  Created by xjhuang on 15/07/2022.
//

#import "BaseViewController.h"
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AR3DViewController : BaseViewController
@property (weak, nonatomic) IBOutlet ARSCNView *sceneView;
@property (nonatomic, assign) ChallengeType challengeType;
@property (nonatomic, copy) NSString *sceneName;
@property (nonatomic, strong) NSMutableArray<SCNNode *> *sceneNode;
- (void)startCount;
@end

NS_ASSUME_NONNULL_END
