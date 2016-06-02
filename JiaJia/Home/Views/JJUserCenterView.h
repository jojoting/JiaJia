//
//  JJUserCenterView.h
//  JiaJia
//
//  Created by jojoting on 16/4/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJSlideView.h"

@class JJUserCenterView;
@protocol JJUserCenterDelegate <NSObject>

@required
//选择用户个人信息
- (void)didSelectUserInfoWithUserCenterView:(JJUserCenterView *)userCenterView;
/**
 *  点击各个item
 *
 *  @param userCenterView
 *  @param index          item的索引
 */
- (void)userCenterView:(JJUserCenterView *)userCenterView buttonClickedAtIndex:(NSInteger )index;

@end

@interface JJUserCenterView : JJSlideView

@property (nonatomic, copy) NSString    *username;
@property (nonatomic, copy) NSString    *userAvatarUrl;
@property (nonatomic, assign) id<JJUserCenterDelegate> delegate;
@end
