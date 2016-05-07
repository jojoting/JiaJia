//
//  JJSlideView.m
//  JiaJia
//
//  Created by jojoting on 16/4/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJSlideView.h"

#define SlideAnimationDuration 0.5
#define BackgroundViewAlpha 0.6
@interface JJSlideView ()

@end

@implementation JJSlideView

#pragma mark - init
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initBackgroundView];
        [self initSlideViewWithFrame:frame];
        [self bindSwipeAction];
        self.hidden = YES;
    }
    return self;
}

- (void)initBackgroundView{
    self.backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0.f/255.f green:0.f/255.f blue:0.f/255.f alpha:BackgroundViewAlpha];
    self.backgroundView.alpha = 0;
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundView:)]];
    [self addSubview:self.backgroundView];
}

- (void)initSlideViewWithFrame:(CGRect )frame{
    self.slideView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:self.slideView];
    [self bringSubviewToFront:self.slideView];
    [self slideIn:NO];
}

- (void)bindSwipeAction{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.slideView addGestureRecognizer:swipe];
}
#pragma mark - private methods

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe{
    [self slideIn:YES];
}
- (void)slideOut:(BOOL)animation{
    [self slideWithSlideState:JJSlideViewStateSlideOut animation:animation];
}

- (void)slideIn:(BOOL)animation{
    [self slideWithSlideState:JJSlideViewStateSlideIn animation:animation];
}

- (void)slideWithSlideState:(JJSlideViewState )slideViewState animation:(BOOL)animation{
    self.slideViewState = slideViewState;
    [self setFrameWithSlideViewState:slideViewState animation:animation];
}

- (void)setFrameWithSlideViewState:(JJSlideViewState )slideViewState animation:(BOOL)animation{
    if (slideViewState == JJSlideViewStateSlideOut) {
        self.hidden = slideViewState;
    }
    
    if (animation) {
        [UIView animateWithDuration:SlideAnimationDuration animations:^{
            self.slideView.frame = CGRectMake(-self.slideView.frame.size.width * slideViewState, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
            self.backgroundView.alpha = (1-slideViewState)*BackgroundViewAlpha;
        } completion:^(BOOL finished) {
            if (slideViewState == JJSlideViewStateSlideIn) {
                self.hidden = slideViewState;
            }
        }];
    }else {
        self.slideView.frame = CGRectMake(-self.slideView.frame.size.width * slideViewState, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
        self.backgroundView.alpha = (1-slideViewState)*BackgroundViewAlpha;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    if (_slideView) {
        _slideView.backgroundColor = backgroundColor;
    }
}

- (void)tapBackgroundView:(UITapGestureRecognizer *)tap{
    [self slideIn:YES];
}
@end
