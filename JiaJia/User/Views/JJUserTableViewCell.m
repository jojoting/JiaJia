//
//  JJUserTableViewCell.m
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserTableViewCell.h"

@interface JJUserTableViewCell ()

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *placeholder;
@end
@implementation JJUserTableViewCell

+ (instancetype)cellWithTittle:(NSString *)title placeholder:(NSString *)placeholder{
    return [[self alloc] initWithTittle:title placeholder:placeholder];
}

- (instancetype)initWithTittle:(NSString *)title placeholder:(NSString *)placeholder{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        self.placeholder = placeholder;
        self.title = title;
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

- (void)layoutSubviews{
    self.titleLabel.frame = CGRectMake(10, 0, self.frame.size.width / 6, self.frame.size.height);
    self.textField.frame = CGRectMake(10 + self.frame.size.width / 6, 0, self.frame.size.width * 5/6, self.frame.size.height);
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentLeft;
    }
    return _textField;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder ;
    self.textField.placeholder = placeholder;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
@end
