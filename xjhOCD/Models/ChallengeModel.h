//
//  ChallengeModel.h
//  xjhOCD
//
//  Created by xjhuang on 18/07/2022.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
NS_ASSUME_NONNULL_BEGIN

@interface ChallengeModel : RLMObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *challengeType;
@property (nonatomic, strong) NSString *timeLength;
@property (nonatomic, strong) NSString *moodScore;
@property (nonatomic, strong) NSString *moodString;

@property (nonatomic, strong) NSString *pKey;
@end

RLM_ARRAY_TYPE(ChallengeModel)
NS_ASSUME_NONNULL_END
