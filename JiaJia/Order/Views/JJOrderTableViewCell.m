//
//  JJOrderTableViewCell.m
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJOrderTableViewCell.h"
#import "JJOrderViewModel.h"
#import "JJGlobal.h"

@interface JJOrderTableViewCell ()

@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, strong) UIView        *containerView;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *infoLabel;
@property (nonatomic, strong) UILabel       *startLocationLabel;
@property (nonatomic, strong) UILabel       *endLocationLabel;

@end
@implementation JJOrderTableViewCell

- (instancetype)initWithViewModel:(JJOrderViewModel *)viewModel reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier viewModel:viewModel];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier viewModel:(JJOrderViewModel *)viewModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.viewModel = viewModel;
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    [self addSubview:self.bgView];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.timeLabel];
    [self.containerView addSubview:self.infoLabel];
    [self.containerView addSubview:self.startLocationLabel];
    [self.containerView addSubview:self.endLocationLabel];
}

- (void)layoutSubviews{
    self.bgView.frame = CGRectMake(9, 8, self.frame.size.width - 18, self.frame.size.height - 16);
    self.containerView.frame = CGRectMake(9, 8, self.frame.size.width - 18, self.frame.size.height - 16);
    self.timeLabel.frame = CGRectMake(10, 8, self.containerView.frame.size.width - 20, 20);
    self.infoLabel.frame = CGRectMake(10, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 6, self.containerView.frame.size.width - 20, 17);
    self.startLocationLabel.frame = CGRectMake(10, self.infoLabel.frame.origin.y + self.infoLabel.frame.size.height + 12, self.containerView.frame.size.width - 20, 17);
    self.endLocationLabel.frame = CGRectMake(10, self.startLocationLabel.frame.origin.y + self.startLocationLabel.frame.size.height, self.containerView.frame.size.width - 20, 17);


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getter
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(1, 1);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 3.0;
        _bgView.layer.cornerRadius = 3.0;
        _bgView.clipsToBounds = NO;
    }
    return _bgView;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 3.f;
    }
    return _containerView;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = COLOR_HEX(0xF8A258, 1.0);
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
        _timeLabel.text = self.viewModel.timeString;
    }
    return  _timeLabel;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.textColor = COLOR_HEX(0x231F20, 1.0);
        _infoLabel.font = [UIFont systemFontOfSize:10.f];
        _infoLabel.text = self.viewModel.infoString;
    }
    return  _infoLabel;
}

- (UILabel *)startLocationLabel{
    if (!_startLocationLabel) {
        _startLocationLabel = [[UILabel alloc] init];
        _startLocationLabel.attributedText = self.viewModel.startLocationString;
        _startLocationLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _startLocationLabel;
}

- (UILabel *)endLocationLabel{
    if (!_endLocationLabel) {
        _endLocationLabel = [[UILabel alloc] init];
        _endLocationLabel.attributedText = self.viewModel.endLocationString;
        _endLocationLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _endLocationLabel;
}

#pragma mark - setter
- (void)setViewModel:(JJOrderViewModel *)viewModel{
    _viewModel = viewModel;
    self.timeLabel.text = _viewModel.timeString;
    self.infoLabel.text = _viewModel.infoString;
    self.startLocationLabel.attributedText = _viewModel.startLocationString;
    self.endLocationLabel.attributedText = _viewModel.endLocationString;
}
@end
