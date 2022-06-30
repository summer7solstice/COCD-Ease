//
//  HomeCollectionViewCell.h
//  xjhOCD
//
//  Created by xjhuang on 15/06/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

NS_ASSUME_NONNULL_END
