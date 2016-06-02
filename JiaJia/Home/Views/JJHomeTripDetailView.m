//
//  JJHomeTripDetailView.m
//  JiaJia
//
//  Created by jojoting on 16/6/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJHomeTripDetailView.h"
#import "JJGlobal.h"

@interface JJHomeTripDetailView ()

@property (nonatomic, strong) UIImageView   *iconImageView;
@property (nonatomic, strong) UILabel       *detailTitleLabel;
@property (nonatomic, strong) UILabel       *detailInfoLabel;
@property (nonatomic, strong) UIButton      *naviButton;

@end
@implementation JJHomeTripDetailView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 3.0;
        [self addSubview:self.iconImageView];
        [self addSubview:self.detailInfoLabel];
        [self addSubview:self.detailTitleLabel];
        [self addSubview:self.naviButton];
    }
    return self;
}

- (void)layoutSubviews{
    self.iconImageView.frame = CGRectMake(24, 25.5, 13, 13);
    self.detailTitleLabel.frame = CGRectMake(24 + self.iconImageView.frame.size.width, 21.5, 200, 25);
    self.detailInfoLabel.frame = CGRectMake(24, self.frame.size.height - 16 - 20, 250, 20);
    CGFloat naviButtonHeight = self.frame.size.height - 32;
    self.naviButton.frame = CGRectMake(self.frame.size.width - 23 - naviButtonHeight, 16, naviButtonHeight, naviButtonHeight);
}
#pragma mark - private
- (void)naviButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tripDetailView:didClickedButton:)]) {
        [self.delegate tripDetailView:self didClickedButton:button];
    }
}
#pragma mark - getter
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trip_detail_icon"]];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

- (UILabel *)detailInfoLabel{
    if (!_detailInfoLabel) {
        _detailInfoLabel = [[UILabel alloc] init];
        _detailInfoLabel.textAlignment = NSTextAlignmentLeft;
        _detailInfoLabel.font = [UIFont systemFontOfSize:12.f];
        _detailInfoLabel.textColor = COLOR_HEX(0x58595B, 1.0);
    }
    return _detailInfoLabel;
}
- (UILabel *)detailTitleLabel{
    if (!_detailTitleLabel) {
        _detailTitleLabel = [[UILabel alloc] init];
        _detailTitleLabel.textAlignment = NSTextAlignmentLeft;
        _detailTitleLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _detailTitleLabel.textColor = COLOR_HEX(0x58595B, 1.0);
    }
    return _detailTitleLabel;
}


- (UIButton *)naviButton{
    if (!_naviButton) {
        _naviButton = [[UIButton alloc] init];
        [_naviButton setBackgroundImage:[UIImage imageNamed:@"trip_detail_button"] forState:UIControlStateNormal];
        [_naviButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_naviButton setTitle:@"导航" forState:UIControlStateNormal];
        _naviButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_naviButton addTarget:self action:@selector(naviButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviButton;
}

#pragma mark - setter
- (void)setDetailInfo:(NSString *)detailInfo{
    _detailInfo = detailInfo;
    self.detailInfoLabel.text = detailInfo;
}

- (void)setDetailTitle:(NSString *)detailTitle{
    _detailTitle = detailTitle;
    self.detailTitleLabel.text = detailTitle;
}
@end
