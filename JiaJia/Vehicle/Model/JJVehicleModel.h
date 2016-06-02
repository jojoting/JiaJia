//
//  JJVehicleModel.h
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJVehicleModel : NSObject

@property (nonatomic, strong) NSNumber  *speed;
@property (nonatomic, strong) NSNumber  *distance;
@property (nonatomic, strong) NSNumber  *time;
@property (nonatomic, strong) NSNumber  *leftTime;
@property (nonatomic, assign) NSInteger  battery;


@end
