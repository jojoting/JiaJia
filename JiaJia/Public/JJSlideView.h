//
//  JJSlideView.h
//  JiaJia
//
//  Created by jojoting on 16/4/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JJSlideViewState) {
    JJSlideViewStateSlideOut = 0,
    JJSlideViewStateSlideIn
};

@class JJSlideView;
@protocol JJSlideViewDelegate <NSObject>

@optional
- (void)slideView:(JJSlideView *)slideView didSlideWithState:(JJSlideViewState)slideViewState;

@end
@interface JJSlideView : UIView

@property (nonatomic, assign) JJSlideViewState slideViewState;
@property (nonatomic, assign) id<JJSlideViewDelegate> delegate;

- (void)slideOut:(BOOL)animation;
- (void)slideIn:(BOOL)animation;

@end
