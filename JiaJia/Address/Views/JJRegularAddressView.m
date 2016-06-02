//
//  JJRegularAddressView.m
//  JiaJia
//
//  Created by jojoting on 16/5/26.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJRegularAddressView.h"
#import "JJGlobal.h"

#define leftIconWidth 25
#define editIconWidth 25

@interface JJRegularAddressView ()

@property (nonatomic, strong) UIImageView   *leftIconImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIImageView   *editImageView;
@end

@implementation JJRegularAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = COLOR_HEX(0xE6E7E8, 1.0).CGColor;
    }
    return self;
}

- (void)setUpSubViews{
    [self addSubview:self.leftIconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.editImageView];
}

- (void)layoutSubviews{
    self.leftIconImageView.frame = CGRectMake(35, 0, leftIconWidth, self.frame.size.height);
    self.nameLabel.frame = CGRectMake(35 + leftIconWidth , 0, self.frame.size.width - 35 - leftIconWidth - 5 - 20 - 4 - editIconWidth, self.frame.size.height);
    self.editImageView.frame = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 4, 0, editIconWidth, self.frame.size.height);
}


#pragma mark - getter
- (UIImageView *)leftIconImageView{
    if (!_leftIconImageView) {
        _leftIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"regular_address_left_icon"]];
        _leftIconImageView.contentMode = UIViewContentModeCenter;
    }
    return _leftIconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:12.5];
        _nameLabel.textColor = COLOR_HEX(0xBBBDBF, 1.0);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView *)editImageView{
    if (!_editImageView) {
        _editImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"regular_address_edit"]];
        _editImageView.contentMode = UIViewContentModeCenter;
    }
    return _editImageView;
}

#pragma mark - setter
- (void)setAddressName:(NSString *)addressName{
    _addressName = addressName;
    self.nameLabel.text = addressName;
}
@end
