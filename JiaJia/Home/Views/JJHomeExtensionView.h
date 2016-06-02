//
//  JJHomeExtensionView.h
//  JiaJia
//
//  Created by jojoting on 16/4/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJHomeExtensionView;
@class JJLocationView;
@protocol JJHomeExtensionViewDelegate <NSObject>

@optional
//选择出发地
- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectStartLocationView:(JJLocationView *)locationView;
//选择目的地
- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectEndLocationView:(JJLocationView *)locationView index:(NSInteger )index;
//成功添加目的地
- (void)extensionView:(JJHomeExtensionView *)extensionView didAddEndLocationView:(JJLocationView *)locationView atIndex:(NSInteger )index;


@end
@interface JJHomeExtensionView : UIView

@property (nonatomic, assign) id<JJHomeExtensionViewDelegate> delegate;

/**
 *  路程详细信息（距离、费用等）label高度
 */
@property (nonatomic, assign) CGFloat tripInfoLabelHeight;
/**
 *  输入地址view高度
 */
@property (nonatomic, assign) CGFloat locationViewHeight;

/**
 *  起始位置名字
 */
@property (nonatomic, copy) NSString    *startLocationTitle;

/**
 *  行程信息
 */
@property (nonatomic, copy, readonly) NSString    *tripInfo;

@property (nonatomic, assign) BOOL       isTrpiInfoLabelShow;
/**
 *  使用输入地址栏的高度初始化
 *
 *  @param locationViewHeigt 输入地址栏的高度
 *
 *  @return
 */
- (instancetype) initWithLocationViewHeight:(CGFloat )locationViewHeight tripInfoLabelHeight:(CGFloat )tripInfoLabelHeight;


/**
 *  设置某一目的地的名字
 *
 *  @param title 名字
 *  @param index 索引
 */
- (void)setLocationTitle:(NSString *)title atIndex:(NSInteger )index;


/**
 *  设置路程的距离与时间
 *
 *  @param distance 距离
 *  @param time     时间
 */
- (void)setTripDistance:(CGFloat )distance time:(CGFloat )time;
@end
