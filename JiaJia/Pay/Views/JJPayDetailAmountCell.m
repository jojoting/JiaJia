//
//  JJPayDetailAmountCell.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJPayDetailAmountCell.h"
#import "JJGlobal.h"

@interface JJPayDetailAmountCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end
@implementation JJPayDetailAmountCell


- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setTitle:@"" detail:@""];
    }
    return self;
}

- (void)setTitle:(NSString *)title detail:(NSString *)detail{
    self.titleLabel.text = title;
    self.detailLabel.text = detail;
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
}

- (void)settitleColor:(UIColor *)titleColor detailColor:(UIColor *)detailColor{
    self.titleLabel.textColor = titleColor;
    self.detailLabel.textColor = detailColor;
}

- (void)layoutSubviews{
    self.titleLabel.frame = CGRectMake(30, 0, self.frame.size.width /2 -30, self.frame.size.height);;
    self.detailLabel.frame = CGRectMake(self.titleLabel.frame.size.width + 30, 0, self.frame.size.width - self.titleLabel.frame.size.width - 30 - 30, self.frame.size.height);
}
#pragma mark - getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COLOR_HEX(0x58595B, 0.7);
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = COLOR_HEX(0xE98727, 0.7);
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return _detailLabel;
}
#pragma mark life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
