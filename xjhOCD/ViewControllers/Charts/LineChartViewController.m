//
//  LineChartViewController.m
//  xjhOCD
//
//  Created by xjhuang on 15/07/2022.
//

#import "LineChartViewController.h"
#import "AAChartKit.h"

@interface LineChartViewController ()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (nonatomic, strong) AAChartView *chartView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segButton;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@end

@implementation LineChartViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self forceToOrientation:UIDeviceOrientationLandscapeLeft];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self forceToOrientation:UIDeviceOrientationPortrait];
}
- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}
-(void)forceToOrientation:(UIDeviceOrientation)orientation
{
    NSNumber *orientation0 = [NSNumber numberWithInt:0];
    [[UIDevice currentDevice] setValue:orientation0 forKey:@"orientation"];
    
    
    NSNumber *orientation1 = [NSNumber numberWithInteger:orientation];
    [[UIDevice currentDevice] setValue:orientation1 forKey:@"orientation"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)setupUI
{
    [self.baseView addSubview:self.chartView];
    [self.baseView insertSubview:self.chartView atIndex:0];
    
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.baseView);
    }];
    
    AAChartModel *aaChartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeLine)
    .zoomTypeSet(AAChartZoomTypeXY)
    .yAxisTitleSet(@"Seconds")
    .dataLabelsEnabledSet(YES);
    
    self.aaChartModel = aaChartModel;
    
    switch (self.challengeType) {
        case ChallengeType_ShakingHands:
        {
            [aaChartModel setTitle:@"Shaking Hands"];
            RLMResults *result = [[ChallengeModel objectsWhere:@"challengeType = '0'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray = [[NSMutableArray alloc] init];
            NSMutableArray *yArray = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result)
            {
                [xArray addObject:model.date];
                [yArray addObject:@(model.timeLength.integerValue)];
            }
            [aaChartModel setCategories:xArray];
            AASeriesElement *element = [[AASeriesElement alloc] init];
            element.name = @"Shaking Hands";
            element.data = yArray;
            [aaChartModel setSeries:@[element]];
        }
            break;
        case ChallengeType_DoorHandles:
        {
            [aaChartModel setTitle:@"Door Handles"];
            RLMResults *result = [[ChallengeModel objectsWhere:@"challengeType = '1'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray = [[NSMutableArray alloc] init];
            NSMutableArray *yArray = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result)
            {
                [xArray addObject:model.date];
                [yArray addObject:@(model.timeLength.integerValue)];
            }
            [aaChartModel setCategories:xArray];
            AASeriesElement *element = [[AASeriesElement alloc] init];
            element.name = @"Door Handles";
            element.data = yArray;
            [aaChartModel setSeries:@[element]];
        }
            break;
        case ChallengeType_DirtyMoney:
        {
            [aaChartModel setTitle:@"Dirty Money"];
            RLMResults *result = [[ChallengeModel objectsWhere:@"challengeType = '2'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray = [[NSMutableArray alloc] init];
            NSMutableArray *yArray = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result)
            {
                [xArray addObject:model.date];
                [yArray addObject:@(model.timeLength.integerValue)];
            }
            [aaChartModel setCategories:xArray];
            AASeriesElement *element = [[AASeriesElement alloc] init];
            element.name = @"Dirty Money";
            element.data = yArray;
            [aaChartModel setSeries:@[element]];
        }
            break;
        case ChallengeType_DirtyBugs:
        {
            [aaChartModel setTitle:@"Dirty Bugs"];
            RLMResults *result = [[ChallengeModel objectsWhere:@"challengeType = '3'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray = [[NSMutableArray alloc] init];
            NSMutableArray *yArray = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result)
            {
                [xArray addObject:model.date];
                [yArray addObject:@(model.timeLength.integerValue)];
            }
            [aaChartModel setCategories:xArray];
            AASeriesElement *element = [[AASeriesElement alloc] init];
            element.name = @"Dirty Bugs";
            element.data = yArray;
            [aaChartModel setSeries:@[element]];
        }
            break;
        case ChallengeType_AllInOne:
        {
            [aaChartModel setTitle:@"All in one"];
            
            RLMResults *result0 = [[ChallengeModel objectsWhere:@"challengeType = '0'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray0 = [[NSMutableArray alloc] init];
            NSMutableArray *yArray0 = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result0)
            {
                [xArray0 addObject:model.date];
                [yArray0 addObject:@(model.timeLength.integerValue)];
            }
            AASeriesElement *element0 = [[AASeriesElement alloc] init];
            element0.name = @"Shaking hands";
            element0.data = yArray0;
            
            RLMResults *result1 = [[ChallengeModel objectsWhere:@"challengeType = '1'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray1 = [[NSMutableArray alloc] init];
            NSMutableArray *yArray1 = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result1)
            {
                [xArray1 addObject:model.date];
                [yArray1 addObject:@(model.timeLength.integerValue)];
            }
            AASeriesElement *element1 = [[AASeriesElement alloc] init];
            element1.name = @"Door Handles";
            element1.data = yArray1;
            
            RLMResults *result2 = [[ChallengeModel objectsWhere:@"challengeType = '2'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray2 = [[NSMutableArray alloc] init];
            NSMutableArray *yArray2 = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result2)
            {
                [xArray2 addObject:model.date];
                [yArray2 addObject:@(model.timeLength.integerValue)];
            }
            AASeriesElement *element2 = [[AASeriesElement alloc] init];
            element2.name = @"Dirty Money";
            element2.data = yArray2;
            
            RLMResults *result3 = [[ChallengeModel objectsWhere:@"challengeType = '3'"] sortedResultsUsingKeyPath:@"date" ascending:YES];
            NSMutableArray *xArray3 = [[NSMutableArray alloc] init];
            NSMutableArray *yArray3 = [[NSMutableArray alloc] init];
            for (ChallengeModel *model in result3)
            {
                [xArray3 addObject:model.date];
                [yArray3 addObject:@(model.timeLength.integerValue)];
            }
            AASeriesElement *element3 = [[AASeriesElement alloc] init];
            element3.name = @"Dirty Bugs";
            element3.data = yArray3;
            
            [aaChartModel setSeries:@[element0,element1,element2,element3]];
            
            
            NSArray *sortedArray = [@[xArray0,xArray1,xArray2,xArray3] sortedArrayUsingComparator:^NSComparisonResult(NSArray *obj1, NSArray *obj2) {
                if (obj1.count < obj2.count)
                {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                if (obj1.count > obj2.count)
                {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            [aaChartModel setCategories:sortedArray[0]];
        }
            break;
        default:
            break;
    }
    
    [self.chartView aa_drawChartWithChartModel:aaChartModel];
    self.chartView.chartSeriesHidden = YES;
}
- (IBAction)segButtonClick:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0)
    {
        [self.aaChartModel setChartType:AAChartTypeLine];
    }
    else
    {
        [self.aaChartModel setChartType:AAChartTypeColumn];
    }
    
    [self.chartView aa_refreshChartWithChartModel:self.aaChartModel];
}
- (IBAction)backBtnClick:(UIButton *)sender {
    [self backButtonClick];
}

- (AAChartView *)chartView
{
    if (!_chartView) {
        _chartView = [[AAChartView alloc] init];
    }
    return _chartView;
}
@end
