//
//  JJVehicleViewModel.h
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJBaseViewModel.h"

@interface JJVehicleViewModel : JJBaseViewModel

/**
 *  类方法初始化ViewModel
 *
 *  @param successBlock 设置成功的回调block
 *  @param failureBlock 设置失败的回调block
 *
 *  @return 
 */
+ (instancetype)viewModelWithSuccessBlock:(SuccessBlock )successBlock
                             failureBlock:(FailureBlock )failureBlock;


/**
 *  实例方法初始化ViewModel
 *
 *  @param successBlock 设置成功的回调block
 *  @param failureBlock 设置失败的回调block
 *
 *  @return
 */

- (instancetype)initWithSuccessBlock:(SuccessBlock)successBlock
                        failureBlock:(FailureBlock)failureBlock;

/**
 *  获取车辆信息数据
 */
- (void)fetchVehicleData;
@end
