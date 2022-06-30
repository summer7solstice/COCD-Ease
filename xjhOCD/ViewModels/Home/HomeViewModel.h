//
//  HomeViewModel.h
//  xjhOCD
//
//  Created by xjhuang on 15/06/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject
@property (copy, nonatomic) NSMutableArray<NSDictionary *>          *dataSource;
@property (weak, nonatomic) UIViewController                      *delegateVC;
- (void)gainData:(BOOL)isQuick;
@end

NS_ASSUME_NONNULL_END
