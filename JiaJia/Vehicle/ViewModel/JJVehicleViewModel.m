//
//  JJVehicleViewModel.m
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleViewModel.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface JJVehicleViewModel () <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *manager;

@end
@implementation JJVehicleViewModel

#pragma mark - init
+ (instancetype)viewModelWithSuccessBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock{
    return [[JJVehicleViewModel alloc] initWithSuccessBlock:(SuccessBlock)successBlock
                                               failureBlock:(FailureBlock)failureBlock];
}

- (instancetype)initWithSuccessBlock:(SuccessBlock)successBlock
                        failureBlock:(FailureBlock)failureBlock{
    self = [super init];
    if (self) {
        [self setSuccessBlock:successBlock FailureBlock:failureBlock];
    }
    return self;
}

#pragma mark - public methods

- (void)fetchVehicleData{
    [self.manager scanForPeripheralsWithServices:nil options:nil];
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    
}
#pragma mark - getter methods

- (CBCentralManager *)manager{
    if (nil == _manager) {
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _manager;
}

@end
