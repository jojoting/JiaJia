//
//  JJHomeViewController.m
//  JiaJia
//
//  Created by jojoting on 16/4/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJHomeViewController.h"

//vendor
#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface JJHomeViewController ()<MAMapViewDelegate>

@property (strong, nonatomic) MAMapView    *mapView;

@end

@implementation JJHomeViewController

#pragma mark - init

- (void)initMapView{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollowWithHeading];
    [self.mapView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMapView:)]];
    
    [self.view addSubview:self.mapView];
}

#pragma mark - private megthods

- (void)longPressMapView:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [longPress locationInView:self.mapView];
        NSLog(@"long press location x : %.2f  y: %.2f",point.x,point.y);
    }
}
#pragma mark - life cycle


- (void)viewDidLoad {
    NSLog(@"hello jiajia");
    
    [self initMapView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - map delegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        NSLog(@"latitude:%.2f longtitude:%.2f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
