//
//  JJOrderModel.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJOrderModel.h"

@implementation JJOrderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.totalTime = @0;
        self.totalAmount = @0.00;
        self.totalDistance = @0.00;
        self.startLocation = @"";
        self.endLocation = @"";
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    JJOrderModel *newOrderModel = [[JJOrderModel alloc] init];
    newOrderModel.totalTime = self.totalTime;
    newOrderModel.totalAmount = self.totalAmount;
    newOrderModel.totalDistance = self.totalDistance;
    newOrderModel.startLocation = [self.startLocation copy];
    newOrderModel.endLocation = [self.endLocation copy];
    
    return newOrderModel;
}
@end
