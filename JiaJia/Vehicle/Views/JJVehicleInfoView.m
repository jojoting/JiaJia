//
//  JJVehicleInfoView.m
//  JiaJia
//
//  Created by jojoting on 16/5/10.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleInfoView.h"
#import "JJGlobal.h"

#define infoLabelHeight 45

@interface JJVehicleInfoView ()

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *infoLabel;

@end
@implementation JJVehicleInfoView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        [self addSubview:self.infoLabel];
    }
    return self;
}

- (void)layoutSubviews{
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - infoLabelHeight);
    self.infoLabel.frame = CGRectMake(0, self.imageView.frame.size.height, self.frame.size.width, infoLabelHeight);
}
#pragma mark - getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.text = @"行驶信息：000000";
        _infoLabel.font = [UIFont systemFontOfSize:14.f];
        _infoLabel.textColor = COLOR_HEX(0x929497, 1.0);
    }
    return _infoLabel;
}

#pragma mark - setter
- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.infoLabel.text = text;
}
@end
