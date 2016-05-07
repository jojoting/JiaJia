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
+ (instancetype)cellWithTittle:(NSString *)title placeholder:(NSString *)placeholder;

@end
