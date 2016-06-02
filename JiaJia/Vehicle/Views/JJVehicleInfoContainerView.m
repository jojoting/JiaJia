//
//  JJVehicleInfoContainerView.m
//  JiaJia
//
//  Created by jojoting on 16/5/10.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleInfoContainerView.h"
#import "JJVehicleInfoView.h"
#import "JJVehicleViewModel.h"

@interface JJVehicleInfoContainerView ()

@property (nonatomic, strong) JJVehicleInfoView     *timeView;
@property (nonatomic, strong) JJVehicleInfoView     *distanceView;
@property (nonatomic, strong) JJVehicleInfoView     *batteryView;
@property (nonatomic, strong) JJVehicleInfoView     *remainTimeView;

@end
@implementation JJVehicleInfoContainerView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.timeView];
        [self addSubview:self.distanceView];
        [self addSubview:self.batteryView];
        [self addSubview:self.remainTimeView];
    }
    return self;
}

#pragma mark - private

- (void)layoutSubviews{
    self.timeView.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height / 2);
    self.distanceView.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height / 2);
    self.batteryView.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width / 2, self.frame.size.height / 2);
    self.remainTimeView.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2, self.frame.size.width / 2, self.frame.size.height / 2);
}
- (JJVehicleInfoView *)infoViewWithImageName:(NSString *)imageName{
    JJVehicleInfoView *infoView = [[JJVehicleInfoView alloc] initWithFrame:CGRectZero];
    infoView.image = [UIImage imageNamed:imageName];
    return infoView;
}

#pragma mark - getter
- (JJVehicleInfoView *)timeView{
    if (!_timeView) {
        _timeView = [self infoViewWithImageName:@"vehicle_time"];
    }
    return _timeView;
}

- (JJVehicleInfoView *)batteryView{
    if (!_batteryView) {
        _batteryView = [self infoViewWithImageName:@"vehicle_battery"];
    }
    return _batteryView;
}
- (JJVehicleInfoView *)distanceView{
    if (!_distanceView) {
        _distanceView = [self infoViewWithImageName:@"vehicle_distance"];
    }
    return _distanceView;
}
- (JJVehicleInfoView *)remainTimeView{
    if (!_remainTimeView) {
        _remainTimeView = [self infoViewWithImageName:@"vehicle_left_battery"];
    }
    return _remainTimeView;
}

#pragma mark - setter
- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    self.timeView.text = timeString;
}

- (void)setBatteryString:(NSString *)batteryString{
    _batteryString = batteryString;
    self.batteryView.text = batteryString;
}

- (void)setDistanceString:(NSString *)distanceString{
    _distanceString = distanceString;
    self.distanceView.text = distanceString;
}

- (void)setRemainTimeString:(NSString *)remainTimeString{
    _remainTimeString = remainTimeString;
    self.remainTimeView.text = remainTimeString;
}
@end
