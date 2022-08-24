//
//  StatsViewController.m
//  xjhOCD
//
//  Created by xjhuang on 30/06/2022.
//

#import "StatsViewController.h"
#import "FSCalendar/FSCalendar.h"
#import "DailyReportViewController.h"
@interface StatsViewController ()<FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (nonatomic, assign) NSInteger count;
@end

@implementation StatsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.calendar reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Stats"];
    
    [self setupUI];
}
- (void)setupUI
{
    self.calendar.appearance.borderRadius = 0.5;
    self.calendar.appearance.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.calendar.appearance.subtitleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    self.calendar.weekdayHeight = 48;
    self.calendar.appearance.weekdayFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.calendar.appearance.weekdayTextColor = HexColor(@"#333333");
    
    self.calendar.appearance.headerTitleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
}
// FSCalendarDataSource
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    NSDate *today = [NSDate date];
    if ([date compare:today] == NSOrderedDescending)
    {
        return @"";
    }
    else
    {
        RLMResults *oldArray = [ChallengeModel objectsWhere:@"date = %@",[DateUtil getStringFromDate:date format:@"yyyy-MM-dd"]];
        return [NSString stringWithFormat:@"%ld/4", oldArray.count];
    }
}
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    // Do other updates here
    [self.view layoutIfNeeded];
}

#pragma mark - Actions
- (IBAction)previousButtonClick:(UIButton *)sender {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    NSDate *today = self.calendar.currentPage;
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *pre = [calendar dateByAddingComponents:components toDate:today options:NSCalendarMatchPreviousTimePreservingSmallerUnits];
    [self.calendar setCurrentPage:pre];
}
- (IBAction)nextButtonClick:(UIButton *)sender {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    NSDate *today = self.calendar.currentPage;
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *next = [calendar dateByAddingComponents:components toDate:today options:NSCalendarMatchNextTimePreservingSmallerUnits];
    [self.calendar setCurrentPage:next];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSDate *today = [NSDate date];
    if ([date compare:today] == NSOrderedDescending)
    {
        [self.calendar deselectDate:date];
    }
    else
    {
        DailyReportViewController *vc = kHomeStoryboardWithID(@"DailyReportViewController");
        vc.hidesBottomBarWhenPushed = YES;
        vc.date = date;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (IBAction)invisibleButtonClick:(UIButton *)sender {
    _count ++;
    
    if (_count == 10)
    {
        [kDataManager createFakeData];
    }
}
- (IBAction)exportButtonClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"By clicking this button, all the data would be written into an 'excel', which can be found in this iPhone's 'file'." message:@"Do you want to?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [kDataManager saveExcelToDevice];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)deleteButtonClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You will lost all the data of your former challenges!" message:@"Do you realy want to?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [realm commitWriteTransaction];
        [self.calendar reloadData];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
