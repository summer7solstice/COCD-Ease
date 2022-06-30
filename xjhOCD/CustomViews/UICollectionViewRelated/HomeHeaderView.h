//
//  HomeHeaderView.h
//  xjhOCD
//
//  Created by xjhuang on 14/06/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalLabel;
@property(nonatomic, copy) ActionBlock moodBlock;
@property(nonatomic, copy) ActionBlock erpBlock;

@property (nonatomic, assign) BOOL isShow;
@end

NS_ASSUME_NONNULL_END
