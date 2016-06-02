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
#import "JJVehicleView.h"
#import "JJGlobal.h"

#define endTripButtonHeight 45

@interface JJVehicleViewController ()

@property (nonatomic, strong) JJVehicleView *vehicleView;
@property (nonatomic, strong) UIButton      *endTripButton;

@end

@implementation JJVehicleViewController

#pragma mark - private
- (void)setUpNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"vehicle_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)dismiss:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)endTripButtonClicked:(id)sender{
    
}

- (void)updateViewInfo:(NSNotification *)notify{
    [self.vehicleView updateData];
}

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    [[JJVehicleViewModel sharedViewModel] fetchVehicleData];
    
    [self.view addSubview:self.vehicleView];
    [self.view addSubview:self.endTripButton];
    [self setUpNavigationItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViewInfo:) name:NOTIFICATION_VEHICLE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (JJVehicleView *)vehicleView{
    if (!_vehicleView) {
        _vehicleView = [[JJVehicleView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size
                                                                       .height - 64 - endTripButtonHeight)];
    }
    return _vehicleView;
}
- (UIButton *)endTripButton{
    if (!_endTripButton) {
        _endTripButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.vehicleView.frame.size.height + 64, self.view.frame.size.width, endTripButtonHeight)];
        _endTripButton.backgroundColor = MAIN_COLOR;
        [_endTripButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_endTripButton setTitle:@"结束行程" forState:UIControlStateNormal];
        [_endTripButton addTarget:self action:@selector(endTripButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endTripButton;
}


@end
