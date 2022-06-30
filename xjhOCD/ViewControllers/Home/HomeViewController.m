//
//  HomeViewController.m
//  xjhOCD
//
//  Created by xjhuang on 13/06/2022.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeCollectionViewCell.h"
#import "HomeViewModel.h"
#import "QuickAccessViewController.h"
#import "MoodTrackerViewController.h"
#import "ARViewController.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) HomeViewModel *viewModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 16, 16, 16);
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
}
#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.viewModel.dataSource[indexPath.item];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dict[kCellID] forIndexPath:indexPath];
    CellForRowBlock block = dict[kCellForRow];
    if (block) {
        block(dict, cell, indexPath);
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.viewModel.dataSource[indexPath.item];
    DidSelectRowBlock block = dict[kCellDidSelectRow];
    if (block) {
        block(dict, indexPath);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView;
    if (kind == UICollectionElementKindSectionHeader)
    {
        HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderView" forIndexPath:indexPath];
        reusableView = headerView;
        @weakify(self);
        headerView.moodBlock = ^{
            @strongify(self);
//            MoodTrackerViewController *vc = kHomeStoryboardWithID(@"MoodTrackerViewController");
            ARViewController *vc = kHomeStoryboardWithID(@"ARViewController");
            [self.navigationController pushViewController:vc animated:YES];
        };
        headerView.erpBlock = ^{
            @strongify(self);
            
        };
    }
    return reusableView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double width = (XJ_SCREEN_WIDTH - 16 * 2) / 3.0;
    return CGSizeMake(floorf(width), floorf(width));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(XJ_SCREEN_WIDTH, 720);
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
#pragma mark - Custom tabbar delegate
- (void)customTabBarClickButtonAtIndex:(NSInteger)index
{
    NSLog(@"index == %ld", index);
    switch (index) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            QuickAccessViewController *vc = kHomeStoryboardWithID(@"QuickAccessViewController");
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Lazy
- (HomeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
        _viewModel.delegateVC = self;
        [_viewModel gainData:NO];
    }
    return _viewModel;
}
@end
