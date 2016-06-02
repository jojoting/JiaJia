//
//  JJVehicleViewModel.h
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JJBaseViewModel.h"


typedef void(^CompletionBlock)(BOOL isSuccessful);

@interface JJVehicleViewModel : NSObject

@property (nonatomic, strong) NSNumber  *speed;
@property (nonatomic, strong) NSNumber  *distance;
@property (nonatomic, strong) NSNumber  *time;
@property (nonatomic, strong) NSNumber  *leftTime;
@property (nonatomic, assign) NSInteger  battery;

@property (nonatomic, copy) NSString *speedString;
@property (nonatomic, copy) NSString *distanceString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSString *leftTimeString;
@property (nonatomic, copy) NSString *batteryString;


+ (JJVehicleViewModel *)sharedViewModel;

/**
 *  获取车辆信息数据
 */
- (void)fetchVehicleDataWithIdentifier:(NSString *)identifier completion:(CompletionBlock)completion;

/**
 *  停止连接
 */
- (void)cancelConnection;

@end
