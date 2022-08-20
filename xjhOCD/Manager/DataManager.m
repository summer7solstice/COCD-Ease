//
//  DataManager.m
//  xjhOCD
//
//  Created by xjhuang on 01/07/2022.
//

#import "DataManager.h"
#import <xlsxwriter.h>
#import <Photos/Photos.h>

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

#pragma mark - Save Image locally
- (void)saveImageToLocalDevice:(UIImage *)image
{
    [self savePhoto:image];
}
- (void)savePhoto:(UIImage *)image
{
    //每次都会走进来
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
            // 无权限 做一个友好的提示
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"Please" message:@"Please grand the rights for camera \n setting>private>camera" delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:nil, nil];
            [alart show];
            return;
        }
    }];
    
    // 1.先保存图片到【相机胶卷】
    /// 同步执行修改操作
    NSError *error = nil;
    __block PHObjectPlaceholder *placeholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        placeholder =  [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
    } error:&error];
    if (error) {
        NSLog(@"save failed");
        return;
    }
    // 2.拥有一个【自定义相册】
    PHAssetCollection * assetCollection = [self createCollection];
    if (assetCollection == nil) {
        NSLog(@"collection creation failed");
    }
    // 3.将刚才保存到【相机胶卷】里面的图片引用到【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        PHAssetCollectionChangeRequest *requtes = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [requtes addAssets:@[placeholder]];
    } error:&error];
    if (error) {
        NSLog(@"save failed");
    } else {
        NSLog(@"save successfully");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showToastHUD:@"Save successfully"];
        });
    }
}
- (PHAssetCollection *)createCollection
{
    //获取软件的名字作为相册的标题
    NSString *appTitle = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    //获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:appTitle]) {
            return collection;
        }
    }
    //代码执行到这里，说明还没有自定义相册
    __block NSString *createdCollectionId = nil;
    //创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    if (createdCollectionId == nil) return nil;
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
}

- (void)saveExcelToDevice
{
    // filePath
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@.xlsx",[DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd-HH-mm-ss"]]];
    
    // init xlsx, turning to C
    lxw_workbook  *workbook  = workbook_new([filename UTF8String]);
    
    lxw_format *format = workbook_add_format(workbook);

    format_set_bold(format);
    format_set_align(format, LXW_ALIGN_LEFT);
    format_set_align(format, LXW_ALIGN_VERTICAL_CENTER);
    
    NSArray *titleArray = @[@"Shaking hands",@"Door handles",@"Dirty money",@"Dirty bug"];
    
    [titleArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // init sheet
        lxw_worksheet *worksheet = workbook_add_worksheet(workbook, [obj UTF8String]);
        
        // only col 0 ~ 5 are needed
        worksheet_set_column(worksheet, 0, 5, 40, NULL);
        
        // table header
        worksheet_write_string(worksheet, 0, 0, "Challenge Type", format);
        worksheet_write_string(worksheet, 0, 1, "Date", format);
        worksheet_write_string(worksheet, 0, 2, "Time", format);
        worksheet_write_string(worksheet, 0, 3, "Timelength (second)", format);
        worksheet_write_string(worksheet, 0, 4, "Mood score (from 0 to 4, 'low' to 'high')", format);
        worksheet_write_string(worksheet, 0, 5, "Mood string (picked by user)", format);
        
        // write data in
        RLMResults *result = [[ChallengeModel objectsWhere:[NSString stringWithFormat:@"challengeType = '%ld'",idx]] sortedResultsUsingKeyPath:@"date" ascending:YES];
        int rowIdx = 1;
        for (ChallengeModel *model in result) {
            worksheet_write_string(worksheet, rowIdx, 0, [obj UTF8String], format);
            worksheet_write_string(worksheet, rowIdx, 1, [model.date UTF8String], format);
            worksheet_write_string(worksheet, rowIdx, 2, [model.time UTF8String], format);
            worksheet_write_string(worksheet, rowIdx, 3, [model.timeLength UTF8String], format);
            worksheet_write_string(worksheet, rowIdx, 4, [model.moodScore UTF8String], format);
            worksheet_write_string(worksheet, rowIdx, 5, [model.moodString UTF8String], format);
            rowIdx ++;
        }
    }];
    workbook_close(workbook);
}
@end
