//
//  JJOrderTableViewCell.h
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJOrderViewModel;

@interface JJOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) JJOrderViewModel  *viewModel;
- (instancetype)initWithViewModel:(JJOrderViewModel *)viewModel reuseIdentifier:(NSString *)reuseIdentifier;
@end
