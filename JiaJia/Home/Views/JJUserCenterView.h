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
- (void)didSelectUserInfoWithUserCenterView:(JJUserCenterView *)userCenterView;
- (void)userCenterView:(JJUserCenterView *)userCenterView buttonClickedAtIndex:(NSInteger )index;

@end

@interface JJUserCenterView : JJSlideView

@property (nonatomic, assign) id<JJUserCenterDelegate> delegate;
@end
