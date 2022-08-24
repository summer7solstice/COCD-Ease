//
//  AR3DViewController.h
//  xjhOCD
//
//  Created by xjhuang on 15/07/2022.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@class AR3DViewController;

@interface ARGestureControl : NSObject

@property (nonatomic, strong) SCNNode *selectedNode;

@property (nonatomic, weak) AR3DViewController *viewController;

- (void)setupGestureRecognizer;

@end
