//
//  JJPaySuccessView.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJPaySuccessView.h"
#import "JJGlobal.h"

#define successLabelHeight 65
#define QRCodeImageViewWidth 245

@interface JJPaySuccessView ()

@property (nonatomic, strong) UIImageView       *successImageView;
@property (nonatomic, strong) UILabel           *successLabel;
@property (nonatomic, strong) UIImageView       *QRCodeImageView;
@property (nonatomic, strong) UILabel           *QRCodeLabel;

@end
@implementation JJPaySuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{

    [self addSubview:self.successImageView];
    [self addSubview:self.successLabel];
    [self addSubview:self.QRCodeLabel];
    [self addSubview:self.QRCodeImageView];
}
- (void)layoutSubviews{
    self.successImageView.frame = CGRectMake(167, 55, self.frame.size.width - 334, self.frame.size.width - 334);
    self.successLabel.frame = CGRectMake(0, self.successImageView.frame.origin.y + self.successImageView.frame.size.height + 14, self.frame.size.width, successLabelHeight);
    self.QRCodeImageView.frame = CGRectMake((self.frame.size.width - QRCodeImageViewWidth) / 2, self.frame.size.height - QRCodeImageViewWidth - 153, QRCodeImageViewWidth, QRCodeImageViewWidth);
    self.QRCodeLabel.frame = CGRectMake(0, self.QRCodeImageView.frame.origin.y + QRCodeImageViewWidth + 18, self.frame.size.width, 45);
}

#pragma mark - getter

- (UIImageView *)successImageView{
    if (!_successImageView) {
        _successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pay_success_image"]];
        _successImageView.contentMode = UIViewContentModeCenter;
    }
    return _successImageView;
}

- (UIImageView *)QRCodeImageView{
    if (!_QRCodeImageView) {
        _QRCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pay_success_QRCode"]];
        _QRCodeImageView.contentMode = UIViewContentModeCenter;
    }
    return _QRCodeImageView;
}

- (UILabel *)successLabel{
    if (!_successLabel) {
        _successLabel = [[UILabel alloc] init];
        _successLabel.textAlignment = NSTextAlignmentCenter;
        _successLabel.textColor = COLOR_HEX(0x58595B, 1.0);
        _successLabel.text = @"付款成功";
        _successLabel.font = [UIFont systemFontOfSize:25.f];
    }
    return _successLabel;
}

- (UILabel *)QRCodeLabel{
    if (!_QRCodeLabel) {
        _QRCodeLabel = [[UILabel alloc] init];
        _QRCodeLabel.textAlignment = NSTextAlignmentCenter;
        _QRCodeLabel.textColor = COLOR_HEX(0xE98727, 0.7);
        _QRCodeLabel.text = @"将二维码放入站点感应器即可打开站门";
        _QRCodeLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _QRCodeLabel;
}
@end
