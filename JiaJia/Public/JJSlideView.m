//
//  JJSlideView.m
//  JiaJia
//
//  Created by jojoting on 16/4/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJSlideView.h"

#define SlideAnimationDuration 0.7

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
    self = [super initWithFrame:frame];
    if (self) {
        [self slideIn:NO];
    }
    return self;
}

#pragma mark - private methods
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
    if (animation) {
        [UIView animateWithDuration:SlideAnimationDuration animations:^{
            self.frame = CGRectMake(-self.frame.size.width * slideViewState, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(slideView:didSlideWithState:)]) {
                [self.delegate slideView:self didSlideWithState:slideViewState];
            }
        }];
    }else {
        self.frame = CGRectMake(-self.frame.size.width * slideViewState, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        if ([self.delegate respondsToSelector:@selector(slideView:didSlideWithState:)]) {
            [self.delegate slideView:self didSlideWithState:slideViewState];
        }
    }

}
@end
