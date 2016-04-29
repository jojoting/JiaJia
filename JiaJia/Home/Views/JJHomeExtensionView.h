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
- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectStartLocationView:(JJLocationView *)locationView;
- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectEndLocationView:(JJLocationView *)locationView index:(NSInteger )index;


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
 *  使用输入地址栏的高度初始化
 *
 *  @param locationViewHeigt 输入地址栏的高度
 *
 *  @return
 */
- (instancetype) initWithLocationViewHeight:(CGFloat )locationViewHeight tripInfoLabelHeight:(CGFloat )tripInfoLabelHeight;

/**
 *  添加一个目的地
 */
- (JJLocationView *)addEndLocationView;
@end
