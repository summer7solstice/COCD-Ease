//
//  MoodTrackerViewController.m
//  xjhOCD
//
//  Created by xjhuang on 15/06/2022.
//

#import "MoodTrackerViewController.h"
#import "CustomSlider.h"
@interface MoodTrackerViewController ()
@property (weak, nonatomic) IBOutlet UIView *sliderBgView;
@property (weak, nonatomic) IBOutlet UIImageView *smileImageView;
@property (nonatomic, strong) CustomSlider *moodSlider;
@end

@implementation MoodTrackerViewController

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
    NSString *imageStr = @"";
    NSString *smileImageStr = @"";
    if (slider.value <= 0.25)
    {
        value = 0.0;
        imageStr = @"icon_slider_00";
        smileImageStr = @"icon_mood_face_00";
    }
    else if (slider.value >= 0.75)
    {
        value = 1.0;
        imageStr = @"icon_slider_10";
        smileImageStr = @"icon_mood_face_10";
    }
    else
    {
        value = 0.5;
        imageStr = @"icon_slider_05";
        smileImageStr = @"icon_mood_face_05";
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [slider setValue:value animated:YES];
    } completion:^(BOOL finished) {
        [self.moodSlider setThumbImage:XJImageNamed(imageStr) forState:UIControlStateNormal];
    }];
    
    [UIView transitionWithView:self.smileImageView
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
    animations:^{
        [self.smileImageView setImage:XJImageNamed(smileImageStr)];
    } completion:NULL];
}
#pragma mark - Lazy
- (CustomSlider *)moodSlider
{
    if (!_moodSlider) {
        _moodSlider = [[CustomSlider alloc] init];
        [_moodSlider setMaximumTrackImage:XJImageNamed(@"icon_slider_bar") forState:normal];
        [_moodSlider setMinimumTrackImage:XJImageNamed(@"icon_slider_bar") forState:UIControlStateNormal];
        [_moodSlider setThumbImage:XJImageNamed(@"icon_slider_05") forState:UIControlStateNormal];
        _moodSlider.maximumValue = 1.0;
        _moodSlider.minimumValue = 0.0;
        _moodSlider.value = 0.5;
        _moodSlider.continuous = NO;
    }
    return _moodSlider;
}
@end
