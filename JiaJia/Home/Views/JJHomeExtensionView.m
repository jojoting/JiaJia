//
//  JJHomeExtensionView.m
//  JiaJia
//
//  Created by jojoting on 16/4/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJHomeExtensionView.h"
#import "JJLocationView.h"

#define AddEndLocationButtonHeight 45

@interface JJHomeExtensionView ()

@property (nonatomic, strong) JJLocationView *startLocationView;
@property (nonatomic, strong) NSMutableArray *endLocationViews;
@property (nonatomic, strong) UILabel        *tripInfoLabel;
@property (nonatomic, strong) UIButton       *addEndLocationButton;

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
    return [self initWithLocationViewHeight:locationViewHeight tripInfoLabelHeight:tripInfoLabelHeight frame:CGRectMake(5, 74, [UIScreen mainScreen].bounds.size.width - 10, locationViewHeight * 2)];
}

- (instancetype)initWithLocationViewHeight:(CGFloat)locationViewHeight tripInfoLabelHeight:(CGFloat )tripInfoLabelHeight frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.locationViewHeight = locationViewHeight;
        self.tripInfoLabelHeight = tripInfoLabelHeight;
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    [self addSubview:self.startLocationView];
    [self addEndLocationView];
    [self addSubview:self.tripInfoLabel];
    [self addSubview:self.addEndLocationButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.startLocationView.frame = CGRectMake(0, 0, self.frame.size.width, self.locationViewHeight);
    [self layoutLocationViews];
    JJLocationView *lastLocationView =(JJLocationView *)[self.endLocationViews lastObject];
    self.tripInfoLabel.frame = CGRectMake(0, lastLocationView.frame.origin.y + self.locationViewHeight, self.frame.size.width, self.tripInfoLabelHeight);
    self.addEndLocationButton.frame = CGRectMake(0, self.tripInfoLabel.frame.origin.y + self.tripInfoLabel.frame.size.height + 10, self.frame.size.width, AddEndLocationButtonHeight);
    
    self.frame = CGRectMake(5, 74, [UIScreen mainScreen].bounds.size.width - 10, self.locationViewHeight * (self.endLocationViews.count + 1) + self.tripInfoLabelHeight + 10 + AddEndLocationButtonHeight);
}

- (void)layoutLocationViews{
    for (int i = 0; i < self.endLocationViews.count; i ++) {
        JJLocationView *locationView = self.endLocationViews[i];
        CGFloat positionY = self.locationViewHeight * (i + 1);
        locationView.frame = CGRectMake(0, positionY, self.frame.size.width, self.locationViewHeight);
    }
}
#pragma mark - public
- (JJLocationView *)addEndLocationView{
    if (!self.endLocationViews) {
        self.endLocationViews = [NSMutableArray array];
    }
    
    JJLocationView *endLocationView = [[JJLocationView alloc] init];
    endLocationView.tag = self.endLocationViews.count;
    endLocationView.backgroundColor = [UIColor whiteColor];
    endLocationView.location = [NSString stringWithFormat:@"目的地%ld",(unsigned long)self.endLocationViews.count + 1];
    [endLocationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEndLocationView:)]];
    
    [self.endLocationViews addObject:endLocationView];
    [self addSubview:endLocationView];
    [self layoutIfNeeded];
    
    return endLocationView;
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
        _startLocationView.backgroundColor = [UIColor whiteColor];
        [_startLocationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStartLocationView:)]];
    }
    return _startLocationView;
}

- (UILabel *)tripInfoLabel{
    if (!_tripInfoLabel) {
        _tripInfoLabel = [[UILabel alloc] init];
        _tripInfoLabel.backgroundColor = [UIColor lightGrayColor];
        _tripInfoLabel.text = @"全程xx米，约xx分钟，共约xx元";
        _tripInfoLabel.textAlignment = NSTextAlignmentCenter;
        _tripInfoLabel.font = [UIFont systemFontOfSize:11.f];
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

@end
