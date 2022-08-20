//
//  ModelSelViewController.h
//  xjhOCD
//
//  Created by xjhuang on 31/07/2022.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelSelViewController : BaseViewController
@property(nonatomic, copy) IdBlock block;
@property (nonatomic, assign) ChallengeType challengeType;
@end

NS_ASSUME_NONNULL_END
