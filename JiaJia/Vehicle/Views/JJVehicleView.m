//
//  JJVehicleView.m
//  JiaJia
//
//  Created by jojoting on 16/5/10.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleView.h"
#import "JJVehicleViewModel.h"
#import "JJVehicleSpeedView.h"
#import "JJVehicleInfoContainerView.h"
#import "JJGlobal.h"

#define speedViewHeight self.frame.size.height * 4/7

@interface JJVehicleView ()

@property (nonatomic, strong) JJVehicleSpeedView            *speedView;
@property (nonatomic, strong) JJVehicleInfoContainerView    *infoContainerView;

@end

@implementation JJVehicleView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.speedView];
        [self addSubview:self.infoContainerView];
        [self updateData];
    }
    return self;
}

- (void)layoutSubviews{
    self.speedView.frame = CGRectMake(0, 0, self.frame.size.width, speedViewHeight);
    self.infoContainerView.frame = CGRectMake(0, speedViewHeight, self.frame.size.width, self.frame.size.height - speedViewHeight);
}
#pragma mark - public
- (void)updateData{
    self.speedView.speedText = [JJVehicleViewModel sharedViewModel].speedString;
    self.infoContainerView.timeString = [JJVehicleViewModel sharedViewModel].timeString;
    self.infoContainerView.distanceString = [JJVehicleViewModel sharedViewModel].distanceString;
    self.infoContainerView.remainTimeString = [JJVehicleViewModel sharedViewModel].leftTimeString;
    self.infoContainerView.batteryString = [JJVehicleViewModel sharedViewModel].batteryString;
}
#pragma mark - getter
- (JJVehicleSpeedView *)speedView{
    if (!_speedView) {
        _speedView = [[JJVehicleSpeedView alloc] initWithFrame:CGRectZero];
    }
    return _speedView;
}

- (JJVehicleInfoContainerView *)infoContainerView{
    if (!_infoContainerView) {
        _infoContainerView = [[JJVehicleInfoContainerView alloc] initWithFrame:CGRectZero];
    }
    return _infoContainerView;
}

@end
