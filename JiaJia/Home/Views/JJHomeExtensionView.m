//
//  JJHomeExtensionView.m
//  JiaJia
//
//  Created by jojoting on 16/4/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJHomeExtensionView.h"
#import "JJLocationView.h"
#import "JJGlobal.h"

#define AddEndLocationButtonHeight 45

@interface JJHomeExtensionView ()

@property (nonatomic, strong) JJLocationView *startLocationView;
@property (nonatomic, strong) NSMutableArray *endLocationViews;
@property (nonatomic, strong) UIView         *containerView;
@property (nonatomic, strong) UILabel        *tripInfoLabel;
@property (nonatomic, strong) UIButton       *addEndLocationButton;

@property (nonatomic, copy, readwrite) NSString *tripInfo;

@end

@implementation JJHomeExtensionView

#pragma mark - init
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithLocationViewHeight:frame.size.height / 2 tripInfoLabelHeight:frame.size.height / 3 frame:frame];
}

- (instancetype)initWithLocationViewHeight:(CGFloat)locationViewHeight tripInfoLabelHeight:(CGFloat )tripInfoLabelHeight{
    return [self initWithLocationViewHeight:locationViewHeight tripInfoLabelHeight:tripInfoLabelHeight frame:CGRectMake(5, 6.5, [UIScreen mainScreen].bounds.size.width - 10, locationViewHeight * 2)];
}

- (instancetype)initWithLocationViewHeight:(CGFloat)locationViewHeight tripInfoLabelHeight:(CGFloat )tripInfoLabelHeight frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.locationViewHeight = locationViewHeight;
        self.tripInfoLabelHeight = tripInfoLabelHeight;
        self.isTrpiInfoLabelShow = NO;

        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.startLocationView];
    [self addEndLocationView];
    [self.containerView addSubview:self.tripInfoLabel];
//    [self addSubview:self.addEndLocationButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.startLocationView.frame = CGRectMake(0, 0, self.frame.size.width, self.locationViewHeight);
    [self layoutLocationViews];
    JJLocationView *lastLocationView =(JJLocationView *)[self.endLocationViews lastObject];
    self.tripInfoLabel.frame = CGRectMake(0, lastLocationView.frame.origin.y + self.locationViewHeight, self.frame.size.width, self.tripInfoLabelHeight);
    if (self.isTrpiInfoLabelShow) {
        self.addEndLocationButton.frame = CGRectMake(0, self.tripInfoLabel.frame.origin.y + self.tripInfoLabel.frame.size.height + 10, self.frame.size.width, AddEndLocationButtonHeight);
    }
    
    self.frame = CGRectMake(5, 74, [UIScreen mainScreen].bounds.size.width - 10, self.locationViewHeight * (self.endLocationViews.count + 1) + self.tripInfoLabelHeight*_isTrpiInfoLabelShow);
    self.containerView.frame = self.bounds;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 3.0;
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = NO;
}

- (void)layoutLocationViews{
    for (int i = 0; i < self.endLocationViews.count; i ++) {
        JJLocationView *locationView = self.endLocationViews[i];
        CGFloat positionY = self.locationViewHeight * (i + 1);
        locationView.frame = CGRectMake(0, positionY, self.frame.size.width, self.locationViewHeight);
    }
}
#pragma mark - public
- (void)addEndLocationView{
    if (!self.endLocationViews) {
        self.endLocationViews = [NSMutableArray array];
    }
    
    if (self.endLocationViews.count == 4) {
        return;
    }
    JJLocationView *endLocationView = [[JJLocationView alloc] init];
    endLocationView.tag = self.endLocationViews.count;
    endLocationView.backgroundColor = [UIColor whiteColor];
    endLocationView.location = [NSString stringWithFormat:@"目的地"];
    [endLocationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEndLocationView:)]];
    endLocationView.image = [UIImage imageNamed:@"home_end_location"];
    endLocationView.isBorderShow = NO;
    
    [self.endLocationViews addObject:endLocationView];
    [self.containerView addSubview:endLocationView];
    [self layoutIfNeeded];
    
    if ([self.delegate respondsToSelector:@selector(extensionView:didAddEndLocationView:atIndex:)]) {
        [self.delegate extensionView:self didAddEndLocationView:endLocationView atIndex:self.endLocationViews.count - 1];
    }
    
}

- (void)setLocationTitle:(NSString *)title atIndex:(NSInteger )index{
    if (index < 0 || index > self.endLocationViews.count - 1) {
        return;
    }
    
    ((JJLocationView *)self.endLocationViews[index]).location = title;
}

- (void)setTripDistance:(CGFloat )distance time:(CGFloat )time{
    
    NSString *timeString = @"";
    if (time < 60) {
        timeString = [NSString stringWithFormat:@"%.f秒",time];
    }
    if (time > 60 && time < 3600) {
        timeString = [NSString stringWithFormat:@"%.f分钟",time/60];
    }
    if (time > 3600) {
        timeString = [NSString stringWithFormat:@"%.f小时%d分钟",time/3600,(int)time % 3600];
    }
    
    CGFloat amount = ((distance/1000)>1?(distance/1000):1) * 2;
    self.tripInfo = [NSString stringWithFormat:@"全程%.f米，约%@，共约%.2f元",distance,timeString,amount];
    self.tripInfoLabel.text = self.tripInfo;
}
#pragma mark - private

- (void)tapStartLocationView:(UITapGestureRecognizer *)tap{
    JJLocationView *locationView = (JJLocationView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(extensionView:didSelectStartLocationView:)]) {
        [self.delegate extensionView:self didSelectStartLocationView:locationView];
    }
}

- (void)tapEndLocationView:(UITapGestureRecognizer *)tap{
    JJLocationView *locationView = (JJLocationView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(extensionView:didSelectEndLocationView:index:)]) {
        [self.delegate extensionView:self didSelectEndLocationView:locationView index:locationView.tag];
    }
}

- (void)addEndLocationButtonClicked:(UIButton *)sender{
    [self addEndLocationView];
}


#pragma mark - getter

- (JJLocationView *)startLocationView{
    if (!_startLocationView) {
        _startLocationView = [[JJLocationView alloc] init];
        _startLocationView.location = @"出发地";
        _startLocationView.image = [UIImage imageNamed:@"home_start_location"];
        _startLocationView.isBorderShow = YES;
        _startLocationView.backgroundColor = [UIColor whiteColor];
        [_startLocationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStartLocationView:)]];

    }
    return _startLocationView;
}

- (UILabel *)tripInfoLabel{
    if (!_tripInfoLabel) {
        _tripInfoLabel = [[UILabel alloc] init];
        _tripInfoLabel.backgroundColor = MAIN_COLOR;
        _tripInfoLabel.text = @"全程xx米，约xx分钟，共约xx元";
        _tripInfoLabel.textAlignment = NSTextAlignmentCenter;
        _tripInfoLabel.textColor = [UIColor whiteColor];
        _tripInfoLabel.font = [UIFont systemFontOfSize:12.5];
        _tripInfoLabel.hidden = YES;
    }
    return _tripInfoLabel;
}

- (UIButton *)addEndLocationButton{
    if (!_addEndLocationButton) {
        _addEndLocationButton = [[UIButton alloc] init];
        _addEndLocationButton.backgroundColor = [UIColor whiteColor];
        [_addEndLocationButton setTitle:@"添加多个目的地" forState:UIControlStateNormal];
        [_addEndLocationButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _addEndLocationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _addEndLocationButton.layer.borderWidth = 0.7f;
        [_addEndLocationButton addTarget:self action:@selector(addEndLocationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addEndLocationButton;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 5.f;
    }
    return _containerView;
}

#pragma mark - setter
- (void)setStartLocationTitle:(NSString *)startLocationTitle{
    startLocationTitle = startLocationTitle;
    _startLocationView.location = startLocationTitle;
}

- (void)setIsTrpiInfoLabelShow:(BOOL)isTrpiInfoLabelShow{
    _isTrpiInfoLabelShow = isTrpiInfoLabelShow;
    self.tripInfoLabel.hidden = !isTrpiInfoLabelShow;
    [self layoutSubviews];
}
@end
