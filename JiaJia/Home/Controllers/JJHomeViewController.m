//
//  JJHomeViewController.m
//  JiaJia
//
//  Created by jojoting on 16/4/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

//controllers
#import "JJHomeViewController.h"
#import "JJUserViewController.h"
#import "JJAddAddressViewController.h"
#import "JJUserLoginViewController.h"
//views
#import "JJUserCenterView.h"
#import "JJHomeExtensionView.h"

//vendor
#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <BmobSDK/Bmob.h>

#define UserCenterViewWidth 275
#define ConfirmButtonHeight 45

@interface JJHomeViewController ()<MAMapViewDelegate, JJHomeExtensionViewDelegate, JJUserCenterDelegate>

@property (nonatomic, strong) MAMapView             *mapView;
@property (nonatomic, strong) JJUserCenterView      *userCenterView;
@property (nonatomic, strong) JJHomeExtensionView   *extensionView;

@end

@implementation JJHomeViewController

#pragma mark - init

- (void)initNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:@selector(slideUserCenter:)];
}

- (void)initSubViews{
    [self initMapView];
    [self initUserCenterView];
    [self initExtensionView];
    [self initOtherViews];
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
    userCenterView.backgroundColor = [UIColor whiteColor];
    userCenterView.userInteractionEnabled = YES;
    
    self.userCenterView = userCenterView;
    self.userCenterView.delegate = self;
    [self.navigationController.view addSubview:self.userCenterView];
    [self.navigationController.view bringSubviewToFront:self.userCenterView];
    
}

- (void)initExtensionView{
    self.extensionView = [[JJHomeExtensionView alloc] initWithLocationViewHeight:40 tripInfoLabelHeight:20];
    [self.view addSubview:self.extensionView];
    [self.view bringSubviewToFront:self.extensionView];
    self.extensionView.delegate = self;
}

- (void)initOtherViews{
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height - 5 - ConfirmButtonHeight, self.view.frame.size.width - 10, ConfirmButtonHeight)];
    [confirmButton setBackgroundColor:[UIColor lightGrayColor]];
    [confirmButton setTitle:@"我要租车" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    confirmButton
    [confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    [self.view bringSubviewToFront:confirmButton];
}

#pragma mark - UIControlEvent
- (void)confirmButtonClicked:(UIButton *)sender{
    
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
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.userCenterView.hidden = YES;
}
#pragma mark - map delegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        NSLog(@"latitude:%.2f longtitude:%.2f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

#pragma mark - extensionView delegate
- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectStartLocationView:(JJLocationView *)locationView{
    NSLog(@"选择出发地");
}

- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectEndLocationView:(JJLocationView *)locationView index:(NSInteger )index{
    NSLog(@"选择目的地%ld",index);
    JJAddAddressViewController *addAddressViewController = [[JJAddAddressViewController alloc] init];
    [self.navigationController pushViewController:addAddressViewController animated:YES];
}

#pragma mark - user center delegate

- (void)didSelectUserInfoWithUserCenterView:(JJUserCenterView *)userCenterView{
    NSLog(@"选择个人信息");
    [self.userCenterView slideIn:NO];
    
    if (![BmobUser getCurrentUser]) {
        JJUserLoginViewController *loginViewController = [[JJUserLoginViewController alloc] init];
        loginViewController.navigationItem.title = @"登录";
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    JJUserViewController *userViewController = [[JJUserViewController alloc] init];
    userViewController.navigationItem.title = @"个人信息";
    [self.navigationController pushViewController:userViewController animated:YES];
}
- (void)userCenterView:(JJUserCenterView *)userCenterView buttonClickedAtIndex:(NSInteger )index{
    NSLog(@"点击:%ld",index);
}

@end
