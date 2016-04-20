//
//  JJBaseViewModel.m
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJBaseViewModel.h"

@implementation JJBaseViewModel

#pragma mark - init
+ (instancetype)viewModelWithSuccessBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock{
    return [[self alloc] initWithSuccessBlock:(SuccessBlock)successBlock
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

- (void)setSuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    _successBlock = successBlock;
    _failureBlock = failureBlock;
}

@end
