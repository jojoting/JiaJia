//
//  JJHomeViewController.m
//  JiaJia
//
//  Created by jojoting on 16/4/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJHomeViewController.h"

//views
#import "JJUserCenterView.h"

//vendor
#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

#define UserCenterViewWidth 130

@interface JJHomeViewController ()<MAMapViewDelegate, JJSlideViewDelegate>

@property (nonatomic, strong) MAMapView         *mapView;
@property (nonatomic, strong) JJUserCenterView  *userCenterView;

@end

@implementation JJHomeViewController

#pragma mark - init

- (void)initNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:@selector(slideUserCenter:)];
}

- (void)initMapView{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollowWithHeading];
    [self.mapView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMapView:)]];
    
    [self.view addSubview:self.mapView];
}

- (void)initUserCenterView{
    JJUserCenterView *userCenterView = [[JJUserCenterView alloc] initWithFrame:CGRectMake(0, 0, UserCenterViewWidth, self.view.frame.size.height)];
    userCenterView.backgroundColor = [UIColor redColor];
    
    self.userCenterView = userCenterView;
    self.userCenterView.delegate = self;
    [self.view addSubview:self.userCenterView];
    [self.view bringSubviewToFront:self.userCenterView];
    
}
#pragma mark - private megthods

- (void)longPressMapView:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [longPress locationInView:self.mapView];
        NSLog(@"long press location x : %.2f  y: %.2f",point.x,point.y);
    }
}

- (void)slideUserCenter:(id)sender{
    NSLog(@"%.2f", self.userCenterView.frame.origin.x);

    if (self.userCenterView.slideViewState == JJSlideViewStateSlideIn) {
        [self.userCenterView slideOut:YES];
    } else
        [self.userCenterView slideIn:YES];
    
    NSLog(@"%.2f", self.userCenterView.frame.origin.x);
}
#pragma mark - life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    [self initMapView];
    [self initUserCenterView];
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


@end
