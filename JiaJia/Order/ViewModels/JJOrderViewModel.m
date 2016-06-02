//
//  JJOrderViewModel.m
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJOrderViewModel.h"
#import "JJGlobal.h"

@implementation JJOrderViewModel

- (instancetype)initWithOrderObject:(BmobObject *)orderObject{
    self = [super init];
    if (self) {
        [self setUpWithOrderObject:orderObject];
    }
    return self;
}

- (void)setUpWithOrderObject:(BmobObject *)orderObject{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.timeString = [dateFormatter stringFromDate:(NSDate *)[orderObject createdAt]];
    
    NSNumber *time = @([[orderObject objectForKey:KEY_ORDER_TIME] integerValue]/ 60);
    NSNumber *distance = [orderObject objectForKey:KEY_ORDER_DISTANCE];
    NSNumber *amount = [orderObject objectForKey:KEY_ORDER_AMOUNT];
    self.infoString = [NSString stringWithFormat:@"时长：%@分钟 里程：%@公里 车费：%@元",time,distance,amount];
    
    NSDictionary *firstAttributes = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:10.f],
                                      NSForegroundColorAttributeName : COLOR_HEX(0x231F20, 1.0)
                                      };
    NSDictionary *secondAttributes = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:10.f],
                                      NSForegroundColorAttributeName : COLOR_HEX(0xA6A8AB, 1.0)
                                      };
    self.startLocationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"起：%@",[orderObject objectForKey:KEY_ORDER_START_LOCATION]]];
    [self.startLocationString setAttributes:firstAttributes range:NSMakeRange(0, 2)];
    [self.startLocationString setAttributes:secondAttributes range:NSMakeRange(2, [self.startLocationString.string length] - 2)];

    self.endLocationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"终：%@",[orderObject objectForKey:KEY_ORDER_END_LOCATION]]];
    [self.endLocationString setAttributes:firstAttributes range:NSMakeRange(0, 2)];
    [self.endLocationString setAttributes:secondAttributes range:NSMakeRange(2, [self.endLocationString.string length] - 2)];

}
@end
