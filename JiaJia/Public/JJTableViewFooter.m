//
//  JJTableViewFooter.m
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJTableViewFooter.h"
#import "JJGlobal.h"

#define footerContainerViewWidth 128

@interface JJTableViewFooter ()

@property (nonatomic, strong) UIView    *containerView;
@property (nonatomic, strong) UILabel   *label;

@end
@implementation JJTableViewFooter

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect )frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.label];
        self.label.text = title;
    }
    return self;

}

- (void)layoutSubviews{
    self.containerView.frame = CGRectMake((self.frame.size.width - footerContainerViewWidth) / 2, 13, footerContainerViewWidth, self.frame.size.height - 26);
    self.label.frame = CGRectMake(26, 0, footerContainerViewWidth - 52, self.containerView.frame.size.height);
}
#pragma mark - getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = COLOR_HEX(0xF8A258, 0.7);
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 3.f;
    }
    return _containerView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"无更多行程";
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:10.f];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
