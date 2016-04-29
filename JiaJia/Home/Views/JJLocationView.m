//
//  JJLocationView.m
//  JiaJia
//
//  Created by jojoting on 16/4/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJLocationView.h"

#define locationViewIconHeight 20

@interface JJLocationView ()

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIImageView *imageView;

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
        self.layer.borderWidth = 0.7f;
    }
    return self;
}

- (void)initSubViews{
    [self addSubview:self.imageView];
    [self addSubview:self.locationLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, locationViewIconHeight, locationViewIconHeight);
    self.locationLabel.frame = CGRectMake(self.frame.origin.x + locationViewIconHeight , self.frame.origin.x, self.frame.size.width - locationViewIconHeight, self.frame.size.height);
}

#pragma mark - getter
- (UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.text = _location;
    }
    return _locationLabel;
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
#pragma mark - setter 
- (void)setLocation:(NSString *)location{
    _location = location;
    if (_locationLabel) {
        _locationLabel.text = location;
    }
}

@end
