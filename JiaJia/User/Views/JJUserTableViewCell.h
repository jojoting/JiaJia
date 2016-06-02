//
//  JJUserTableViewCell.h
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJUserTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField   *textField;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIButton      *validateButton;
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *placeholder;
@property (nonatomic, assign) BOOL      isValidateButtonHidden;
+ (instancetype)cellWithIdentifier:(NSString *)identifier tittle:(NSString *)title placeholder:(NSString *)placeholder;

@end
