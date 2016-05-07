//
//  JJAddAddressCollectionViewCell.m
//  JiaJia
//
//  Created by jojoting on 16/5/4.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJAddAddressCollectionViewCell.h"

@interface JJAddAddressCollectionViewCell ()

@property (nonatomic, strong) UIView    *container;
@property (nonatomic, strong) UILabel   *textLabel;

@end
@implementation JJAddAddressCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.container];
        [self.container addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews{
    self.container.frame = CGRectMake(10, 5, self.frame.size.width - 20, self.frame.size.width - 20);
    self.container.layer.masksToBounds = YES;
    self.container.layer.cornerRadius = self.container.frame.size.width / 2;
    
    self.textLabel.frame = CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height);
}
#pragma mark - getter
- (UIView *)container{
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
        _container.layer.borderWidth = 1.f;
    }
    return _container;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _textLabel;
}
#pragma mark - setter
- (void)setText:(NSString *)text{
    _text = text;
    _textLabel.text = text;
}

@end
