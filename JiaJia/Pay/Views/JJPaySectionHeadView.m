//
//  JJPaySectionHeadView.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJPaySectionHeadView.h"
#import "JJGlobal.h"

#define divisionViewWidth 158

@interface JJPaySectionHeadView ()

@property (nonatomic, strong) UIView    *divisionView1;
@property (nonatomic, strong) UIView    *divisionView2;
@property (nonatomic, strong) UILabel   *titleLabel;

@end

@implementation JJPaySectionHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    [self addSubview:self.divisionView1];
    [self addSubview:self.divisionView2];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews{
    self.divisionView1.frame = CGRectMake(0, self.frame.size.height /2 - 1, divisionViewWidth, 1);
    self.titleLabel.frame = CGRectMake(divisionViewWidth, 0, self.frame.size.width - 2*divisionViewWidth, self.frame.size.height);
    self.divisionView2.frame = CGRectMake(self.frame.size.width - divisionViewWidth, self.frame.size.height /2 - 1, divisionViewWidth, 1);
}
- (UIView *)divisionView{
    UIView *divisionView = [[UIView alloc] init];
    divisionView.backgroundColor = COLOR_HEX(0x58595B, 0.7);
    return divisionView;
}
#pragma mark - getter
- (UIView *)divisionView1{
    if (!_divisionView1) {
        _divisionView1 = [self divisionView];
    }
    return _divisionView1;
}
- (UIView *)divisionView2{
    if (!_divisionView2) {
        _divisionView2 = [self divisionView];
    }
    return _divisionView2;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COLOR_HEX(0x58595B, 0.7);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _titleLabel;
}

#pragma mark - setter
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}
@end
