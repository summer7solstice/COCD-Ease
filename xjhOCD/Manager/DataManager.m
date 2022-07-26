//
//  DataManager.m
//  xjhOCD
//
//  Created by xjhuang on 01/07/2022.
//

#import "DataManager.h"

@implementation DataManager
static DataManager *manager = nil;

+ (DataManager *)sharedManager
{
    @synchronized (self) {
        if (!manager) {
            manager = [[DataManager alloc] init];
            
            
        }
    }
    return manager;
}
#pragma mark - getter

/* 销毁单例 */
+ (void)deallocManager
{
    manager = nil;
}
#pragma mark - 覆写方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    }
    return manager;
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return manager;
}
-(id)copy{
    return self;
}
-(id)mutableCopy{
    return self;
}

- (BOOL)remindShakeHands
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kRemindKeyShakeHands];
    return [number isEqualToNumber:@(1)] ? YES : NO;
}
- (BOOL)remindDoorHandles
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kRemindKeyDoorHandles];
    return [number isEqualToNumber:@(1)] ? YES : NO;
}
- (BOOL)remindDirtyMoney
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kRemindKeyDirtyMoney];
    return [number isEqualToNumber:@(1)] ? YES : NO;
}
- (BOOL)remindDirtyObjects
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kRemindKeyDirtyObjects];
    return [number isEqualToNumber:@(1)] ? YES : NO;
}

#pragma mark - Data storage
- (void)saveChallenge:(NSDictionary *)dict
{
//    @"date"             : [DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"],
//    @"time"             : [DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"],
//    @"challengeType"    : @(self.challengeType),
//    @"timeLength"       : @(self.seconds),
//    @"moodScore"        :
//    @"moodString"
    
//    RLMResults *oldArray = [ChallengeModel objectsWhere:@"date = %@ AND challengeType = %@",dict[@"date"], dict[@"challengeType"]];
    ChallengeModel *oldModel = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-%@",dict[@"date"], dict[@"challengeType"]]];
    if (XJObjectIsNil(oldModel))
    {
        // create a new one
        ChallengeModel *newModel = [[ChallengeModel alloc] init];
        newModel.pKey = [NSString stringWithFormat:@"%@-%@",dict[@"date"], dict[@"challengeType"]];
        newModel.date = dict[@"date"];
        newModel.time = dict[@"time"];
        newModel.challengeType = dict[@"challengeType"];
        newModel.timeLength = dict[@"timeLength"];
        newModel.moodScore = dict[@"moodScore"];
        newModel.moodString = dict[@"moodString"];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [ChallengeModel createOrUpdateInDefaultRealmWithValue:newModel];
        [realm commitWriteTransaction];
    }
    else
    {
        // old one
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
//        ChallengeModel *oldModel = oldArray[0];
        NSInteger newTimeLength = [dict[@"timeLength"] integerValue];
        if (newTimeLength > oldModel.timeLength.integerValue)
        {
            oldModel.timeLength = @(newTimeLength).description;
            oldModel.time = dict[@"time"];
            oldModel.moodScore = dict[@"moodScore"];
            oldModel.moodString = dict[@"moodString"];
        }
        
        [ChallengeModel createOrUpdateInDefaultRealmWithValue:oldModel];
        [realm commitWriteTransaction];
    }
}
- (void)createFakeData
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSArray *moodArr = @[
        @"Happy",
        @"Nervous",
        @"Excited",
        @"Lonely",
        @"Relaxed",
        @"Stressed",
        @"Satisfied",
        @"Bored",
        @"Tired",
    ];
    for (int i = 0; i < 20; i++)
    {
        components.day = -1 - i;
        NSDate *preDay = [calendar dateByAddingComponents:components toDate:today options:NSCalendarMatchPreviousTimePreservingSmallerUnits];
        
        ChallengeModel *model0 = [[ChallengeModel alloc] init];
        model0.pKey = [NSString stringWithFormat:@"%@-0",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model0.date = [DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"];
        model0.time = [NSString stringWithFormat:@"%@ 00:00:00",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model0.challengeType = @"0";
        
        NSInteger r0 = arc4random() % 16;
        NSInteger m0 = arc4random() % 4;
        
        model0.timeLength = @(30 + r0).description;
        model0.moodScore = @(m0).description;
        model0.moodString = moodArr[arc4random()%9];
        
        ChallengeModel *model1 = [[ChallengeModel alloc] init];
        model1.pKey = [NSString stringWithFormat:@"%@-1",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model1.date = [DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"];
        model1.time = [NSString stringWithFormat:@"%@ 00:00:00",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model1.challengeType = @"1";
        
        NSInteger r1 = arc4random() % 16;
        NSInteger m1 = arc4random() % 4;
        
        model1.timeLength = @(30 + r1).description;
        model1.moodScore = @(m1).description;
        model1.moodString = moodArr[arc4random()%9];
        
        ChallengeModel *model2 = [[ChallengeModel alloc] init];
        model2.pKey = [NSString stringWithFormat:@"%@-2",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model2.date = [DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"];
        model2.time = [NSString stringWithFormat:@"%@ 00:00:00",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model2.challengeType = @"2";
        
        NSInteger r2 = arc4random() % 16;
        NSInteger m2 = arc4random() % 4;
        
        model2.timeLength = @(30 + r2).description;
        model2.moodScore = @(m2).description;
        model2.moodString = moodArr[arc4random()%9];
        
        ChallengeModel *model3 = [[ChallengeModel alloc] init];
        model3.pKey = [NSString stringWithFormat:@"%@-3",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model3.date = [DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"];
        model3.time = [NSString stringWithFormat:@"%@ 00:00:00",[DateUtil getStringFromDate:preDay format:@"yyyy-MM-dd"]];
        model3.challengeType = @"3";
        
        NSInteger r3 = arc4random() % 16;
        NSInteger m3 = arc4random() % 4;
        
        model3.timeLength = @(30 + r3).description;
        model3.moodScore = @(m3).description;
        model3.moodString = moodArr[arc4random()%9];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [ChallengeModel createOrUpdateInDefaultRealmWithValue:model0];
        [ChallengeModel createOrUpdateInDefaultRealmWithValue:model1];
        [ChallengeModel createOrUpdateInDefaultRealmWithValue:model2];
        [ChallengeModel createOrUpdateInDefaultRealmWithValue:model3];
        [realm commitWriteTransaction];
    }
}
@end
