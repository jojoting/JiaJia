//
//  JJOrderModel.h
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJOrderModel : NSObject<NSCopying>

@property (nonatomic, strong) NSNumber  *totalAmount;
@property (nonatomic, strong) NSNumber  *totalDistance;
@property (nonatomic, strong) NSNumber  *totalTime;
@property (nonatomic, copy) NSString    *startLocation;
@property (nonatomic, copy) NSString    *endLocation;

@end
