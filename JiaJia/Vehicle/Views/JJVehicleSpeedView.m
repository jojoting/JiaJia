
//
//  JJVehicleSpeedView.m
//  JiaJia
//
//  Created by jojoting on 16/5/10.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleSpeedView.h"
#import "JJGlobal.h"

#define labelGap 100
#define shapeLayeRadius  self.frame.size.height / 2 - 30
@interface JJVehicleSpeedView ()

@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UILabel       *speedLabel;
@property (nonatomic, strong) UILabel       *unitLabel;
@end

@implementation JJVehicleSpeedView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.speedLabel];
        [self addSubview:self.unitLabel];
        [self bringSubviewToFront:self.unitLabel];
    }
    return self;
}

- (void)layoutSubviews{
    self.bgImageView.frame = CGRectMake(63, 48, self.frame.size.width - 126,  self.frame.size.height - 48 - 30);
    self.speedLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.unitLabel.frame = CGRectMake(0, labelGap, self.frame.size.width, self.frame.size.height - labelGap);
}

#pragma mark - getter
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vehicle_speed"]];
        _bgImageView.contentMode = UIViewContentModeCenter;
    }
    return _bgImageView;
}
- (UILabel *)speedLabel{
    if (!_speedLabel) {
        _speedLabel = [[UILabel alloc] init];
        _speedLabel.font = [UIFont systemFontOfSize:70.f];
        _speedLabel.textColor = COLOR_HEX(0x58595B, 1.0);
        _speedLabel.text = @"0.00";
        _speedLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _speedLabel;
}

- (UILabel *)unitLabel{
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont systemFontOfSize:20.f];
        _unitLabel.textColor = COLOR_HEX(0x58595B, 1.0);
        _unitLabel.text = @"km/h";
        _unitLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unitLabel;
}

#pragma mark - setter
- (void)setSpeedText:(NSString *)speedText{
    _speedText = speedText;
    self.speedLabel.text = _speedText;
}
@end
