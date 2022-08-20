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
    
    ChallengeModel *model0 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-0",[DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"]]];
    ChallengeModel *model1 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-1",[DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"]]];
    ChallengeModel *model2 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-2",[DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"]]];
    ChallengeModel *model3 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-3",[DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"]]];
    
    NSInteger badge = 0;
    
    // show warnings
    if (kDataManager.remindShakeHands)
    {
        // check today's data
        self.remindLabel0.hidden = !XJObjectIsNil(model0);
        if (!self.remindLabel0.hidden)
        {
            badge ++;
        }
    }
    else
    {
        self.remindLabel0.hidden = YES;
    }
    
    if (kDataManager.remindDoorHandles)
    {
        // check today's data
        self.remindLabel1.hidden = !XJObjectIsNil(model1);
        if (!self.remindLabel1.hidden)
        {
            badge ++;
        }
    }
    else
    {
        self.remindLabel1.hidden = YES;
    }
    
    if (kDataManager.remindDirtyMoney)
    {
        // check today's data
        self.remindLabel2.hidden = !XJObjectIsNil(model2);
        if (!self.remindLabel2.hidden)
        {
            badge ++;
        }
    }
    else
    {
        self.remindLabel2.hidden = YES;
    }
    
    if (kDataManager.remindDirtyObjects)
    {
        // check today's data
        self.remindLabel3.hidden = !XJObjectIsNil(model3);
        if (!self.remindLabel3.hidden)
        {
            badge ++;
        }
    }
    else
    {
        self.remindLabel3.hidden = YES;
    }
    
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
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

}
- (IBAction)btn0Click:(UIButton *)sender {
    LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_ShakingHands;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btn1Click:(UIButton *)sender {
    LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_DoorHandles;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btn2Click:(UIButton *)sender {
    LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_DirtyMoney;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btn3Click:(UIButton *)sender {
    LaunchingViewController *vc = kHomeStoryboardWithID(@"LaunchingViewController");
    vc.hidesBottomBarWhenPushed = YES;
    vc.challengeType = ChallengeType_DirtyBugs;
    [self.navigationController pushViewController:vc animated:YES];
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
