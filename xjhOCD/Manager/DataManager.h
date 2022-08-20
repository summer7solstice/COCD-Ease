//
//  DataManager.h
//  xjhOCD
//
//  Created by xjhuang on 01/07/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject
+ (DataManager *)sharedManager;

@property (nonatomic, assign) BOOL remindShakeHands;
@property (nonatomic, assign) BOOL remindDoorHandles;
@property (nonatomic, assign) BOOL remindDirtyMoney;
@property (nonatomic, assign) BOOL remindDirtyObjects;

- (void)saveChallenge:(NSDictionary *)dict;

- (void)createFakeData;

- (void)saveImageToLocalDevice:(UIImage *)image;

- (void)saveExcelToDevice;
@end

NS_ASSUME_NONNULL_END
