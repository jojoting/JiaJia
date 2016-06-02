//
//  JJOrderViewModel.h
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface JJOrderViewModel : NSObject

@property (nonatomic, copy) NSString                    *timeString;
@property (nonatomic, copy) NSString                    *infoString;
@property (nonatomic, strong) NSMutableAttributedString   *startLocationString;
@property (nonatomic, strong) NSMutableAttributedString   *endLocationString;

- (instancetype)initWithOrderObject:(BmobObject *)orderObject;

@end
