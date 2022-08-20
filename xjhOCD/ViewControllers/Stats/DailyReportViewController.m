//
//  DailyReportViewController.m
//  xjhOCD
//
//  Created by xjhuang on 21/07/2022.
//

#import "DailyReportViewController.h"

@interface DailyReportViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon0;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UILabel *mood0;
@property (weak, nonatomic) IBOutlet UILabel *mood1;
@property (weak, nonatomic) IBOutlet UILabel *mood2;
@property (weak, nonatomic) IBOutlet UILabel *mood3;
@property (weak, nonatomic) IBOutlet UIImageView *check0;
@property (weak, nonatomic) IBOutlet UIImageView *check1;
@property (weak, nonatomic) IBOutlet UIImageView *check2;
@property (weak, nonatomic) IBOutlet UIImageView *check3;
@property (weak, nonatomic) IBOutlet UILabel *time0;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *time3;
@end

@implementation DailyReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}
- (void)setupUI
{
    [self setTitle:@"Daily report"];
}
- (void)loadData
{
    ChallengeModel *model0 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-0",[DateUtil getStringFromDate:self.date format:@"yyyy-MM-dd"]]];
    ChallengeModel *model1 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-1",[DateUtil getStringFromDate:self.date format:@"yyyy-MM-dd"]]];
    ChallengeModel *model2 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-2",[DateUtil getStringFromDate:self.date format:@"yyyy-MM-dd"]]];
    ChallengeModel *model3 = [ChallengeModel objectForPrimaryKey:[NSString stringWithFormat:@"%@-3",[DateUtil getStringFromDate:self.date format:@"yyyy-MM-dd"]]];
    
    NSDictionary *moodDict = @{
        @"1"     :   @"ic_unhappy_emoji",
        @"0"     :   @"ic_sad_emoji",
        @"2"     :   @"ic_soso_emoji",
        @"3"     :   @"ic_happy_emoji",
        @"4"     :   @"ic_fantastic_emoji"
    };
    if (!XJObjectIsNil(model0))
    {
        self.icon0.image = XJImageNamed(moodDict[model0.moodScore]);
        self.check0.image = XJImageNamed(@"ic_accomplish");
        self.mood0.text = model0.moodString;
        self.time0.text = [NSString stringWithFormat:@"%.2ld:%.2ld",model0.timeLength.integerValue / 60, model0.timeLength.integerValue % 60];
    }
    
    if (!XJObjectIsNil(model1))
    {
        self.icon1.image = XJImageNamed(moodDict[model1.moodScore]);
        self.check1.image = XJImageNamed(@"ic_accomplish");
        self.mood1.text = model1.moodString;
        self.time1.text = [NSString stringWithFormat:@"%.2ld:%.2ld",model1.timeLength.integerValue / 60, model1.timeLength.integerValue % 60];
    }
    
    if (!XJObjectIsNil(model2))
    {
        self.icon2.image = XJImageNamed(moodDict[model2.moodScore]);
        self.check2.image = XJImageNamed(@"ic_accomplish");
        self.mood2.text = model2.moodString;
        self.time2.text = [NSString stringWithFormat:@"%.2ld:%.2ld",model2.timeLength.integerValue / 60, model2.timeLength.integerValue % 60];
    }
    
    if (!XJObjectIsNil(model3))
    {
        self.icon3.image = XJImageNamed(moodDict[model3.moodScore]);
        self.check3.image = XJImageNamed(@"ic_accomplish");
        self.mood3.text = model3.moodString;
        self.time3.text = [NSString stringWithFormat:@"%.2ld:%.2ld",model3.timeLength.integerValue / 60, model3.timeLength.integerValue % 60];
    }
}
@end
