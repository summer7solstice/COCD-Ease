//
//  AR3DViewController.h
//  xjhOCD
//
//  Created by xjhuang on 15/07/2022.
//

#import "ARGestureControl.h"
#import "AR3DViewController.h"
@interface ARGestureControl ()

//@property (nonatomic, strong) SCNHitTestResult *removeHitResult;
@property (nonatomic, strong) ARHitTestResult *initialHitTestResult;
@property (nonatomic, strong) SCNNode *movedObject;

@end

@implementation ARGestureControl

#pragma mark - Set Gesture Recognizers

- (void)setupGestureRecognizer {
    
    // Place
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAddObjectFrom:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.viewController.sceneView addGestureRecognizer:tapGestureRecognizer];
    
    // Move
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMoveObjectFrom:)];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [panGestureRecognizer setMinimumNumberOfTouches:1];
    [self.viewController.sceneView addGestureRecognizer:panGestureRecognizer];
    
    // Scale
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleScaleObjectFrom:)];
    [self.viewController.sceneView addGestureRecognizer:pinchGestureRecognizer];
}

#pragma mark - GestureRecognizer

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - Handle Gesture Recognizers

- (void)handleAddObjectFrom: (UITapGestureRecognizer *)recognizer {
    
    [self checkExistingARObjectToInsertOrRemove:recognizer];
}

-(void)handleMoveObjectFrom:(UIPanGestureRecognizer *)recognizer {
    
    [self moveAndDragARObject:recognizer];
}

- (void)handleScaleObjectFrom: (UIPinchGestureRecognizer *)recognizer {
    
    [self scaleARObject:recognizer];
}

#pragma mark - Check Existing ARObject To Insert Or Remove

- (void)checkExistingARObjectToInsertOrRemove:(UITapGestureRecognizer *) recognizer {
    
    CGPoint holdPoint = [recognizer locationInView:self.viewController.sceneView];
    NSArray<SCNHitTestResult *> *result = [self.viewController.sceneView hitTest:holdPoint
                                                          options:@{SCNHitTestBoundingBoxOnlyKey: @YES, SCNHitTestFirstFoundOnlyKey: @YES}];
    if (result.count == 0) {
//        if (!self.viewController.sceneNode.count)
//        {
            [self insertARObject:recognizer];
//        }
    } else {
    }
}

#pragma mark - Insert AR Object

- (void)insertARObject:(UITapGestureRecognizer *)recognizer {
    
    CGPoint tapPoint = [recognizer locationInView:self.viewController.sceneView];
    NSArray<ARHitTestResult *> *result = [self.viewController.sceneView hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    
    if (result.count == 0) {
        return;
    }
    
    ARHitTestResult *hitResult = [result firstObject];
    
    SCNScene *scene = [SCNScene sceneNamed:self.viewController.sceneName];
    SCNNode *node = [scene.rootNode clone];
    float insertionYOffset = 0.01;
    
    node.position = SCNVector3Make(
                                    hitResult.worldTransform.columns[3].x,
                                    hitResult.worldTransform.columns[3].y + insertionYOffset,
                                    hitResult.worldTransform.columns[3].z
                                    );
    [self.viewController.sceneNode addObject:node];
    [self.viewController.sceneView.scene.rootNode addChildNode:node];
    [self.viewController startCount];
}
#pragma mark - Move/Drag AR Object

-(void)moveAndDragARObject:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint tapPoint = [recognizer locationInView:self.viewController.sceneView];
        NSArray <SCNHitTestResult *> *result = [self.viewController.sceneView hitTest:tapPoint options:nil];
        NSArray <ARHitTestResult *> *hitResults = [self.viewController.sceneView hitTest:tapPoint types:ARHitTestResultTypeFeaturePoint];
        
        if ([result count] == 0) {
            return;
        }
        SCNHitTestResult *hitResult = [result firstObject];
        self.movedObject = [[hitResult node] parentNode];
        self.initialHitTestResult = [hitResults firstObject];
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.movedObject) {
            CGPoint tapPoint = [recognizer locationInView:self.viewController.sceneView];
            NSArray <ARHitTestResult *> *hitResults = [self.viewController.sceneView hitTest:tapPoint types:ARHitTestResultTypeFeaturePoint];
            ARHitTestResult *result = [hitResults lastObject];
            
            [SCNTransaction begin];
            
            SCNMatrix4 initialMatrix = SCNMatrix4FromMat4(self.initialHitTestResult.worldTransform);
            SCNVector3 initialVector = SCNVector3Make(initialMatrix.m41, initialMatrix.m42, initialMatrix.m43);
            
            SCNMatrix4 matrix = SCNMatrix4FromMat4(result.worldTransform);
            SCNVector3 vector = SCNVector3Make(matrix.m41, matrix.m42, matrix.m43);
            
            CGFloat dx= vector.x - initialVector.x;
            CGFloat dy= vector.y - initialVector.y;
            CGFloat dz= vector.z - initialVector.z;
            
            SCNVector3 newPositionVector = SCNVector3Make(self.movedObject.position.x+dx, self.movedObject.position.y+dy, self.movedObject.position.z+dz);
            
            [self.movedObject setPosition:newPositionVector];
            
            [SCNTransaction commit];
            
            self.initialHitTestResult = result;
        }
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.movedObject = nil;
        self.initialHitTestResult = nil;
    }
}

#pragma mark - Scale AR Object

- (void)scaleARObject:(UIPinchGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint tapPoint = [recognizer locationOfTouch:1 inView:self.viewController.sceneView];
        NSArray <SCNHitTestResult *> *result = [self.viewController.sceneView hitTest:tapPoint options:nil];
        if ([result count] == 0) {
            tapPoint = [recognizer locationOfTouch:0 inView:self.viewController.sceneView];
            result = [self.viewController.sceneView hitTest:tapPoint options:nil];
            if ([result count] == 0) {
                return;
            }
        }
        
        SCNHitTestResult *hitResult = [result firstObject];
        self.movedObject = [[hitResult node] parentNode];
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.movedObject) {
            CGFloat pinchScaleX = recognizer.scale * self.movedObject.scale.x;
            CGFloat pinchScaleY = recognizer.scale * self.movedObject.scale.y;
            CGFloat pinchScaleZ = recognizer.scale * self.movedObject.scale.z;
            [self.movedObject setScale:SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ)];
        }
        recognizer.scale = 1;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.movedObject = nil;
    }
}

@end
