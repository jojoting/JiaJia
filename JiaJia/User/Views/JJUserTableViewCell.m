//
//  JJUserTableViewCell.m
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserTableViewCell.h"
#import "JJGlobal.h"
@interface JJUserTableViewCell () <UITextFieldDelegate>

@end
@implementation JJUserTableViewCell

+ (instancetype)cellWithIdentifier:(NSString *)identifier tittle:(NSString *)title placeholder:(NSString *)placeholder{
    return [[self alloc] initWithIdentifier:identifier tittle:title placeholder:placeholder];
}

- (instancetype)initWithIdentifier:(NSString *)identifier tittle:(NSString *)title placeholder:(NSString *)placeholder{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.validateButton];
        self.isValidateButtonHidden = YES;
        self.placeholder = placeholder;
        self.title = title;
        
    }
    return self;
}

- (void)layoutSubviews{
    self.titleLabel.frame = CGRectMake(12, 0, self.frame.size.width / 6, self.frame.size.height);
    self.textField.frame = CGRectMake(12 + (self.frame.size.width / 6 + 10) * !self.titleLabel.hidden , 0, self.frame.size.width * 5/6 - 34, self.frame.size.height);
    self.validateButton.frame = CGRectMake(self.frame.size.width * 3/4, 6, self.frame.size.width / 4 - 18, self.frame.size.height - 12);
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont systemFontOfSize:10.5f];
//        _textField.layer.borderWidth = 1.f;
        _textField.delegate = self;
    }
    return _textField;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = COLOR_HEX(0x58595B, 1.0);
    }
    return _titleLabel;
}

- (UIButton *)validateButton{
    if (!_validateButton) {
        _validateButton = [[UIButton alloc] init];
        _validateButton.backgroundColor = MAIN_COLOR;
        [_validateButton setTintColor:MAIN_COLOR];
        [_validateButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _validateButton.layer.masksToBounds = YES;
        _validateButton.layer.cornerRadius = 4.f;
        [_validateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _validateButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _validateButton;
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder ;
    self.textField.placeholder = placeholder;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    self.titleLabel.hidden = ![title length];
}

- (void)setIsValidateButtonHidden:(BOOL)isValidateButtonHidden{
    _isValidateButtonHidden = isValidateButtonHidden;
    self.validateButton.hidden = isValidateButtonHidden;
}
#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField endEditing:YES];
    return YES;
}

@end
