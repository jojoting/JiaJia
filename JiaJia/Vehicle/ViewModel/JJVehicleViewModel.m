//
//  JJVehicleViewModel.m
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleViewModel.h"
#import "JJVehicleModel.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "JJGlobal.h"

#define debugBluetooth  YES

@interface JJVehicleViewModel () <CBCentralManagerDelegate ,CBPeripheralDelegate>

@property (nonatomic, strong) JJVehicleModel    *vehicleModel;
@property (nonatomic, strong) CBCentralManager  *manager;
@property (nonatomic, strong) CBCentral         *central;
@property (nonatomic, strong) CBPeripheral      *peripheral;
@property (nonatomic, copy) NSString            *identifier;
@property (nonatomic, copy) CompletionBlock     completionBlock;

@property (nonatomic, strong) NSTimer    *timer;
@property (nonatomic, assign) CGFloat     countTime;
@end

static JJVehicleViewModel *sharedViewModelManager = nil;

@implementation JJVehicleViewModel
#pragma mark - init
+ (JJVehicleViewModel *)sharedViewModel{
    if (!sharedViewModelManager) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            sharedViewModelManager = [[self alloc] init];
        });
    }
    return sharedViewModelManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.countTime = 0.f;
    }
    return self;
}
#pragma mark - public methods

- (void)fetchVehicleDataWithIdentifier:(NSString *)identifier completion:(CompletionBlock)completion{
    if (![identifier isEqualToString:@"9C4EF22B-E813-2CA4-FFAC-3A7BE0488ECD"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.completionBlock(NO);
        });
        return;
    }
    self.identifier = identifier;
    self.completionBlock = completion;
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)cancelConnection{
    if (debugBluetooth) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    [self.manager cancelPeripheralConnection:self.peripheral];
}
#pragma mark - private methods
- (void)timerFire:(NSTimer *)timer{
    self.countTime += 1.0;
    if(debugBluetooth) {
        self.vehicleModel.time = @(self.countTime);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_VEHICLE object:nil];
    }
}

- (NSString *)hexStringWithData:(NSData *)data{
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

- (NSInteger )integerWithHexString:(NSString *)hexString{
    NSInteger hexValue = [hexString integerValue];
    return (hexValue/10) * 16 + hexValue%10 ;
}

- (void)processCharacteristicData:(NSData *)data{
    NSString *hexString = [self hexStringWithData:data];
    for (int i = 0; i < hexString.length; i += 2) {
        NSString *subString = [hexString substringWithRange:NSMakeRange(i, 2)];
        if ([subString isEqualToString:@"aa"]) {
            //读取车速
            self.vehicleModel.speed = @((CGFloat )([self integerWithHexString:[hexString substringWithRange:NSMakeRange(i + 2, 2)]] / 10.00));
        }
        if ([subString isEqualToString:@"bb"]) {
            //读取电量
            self.vehicleModel.battery = [self integerWithHexString:[hexString substringWithRange:NSMakeRange(i + 2, 2)]];
        }
    }
    self.vehicleModel.time = @(self.countTime);
    self.vehicleModel.leftTime = @(3600.00 - self.countTime);
    self.vehicleModel.distance = @([self.vehicleModel.distance floatValue] + [self.vehicleModel.speed floatValue] * self.countTime/3600);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_VEHICLE object:nil];
}
//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
        if (debugBluetooth) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                self.completionBlock(YES);
                [self.timer fire];
            });
        } else {
            [self.manager scanForPeripheralsWithServices:nil options:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                if (!self.peripheral)
                    self.completionBlock(NO);
            });
        }

    } else {
        self.completionBlock(NO);
    }
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    NSLog(@"%@",peripheral);
    if ([peripheral.identifier.UUIDString isEqualToString:self.identifier]) {
        self.peripheral = peripheral;
        [central connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    self.completionBlock(YES);
    [self.timer fire];
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}
//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
    self.completionBlock(NO);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - peripheral delegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"service UUID:%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        {
            [self notifyCharacteristic:peripheral characteristic:characteristic];
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}


//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据

    if (![characteristic.UUID.UUIDString isEqualToString:@"FFE1"]) {
        return;
    }
    [self processCharacteristicData:characteristic.value];
}



#pragma mark - getter methods
- (JJVehicleModel *)vehicleModel{
    if (!_vehicleModel) {
        _vehicleModel = [[JJVehicleModel alloc] init];
    }
    return _vehicleModel;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    return _timer;
}

- (NSNumber *)time{
    return self.vehicleModel.time;
}
- (NSNumber *)leftTime{
    return self.vehicleModel.leftTime;
}
- (NSNumber *)distance{
    return self.vehicleModel.distance;
}
- (NSNumber *)speed{
    return self.vehicleModel.speed;
}

- (NSInteger )battery{
    return self.vehicleModel.battery;
}

- (NSString *)speedString{
    CGFloat speedValue = [self.vehicleModel.speed floatValue];
    return [NSString stringWithFormat:@"%.2f",speedValue];
}

- (NSString *)timeString{
    NSInteger timeValue = [self.vehicleModel.time integerValue];
    return [NSString stringWithFormat:@"行驶时间：%ld:%ld:%ld",timeValue/3600, (timeValue%3600)/60, (timeValue%3600)%60];
}

- (NSString *)distanceString{
    CGFloat distanceValue = [self.vehicleModel.distance floatValue];
    return [NSString stringWithFormat:@"行驶路程：%.2fkm",distanceValue];
}

- (NSString *)batteryString{
    NSInteger batteryValue = self.vehicleModel.battery;
    return [NSString stringWithFormat:@"剩余电量：%ld%@",(long)batteryValue,@"%"];
}

- (NSString *)leftTimeString{
    NSInteger leftTimeValue = [self.vehicleModel.leftTime integerValue];
    return [NSString stringWithFormat:@"还可行驶：%ld:%ld:%ld",leftTimeValue/3600, (leftTimeValue%3600)/60, (leftTimeValue%3600)%60];
}




@end
