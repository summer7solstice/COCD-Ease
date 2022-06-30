//
//  QuickAccessViewController.m
//  xjhOCD
//
//  Created by xjhuang on 15/06/2022.
//

#import "QuickAccessViewController.h"
#import "HomeViewModel.h"
#import "QuickAccessHeaderView.h"
@interface QuickAccessViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) HomeViewModel *viewModel;
@end

@implementation QuickAccessViewController

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
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView;
    if (kind == UICollectionElementKindSectionHeader)
    {
        QuickAccessHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QuickAccessHeaderView" forIndexPath:indexPath];
        reusableView = headerView;
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
    return CGSizeMake(XJ_SCREEN_WIDTH, 290);
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
- (HomeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
        _viewModel.delegateVC = self;
        [_viewModel gainData:YES];
    }
    return _viewModel;
}
@end
