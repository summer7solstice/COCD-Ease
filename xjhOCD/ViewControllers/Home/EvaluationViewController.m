//
//  EvaluationViewController.m
//  xjhOCD
//
//  Created by xjhuang on 18/07/2022.
//

#import "EvaluationViewController.h"
#import "EvaluationPopViewController.h"
#import "CustomSlider.h"

@interface EvaluationViewController ()
@property (weak, nonatomic) IBOutlet UIView *sliderBgView;
@property (nonatomic, strong) CustomSlider *moodSlider;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (nonatomic, strong) NSArray *btnArray;
@property (nonatomic, strong) NSArray *moodArray;
@property (nonatomic, copy) NSString *mood;
@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI
{
    [self.sliderBgView addSubview:self.moodSlider];
    
    [self.moodSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.sliderBgView);
    }];
    
    [self.moodSlider addTarget:self action:@selector(sliderValurChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
}
- (void)sliderValurChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    UITouch*touchEvent = event.allTouches.allObjects[0];

    switch (touchEvent.phase) {
        case UITouchPhaseBegan:
            NSLog(@"start dragging");
            break;
        case UITouchPhaseMoved:
            NSLog(@"during dragging");
            break;
        case UITouchPhaseEnded:
            NSLog(@"end dragging");
            [self dragEnded:slider];
            break;
        default:
            break;
    }
}
- (void)dragEnded:(UISlider *)slider
{
    CGFloat value = 0;
    if (slider.value <= 0.5)
    {
        value = 0.0;
    }
    else if (slider.value > 0.5 && slider.value <= 1.5)
    {
        value = 1.0;
    }
    else if (slider.value > 1.5 && slider.value <= 2.5)
    {
        value = 2.0;
    }
    else if (slider.value > 2.5 && slider.value <= 3.5)
    {
        value = 3.0;
    }
    else
    {
        value = 4.0;
    }
    [slider setValue:value animated:YES];
}
#pragma mark - Actions
- (IBAction)btnClick:(UIButton *)sender {
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == sender)
        {
            [obj setBackgroundColor:kColor_Main];
            [obj setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        }
        else
        {
            [obj setBackgroundColor:UIColor.whiteColor];
            [obj setTitleColor:HexColor(@"#A4A9AD") forState:UIControlStateNormal];
        }
    }];
    self.mood = self.moodArray[sender.tag - 100];
}
- (IBAction)submitButtonClick:(UIButton *)sender {
    if (XJStringIsEmpty(self.mood))
    {
        [self showToastHUD:@"Please select your mood."];
        return;
    }
    
//    @{
//        @"date"             : [DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"],
//        @"time"             : [DateUtil getStringFromDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"],
//        @"challengeType"    : @(self.challengeType),
//        @"timeLength"       : @(self.seconds),
//    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.tempDict];
    [dict setValue:@(self.moodSlider.value).description forKey:@"moodScore"];
    [dict setValue:self.mood forKey:@"moodString"];
    [kDataManager saveChallenge:dict];
    
    @weakify(self);
    EvaluationPopViewController *vc = kHomeStoryboardWithID(@"EvaluationPopViewController");
    vc.block = ^(NSInteger flag) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.tabBarController presentViewController:vc animated:YES completion:NULL];
}
#pragma mark - Lazy
- (CustomSlider *)moodSlider
{
    if (!_moodSlider) {
        _moodSlider = [[CustomSlider alloc] init];
        [_moodSlider setMinimumTrackTintColor:HexColor(@"#1892FA")];
        [_moodSlider setMaximumTrackTintColor:HexColor(@"#F6FAFF")];
        [_moodSlider setThumbImage:XJImageNamed(@"img_progressbar") forState:UIControlStateNormal];
        _moodSlider.maximumValue = 4;
        _moodSlider.minimumValue = 0.0;
        _moodSlider.value = 2;
        _moodSlider.continuous = NO;
    }
    return _moodSlider;
}
- (NSArray *)btnArray
{
    return @[
        self.btn0,
        self.btn1,
        self.btn2,
        self.btn3,
        self.btn4,
        self.btn5,
        self.btn6,
        self.btn7,
        self.btn8
    ];
}
- (NSArray *)moodArray
{
    if (!_moodArray)
    {
        _moodArray = @[
            @"Happy",
            @"Nervous",
            @"Excited",
            @"Lonely",
            @"Relaxed",
            @"Stressed",
            @"Satisfied",
            @"Bored",
            @"Tired",
        ];
    }
    return _moodArray;
}
@end
