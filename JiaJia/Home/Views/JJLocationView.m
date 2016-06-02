//
//  JJLocationView.m
//  JiaJia
//
//  Created by jojoting on 16/4/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJLocationView.h"
#import "JJGlobal.h"

#define locationViewIconHeight 11

@interface JJLocationView ()

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView    *borderView;

@end
@implementation JJLocationView


#pragma mark - init
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.location = @"选择地点";
        [self initSubViews];
//        self.layer.borderWidth = 0.7f;
    }
    return self;
}

- (void)initSubViews{
    [self addSubview:self.imageView];
    [self addSubview:self.locationLabel];
    [self addSubview:self.borderView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(12, 0, locationViewIconHeight, self.frame.size.height);
    self.locationLabel.frame = CGRectMake(self.imageView.frame.origin.x + locationViewIconHeight +11, 0, self.frame.size.width - locationViewIconHeight, self.frame.size.height);
    self.borderView.frame = CGRectMake(0, self.frame.size.height - .7f, self.frame.size.width, .7f);
}

#pragma mark - getter
- (UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.text = _location;
        _locationLabel.font = [UIFont systemFontOfSize:15.f];
        _locationLabel.textColor = COLOR_HEX(0x58595B, 1.0);
    }
    return _locationLabel;
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UIView *)borderView{
    if (!_borderView) {
        _borderView = [[UIView alloc] init];
        _borderView.backgroundColor = [UIColor lightGrayColor];
    }
    return _borderView;
}
#pragma mark - setter 
- (void)setLocation:(NSString *)location{
    _location = location;
    if (_locationLabel) {
        _locationLabel.text = location;
    }
}

- (void)setImage:(UIImage *)image{
    _image = image;
    if (_image) {
        [_imageView setImage:image];
    }
}

- (void)setIsBorderShow:(BOOL)isBorderShow{
    _isBorderShow = isBorderShow;
    self.borderView.hidden = !isBorderShow;
}

@end
