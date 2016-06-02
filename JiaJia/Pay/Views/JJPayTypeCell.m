//
//  JJPayTypeCell.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJPayTypeCell.h"
#import "JJGlobal.h"

@interface JJPayTypeCell ()

@property (nonatomic, strong) UIImageView   *iconView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIImageView   *selectImageView;

@end

@implementation JJPayTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.selectImageView];
        self.selectImageView.image = [UIImage imageNamed:@"pay_select"];
    }
    return self;
}
- (void)setImage:(UIImage *)image title:(NSString *)title{
    self.iconView.image = image;
    self.titleLabel.text = title;
}

- (void)layoutSubviews{
    self.iconView.frame = CGRectMake(30, 0, 13, self.frame.size.height);
    self.titleLabel.frame = CGRectMake(30 + self.iconView.frame.size.width + 8.5, 0, 200, self.frame.size.height);
    self.selectImageView.frame = CGRectMake(self.titleLabel.frame.origin.x + 200, 0, self.frame.size.width - 30 - 200 - 13 - 32, self.frame.size.height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectImageView.image = [UIImage imageNamed:@"pay_selected"];
    }else{
        self.selectImageView.image = [UIImage imageNamed:@"pay_select"];
    }
    // Configure the view for the selected state
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeCenter;
    }
    return _iconView;
}

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.contentMode = UIViewContentModeRight;
    }
    return _selectImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COLOR_HEX(0x58595B, 0.7);
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

@end
