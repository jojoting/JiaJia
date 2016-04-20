//
//  JJVehicleViewController.m
//  JiaJia
//
//  Created by jojoting on 16/4/12.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJVehicleViewController.h"
#import "JJVehicleViewModel.h"
#import "JJVehicleModel.h"

@interface JJVehicleViewController ()

@end

@implementation JJVehicleViewController


#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    JJVehicleViewModel *viewModel = [JJVehicleViewModel viewModelWithSuccessBlock:^(id returnValue) {
        
    } failureBlock:^{
        
    }];
    [viewModel fetchVehicleData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
