//
//  HomeViewModel.m
//  xjhOCD
//
//  Created by xjhuang on 15/06/2022.
//

#import "HomeViewModel.h"
#import "HomeCollectionViewCell.h"
#import "QuickAccessViewController.h"
#import "HomeViewController.h"
@implementation HomeViewModel
- (NSMutableArray<NSDictionary *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)gainData:(BOOL)isQuick
{
    [self.dataSource removeAllObjects];
    @weakify(self);
    NSDictionary *dict0 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_fast")];
            cell.textLabel.text = @"Quick Access";
            cell.bgView.backgroundColor = UIColor.whiteColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            @strongify(self);
            [self quickFunc];
        })
        };
    
    NSDictionary *dict1 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_diary")];
            cell.textLabel.text = @"Thought Diary";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict2 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_whatIf")];
            cell.textLabel.text = @"What If ?";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict3 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_session")];
            cell.textLabel.text = @"Session Recaps";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict4 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_relief")];
            cell.textLabel.text = @"Quick Relief Methods";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict5 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_export")];
            cell.textLabel.text = @"Export Data";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict6 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_forum")];
            cell.textLabel.text = @"Forum";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict7 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_relaxation")];
            cell.textLabel.text = @"Relaxation Zone";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict8 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_voice")];
            cell.textLabel.text = @"Voice Activation";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict9 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_sleep")];
            cell.textLabel.text = @"Sleep Logs";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict10 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_pill")];
            cell.textLabel.text = @"Pill Reminder";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    NSDictionary *dict11 = @{
        kCellID:@"HomeCollectionViewCell",
        kCellForRow:cellForRowBlock(^(NSDictionary *dict, HomeCollectionViewCell *cell, NSIndexPath *indexPath) {
            [cell.iconImageView setImage:XJImageNamed(@"icon_cell_calendar")];
            cell.textLabel.text = @"Calendar";
            cell.bgView.backgroundColor = UIColor.clearColor;
        }),
        kCellDidSelectRow:didSelectRowBlock(^(NSDictionary *dict, NSIndexPath *indexPath) {
            
        })
        };
    
    if (isQuick)
    {
        [self.dataSource addObject:dict1];
        [self.dataSource addObject:dict2];
        [self.dataSource addObject:dict5];
        [self.dataSource addObject:dict6];
        [self.dataSource addObject:dict7];
        [self.dataSource addObject:dict11];
    }
    else
    {
        [self.dataSource addObject:dict0];
        [self.dataSource addObject:dict1];
        [self.dataSource addObject:dict2];
        [self.dataSource addObject:dict3];
        [self.dataSource addObject:dict4];
        [self.dataSource addObject:dict5];
        [self.dataSource addObject:dict6];
        [self.dataSource addObject:dict7];
        [self.dataSource addObject:dict8];
        [self.dataSource addObject:dict9];
        [self.dataSource addObject:dict10];
        [self.dataSource addObject:dict11];
    }
}
- (void)quickFunc{
    QuickAccessViewController *vc = kHomeStoryboardWithID(@"QuickAccessViewController");
    [self.delegateVC.navigationController pushViewController:vc animated:YES];
}
@end
