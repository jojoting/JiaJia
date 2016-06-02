//
//  JJVehicleModel.m
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleModel.h"

@implementation JJVehicleModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.time = @(0);
        self.leftTime = @(0);
        self.distance = @(0.00);
        self.speed = @(0.00);
        self.battery = 0;
    }
    return self;
}

@end
