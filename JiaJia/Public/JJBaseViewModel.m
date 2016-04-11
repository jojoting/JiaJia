//
//  JJBaseViewModel.m
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJBaseViewModel.h"

@implementation JJBaseViewModel

- (void)setSuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    _successBlock = successBlock;
    _failureBlock = failureBlock;
}

@end
