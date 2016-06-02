//
//  JJHomeTripDetailView.h
//  JiaJia
//
//  Created by jojoting on 16/6/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJHomeTripDetailView;

@protocol JJTripDetailDelegate <NSObject>

- (void)tripDetailView:(JJHomeTripDetailView *)tripDetailView didClickedButton:(UIButton *)button;

@end

@interface JJHomeTripDetailView : UIView

@property (nonatomic, assign) id<JJTripDetailDelegate>  delegate;
@property (nonatomic, strong) NSString      *detailTitle;
@property (nonatomic, strong) NSString      *detailInfo;

@end
