//
//  JJBaseViewModel.h
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

//返回block类型
typedef void (^SuccessBlock)(id returnValue);
typedef void (^FailureBlock)();

@interface JJBaseViewModel : NSObject

@property(nonatomic, copy) SuccessBlock successBlock;
@property(nonatomic, copy) FailureBlock failureBlock;

/**
 *  设置回调block
 *
 *  @param successBlock 成功回调block
 *  @param failureBlock 失败回调block
 */
- (void) setSuccessBlock:(SuccessBlock )successBlock FailureBlock:(FailureBlock )failureBlock;
@end
