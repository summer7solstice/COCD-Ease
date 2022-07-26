//
//  ARGestureControl.h
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@class AR3DViewController;

@interface ARGestureControl : NSObject

@property (nonatomic, strong) SCNNode *selectedNode;

@property (nonatomic, weak) AR3DViewController *viewController;

- (void)setupGestureRecognizer;
- (void)removeARObject:(id)sender;

@end
