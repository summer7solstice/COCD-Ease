//
//  ModelSelViewController.m
//  xjhOCD
//
//  Created by xjhuang on 31/07/2022.
//

#import "ModelSelViewController.h"
#import "ModelSelCell.h"

@interface ModelSelViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ModelSelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)setupUI
{
    
}

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ModelSelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModelSelCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSource[indexPath.item];
    [cell.iconImageView setImage:XJImageNamed(dict[@"image"])];
    cell.nameLabel.text = dict[@"name"];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataSource[indexPath.item];
    if (self.block) {
        self.block(dict[@"fileName"]);
    }
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(XJ_SCREEN_WIDTH/2.0, XJ_SCREEN_WIDTH/2.0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - Lazy
- (NSArray *)dataSource
{
    NSArray *arr = @[];
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            arr = @[
                @{
                    @"image" : @"hand-0",
                    @"name" : @"Hand - 0",
                    @"fileName" : @"ARAssets.scnassets/hand-0.dae"
                },
                @{
                    @"image" : @"hand-1",
                    @"name" : @"Hand - 1",
                    @"fileName" : @"ARAssets.scnassets/hand-1.dae"
                },
            ];
        }
            break;
        case ChallengeType_DoorHandles:
        {
            arr = @[
                @{
                    @"image" : @"knob-0",
                    @"name" : @"Door handle - 0",
                    @"fileName" : @"ARAssets.scnassets/knob-0.usdz"
                },
                @{
                    @"image" : @"knob-1",
                    @"name" : @"Door handle - 1",
                    @"fileName" : @"ARAssets.scnassets/knob-1.dae"
                },
            ];
        }
            break;
        case ChallengeType_DirtyMoney:
        {
           
        }
            break;
        case ChallengeType_DirtyBugs:
        {
            
        }
            break;
        default:
            break;
    }
    return arr;
}
@end
