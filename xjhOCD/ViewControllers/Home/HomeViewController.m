//
//  HomeViewController.m
//  xjhOCD
//
//  Created by xjhuang on 13/06/2022.
//

#import "HomeViewController.h"
#import "LaunchingViewController.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UILabel *remindLabel0;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel1;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel2;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel3;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // show warnings
    if (kDataManager.remindShakeHands)
    {
        // check today's data
    }
    else
    {
        self.remindLabel0.hidden = YES;
    }
    
    if (kDataManager.remindDoorHandles)
    {
        // check today's data
    }
    else
    {
        self.remindLabel1.hidden = YES;
    }
    
    if (kDataManager.remindDirtyMoney)
    {
        // check today's data
    }
    else
    {
        self.remindLabel2.hidden = YES;
    }
    
    if (kDataManager.remindDirtyObjects)
    {
        // check today's data
    }
    else
    {
        self.remindLabel3.hidden = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"AR Exposures"];
    
    [self setupUI];
}
- (void)setupUI
{
    //add shadow
    [self addShadowForView:self.view0];
    [self addShadowForView:self.view1];
    [self addShadowForView:self.view2];
    [self addShadowForView:self.view3];
    
    //add functions
    @weakify(self);
    [self.view0 bk_whenTapped:^{
        @strongify(self);
        LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
        vc.hidesBottomBarWhenPushed = YES;
        vc.challengeType = ChallengeType_ShakingHands;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view1 bk_whenTapped:^{
        @strongify(self);
        LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
        vc.hidesBottomBarWhenPushed = YES;
        vc.challengeType = ChallengeType_DoorHandles;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view2 bk_whenTapped:^{
        @strongify(self);
        LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
        vc.hidesBottomBarWhenPushed = YES;
        vc.challengeType = ChallengeType_DirtyMoney;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view3 bk_whenTapped:^{
        @strongify(self);
        LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
        vc.hidesBottomBarWhenPushed = YES;
        vc.challengeType = ChallengeType_DirtyObjects;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)addShadowForView:(UIView *)view
{
    view.layer.cornerRadius = 16;
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1000].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,4);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 9;
}
@end
