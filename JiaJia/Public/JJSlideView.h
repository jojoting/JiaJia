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

@interface JJSlideView : UIView

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *slideView;
@property (nonatomic, assign) JJSlideViewState slideViewState;

- (void)slideOut:(BOOL)animation;
- (void)slideIn:(BOOL)animation;

@end
