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
#import "JJVehicleViewController.h"
#import "JJPayViewController.h"
#import "JJOrderViewController.h"
#import "JJUserCouponViewController.h"
#import "JJUserMessageCenterViewController.h"
#import "JJUserAboutViewController.h"
#import "JJQRCodeReaderViewController.h"

//views
#import "JJUserCenterView.h"
#import "JJHomeExtensionView.h"
#import "JJHomeTripDetailView.h"

//vendor
#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <BmobSDK/Bmob.h>
#import <LBXScan/LBXScanViewController.h>
#import <SVProgressHUD/SVProgressHUD.h>

//global
#import "JJGlobal.h"
#import "JJBmobEngine.h"
#import "JJVehicleViewModel.h"

//models
#import "JJOrderModel.h"

#define UserCenterViewWidth 275
#define ConfirmButtonHeight 45
#define TripDetailViewHeight 95
#define VehicleButtonHeight 50

@interface JJHomeViewController ()<MAMapViewDelegate, JJHomeExtensionViewDelegate, JJUserCenterDelegate, AMapNaviManagerDelegate, AMapNaviViewControllerDelegate, JJTripDetailDelegate>{
    CGFloat _currentLatitude;
    CGFloat _currentLongitude;
}

@property (nonatomic, strong) MAMapView             *mapView;
@property (nonatomic, strong) JJUserCenterView      *userCenterView;
@property (nonatomic, strong) JJHomeExtensionView   *extensionView;
@property (nonatomic, strong) JJHomeTripDetailView  *tripDetailView;
@property (nonatomic, strong) UIButton              *confirmButton;
@property (nonatomic, strong) UIButton              *stopButton;
@property (nonatomic, strong) UIButton              *vehicleButton;


@property (nonatomic, strong) MAUserLocation        *startLocation;
@property (nonatomic, strong) AMapNaviPoint         *startPoint;
@property (nonatomic, strong) NSMutableArray        *endLocations;
@property (nonatomic, copy) NSString                *endLocationTitle;
@property (nonatomic, strong) AMapNaviManager       *naviManager;
@property (nonatomic, strong) AMapNaviViewController *naviViewController;


@end

@implementation JJHomeViewController

#pragma mark - init

- (void)initNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user_center"] style:UIBarButtonItemStyleDone target:self action:@selector(slideUserCenter:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message_center"] style:UIBarButtonItemStyleDone target:self action:@selector(messageCenterClicked:)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_icon"]];
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
    [self initStationAnnotations];
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
    [self.view addSubview:self.confirmButton];
    [self.view bringSubviewToFront:self.confirmButton];
    
    [self.view addSubview:self.stopButton];
    [self.view bringSubviewToFront:self.stopButton];
    self.stopButton.hidden = YES;
    
    [self.view addSubview:self.tripDetailView];
    [self.view bringSubviewToFront:self.tripDetailView];
    self.tripDetailView.hidden = YES;
    
    [self.view addSubview:self.vehicleButton];
    [self.vehicleButton bringSubviewToFront:self.vehicleButton];
    self.vehicleButton.hidden = YES;
}


- (void)initAnnotations
{
    //起始点标注
    MAPointAnnotation *beginAnnotation = [[MAPointAnnotation alloc] init];
    [beginAnnotation setCoordinate:CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude)];
    beginAnnotation.title= @"起始点";
    
    [self.mapView addAnnotation:beginAnnotation];
    
    //终点标注
    MAPointAnnotation *endAnnotation = [[MAPointAnnotation alloc] init];
    [endAnnotation setCoordinate:CLLocationCoordinate2DMake(((AMapNaviPoint *)self.endLocations[0]).latitude, ((AMapNaviPoint *)self.endLocations[0]).longitude)];
    endAnnotation.title        = @"终点";
    
    [self.mapView addAnnotation:endAnnotation];
    
}

- (void)initStationAnnotations{
    //添加站点标注
    JJBmobEngine *bmobEndgine = [[JJBmobEngine alloc] init];
    [bmobEndgine getStationsWithReturnBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *bmobObject in array) {
            MAPointAnnotation *stationAnnotation = [[MAPointAnnotation alloc] init];
            [stationAnnotation setCoordinate:CLLocationCoordinate2DMake([[bmobObject objectForKey:KEY_STATION_LATITUDE] doubleValue], [[bmobObject objectForKey:KEY_STATION_LONGITUDE] doubleValue])];
            stationAnnotation.title= @"站点";
            [self.mapView addAnnotation:stationAnnotation];
        }
    }];
}

#pragma mark - UIControlEvent
- (void)confirmButtonClicked:(UIButton *)sender{
    
    if (self.endLocations.count == 0 || !self.startPoint){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择地点" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    
    JJQRCodeReaderViewController *vc = [[JJQRCodeReaderViewController alloc] init];
    vc.returnBlock = ^(JJQRCodeReaderViewController *QRCodeReaderViewController ,NSString *resultStr){
        [QRCodeReaderViewController.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD showWithStatus:@"正在蓝牙配对E-Car"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [[JJVehicleViewModel sharedViewModel] fetchVehicleDataWithIdentifier:resultStr completion:^(BOOL isSuccessful) {
            WEAKSELF
            if (isSuccessful) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"成功配对E-Car"];
                [SVProgressHUD dismissWithDelay:0.7];
                [weakSelf startTrip];
            } else {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"配对失败，请检查蓝牙状态"];
                [SVProgressHUD dismissWithDelay:0.7];
            }
        }];
    };
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)vehicleButtonClicked:(UIButton *)sender{
    JJVehicleViewController *vehicleViewController = [[JJVehicleViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vehicleViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)stopButtonClicked:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"到达目的地，结束行程" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self stopTrip];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)messageCenterClicked:(id)sender{
    JJUserMessageCenterViewController *userMessageCenterViewController = [[JJUserMessageCenterViewController alloc] init];
    [self.navigationController pushViewController:userMessageCenterViewController animated:YES];
}
#pragma mark - private megthods

- (void)longPressMapView:(UILongPressGestureRecognizer *)longPress{
}

- (void)slideUserCenter:(id)sender{
    NSLog(@"%.2f", self.userCenterView.frame.origin.x);
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        self.userCenterView.username = [user objectForKey:KEY_USER_NAME];
        self.userCenterView.userAvatarUrl = [NSString stringWithFormat:@"http://%@",[user objectForKey:KEY_USER_AVATAR]];
    }else{
        self.userCenterView.username = @"登陆/注册";
        self.userCenterView.userAvatarUrl = nil;

    }
    
    if (self.userCenterView.slideViewState == JJSlideViewStateSlideIn) {
        [self.userCenterView slideOut:YES];
    } else
        [self.userCenterView slideIn:YES];
    
    NSLog(@"%.2f", self.userCenterView.frame.origin.x);
}

- (void)selectEndLocationAtIndex:(NSInteger )index{
    JJAddAddressViewController *addAddressViewController = [[JJAddAddressViewController alloc] init];
    addAddressViewController.currentLatitude = _currentLatitude;
    addAddressViewController.currentLongitude = _currentLongitude;
    __weak __typeof(self) weakSelf = self;
    addAddressViewController.returnBlock = ^(NSString *locationTitle, CGFloat latitude, CGFloat longitude){
        weakSelf.endLocationTitle = locationTitle;
        [weakSelf.extensionView setLocationTitle:locationTitle atIndex:index];
        AMapNaviPoint *endPoints = [AMapNaviPoint locationWithLatitude:latitude longitude:longitude];
        weakSelf.endLocations[index] = endPoints;
        if (weakSelf.startPoint) {
            [weakSelf calculateRoute];
        }
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addAddressViewController];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)selectStartLocation{
    JJAddAddressViewController *addAddressViewController = [[JJAddAddressViewController alloc] init];
    addAddressViewController.currentLatitude = _currentLatitude;
    addAddressViewController.currentLongitude = _currentLongitude;
    __weak __typeof(self) weakSelf = self;
    addAddressViewController.returnBlock = ^(NSString *locationTitle, CGFloat latitude, CGFloat longitude){
        weakSelf.extensionView.startLocationTitle = locationTitle;
        weakSelf.startPoint = [AMapNaviPoint locationWithLatitude:latitude longitude:longitude];
        if (weakSelf.endLocations.count >= 1) {
            [weakSelf calculateRoute];
        }
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addAddressViewController];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)calculateRoute{
    [self.naviManager calculateWalkRouteWithStartPoints:@[self.startPoint] endPoints:self.endLocations];

}

- (void)showRouteWithNaviRoute:(AMapNaviRoute *)naviRoute
{
    if (naviRoute == nil)
    {
        return;
    }
    
    // 清除旧的overlays
    [self.mapView removeOverlays:self.mapView.overlays];
    
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++)
    {
        AMapNaviPoint *aCoordinate = [naviRoute.routeCoordinates objectAtIndex:i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:coordianteCount];
    [self.mapView addOverlay:polyline];
}

- (void)startTrip{
    [self showOnTripView];
}

- (void)stopTrip{
    self.confirmButton.hidden = NO;
    self.stopButton.hidden = YES;
    self.tripDetailView.hidden = YES;
    self.vehicleButton.hidden = YES;
    self.extensionView.hidden = NO;
    
    [self.naviManager stopNavi];
    [[JJVehicleViewModel sharedViewModel] cancelConnection];
    
    JJOrderModel *orderModel = [[JJOrderModel alloc] init];
    orderModel.totalTime = [JJVehicleViewModel sharedViewModel].time;
    orderModel.totalDistance = [JJVehicleViewModel sharedViewModel].distance;
    orderModel.totalAmount = @([orderModel.totalDistance floatValue] * 1.5);
    orderModel.startLocation = self.startLocation.title;
    orderModel.endLocation = self.endLocationTitle;
    JJPayViewController *payViewController = [[JJPayViewController alloc] init];
    payViewController.orderModel = orderModel;
    [self.navigationController pushViewController:payViewController animated:YES];
}

- (void)showOnTripView{
    self.confirmButton.hidden = YES;
    self.stopButton.hidden = NO;
    self.vehicleButton.hidden = NO;
    self.tripDetailView.hidden = NO;
    self.extensionView.hidden = YES;
    self.tripDetailView.detailTitle = self.startLocation.title;
    self.tripDetailView.detailInfo = self.extensionView.tripInfo;
}

- (void)updateVehicleInfo:(NSNotification *)notify{
    [self.vehicleButton setTitle:[JJVehicleViewModel sharedViewModel].speedString forState:UIControlStateNormal];
}
#pragma mark - life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    [self initSubViews];
    self.endLocations = [[NSMutableArray alloc] initWithCapacity:3];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVehicleInfo:) name:NOTIFICATION_VEHICLE object:nil];
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
    if (updatingLocation && !self.startPoint) {
//        NSLog(@"latitude:%.2f longtitude:%.2f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        _currentLatitude = (CGFloat )userLocation.coordinate.latitude;
        _currentLongitude = (CGFloat )userLocation.coordinate.longitude;
        self.startLocation = userLocation;
        self.startPoint = [AMapNaviPoint locationWithLatitude:_currentLatitude longitude:_currentLongitude];
        self.extensionView.startLocationTitle = userLocation.title;
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
//        annotationView.canShowCallout= YES;//设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;//设置标注动画显示，默认为NO
//        annotationView.draggable = YES;//设置标注可以拖动，默认为NO
        
        if ([annotation.title isEqualToString:@"起始点"]) {
            annotationView.pinColor = MAPinAnnotationColorRed;
        } else if ([annotation.title isEqualToString:@"终点"]){
            annotationView.pinColor = MAPinAnnotationColorPurple;
        } else {
            annotationView.image = [UIImage imageNamed:@"annotation"];
        }
        return annotationView;
    }
    return nil;
}

#pragma mark - map navi delegate
- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager{
    [self.extensionView setTripDistance:naviManager.naviRoute.routeLength time:naviManager.naviRoute.routeLength/2.78];
    self.extensionView.isTrpiInfoLabelShow = YES;
    
    [self showRouteWithNaviRoute:[[naviManager naviRoute] copy]];
    [self initAnnotations];
    
    [naviManager startGPSNavi];
}

- (void)naviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController
{
    [self.naviManager dismissNaviViewControllerAnimated:YES];
}


- (void)naviViewControllerMoreButtonClicked:(AMapNaviViewController *)naviViewController{
    JJVehicleViewController *vehicleViewController = [[JJVehicleViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vehicleViewController];
    [naviViewController presentViewController:nav animated:YES completion:nil];
}


- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 3.0f;
        polylineView.strokeColor = [UIColor blueColor];
        
        return polylineView;
    }
    return nil;
}

#pragma mark - extensionView delegate
- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectStartLocationView:(JJLocationView *)locationView{
    NSLog(@"选择出发地");
    [self selectStartLocation];
}

- (void)extensionView:(JJHomeExtensionView *)extensionView didSelectEndLocationView:(JJLocationView *)locationView index:(NSInteger )index{
    [self selectEndLocationAtIndex:index];
}

- (void)extensionView:(JJHomeExtensionView *)extensionView didAddEndLocationView:(JJLocationView *)locationView atIndex:(NSInteger)index{
    [self selectEndLocationAtIndex:index];
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
    [userCenterView slideIn:NO];
    
    if (index == 0) {
        //行程记录
        JJOrderViewController *orderViewController = [[JJOrderViewController alloc] init];
        [self.navigationController pushViewController:orderViewController animated:YES];
    }
    if (index == 1) {
        //优惠券
        JJUserCouponViewController *userCouponViewController = [[JJUserCouponViewController alloc] init];
        [self.navigationController pushViewController:userCouponViewController animated:YES];
    }
    if (index == 2) {
        //消息中心
        JJUserMessageCenterViewController *userMessageCenterViewController = [[JJUserMessageCenterViewController alloc] init];
        [self.navigationController pushViewController:userMessageCenterViewController animated:YES];
    }
    if (index == 3) {
        //关于
        JJUserAboutViewController *userAboutViewController = [[JJUserAboutViewController alloc] init];
        [self.navigationController pushViewController:userAboutViewController animated:YES];
    }
}

#pragma mark - trip detail view delegate
- (void)tripDetailView:(JJHomeTripDetailView *)tripDetailView didClickedButton:(UIButton *)button{
    [self.naviManager presentNaviViewController:self.naviViewController animated:YES];
}
#pragma mark - getter
- (UIButton *)vehicleButton{
    if (!_vehicleButton) {
        _vehicleButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 12 - VehicleButtonHeight, self.view.frame.origin.x + 13 + 64, VehicleButtonHeight, VehicleButtonHeight)];
        [_vehicleButton setBackgroundImage:[UIImage imageNamed:@"vehicle_button"] forState:UIControlStateNormal];
        [_vehicleButton setTitle:@"E-Car" forState:UIControlStateNormal];
        _vehicleButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_vehicleButton setTitleColor:COLOR_HEX(0xE98727, 1.0) forState:UIControlStateNormal];
        [_vehicleButton addTarget:self action:@selector(vehicleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vehicleButton;
}

- (AMapNaviManager *)naviManager{
    if (!_naviManager) {
        _naviManager = [[AMapNaviManager alloc] init];
        _naviManager.delegate = self;
    }
    return _naviManager;
}

- (AMapNaviViewController *)naviViewController{
    if (!_naviViewController) {
        _naviViewController = [[AMapNaviViewController alloc] initWithDelegate:self];
    }
    return _naviViewController;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height - 5 - ConfirmButtonHeight, self.view.frame.size.width - 10, ConfirmButtonHeight)];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 5.f;
        [_confirmButton setBackgroundColor:MAIN_COLOR];
        [_confirmButton setTitle:@"我要租车" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _confirmButton;
}

- (UIButton *)stopButton{
    if (!_stopButton) {
        _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - ConfirmButtonHeight, self.view.frame.size.width, ConfirmButtonHeight)];
        [_stopButton setBackgroundColor:MAIN_COLOR];
        [_stopButton setTitle:@"结束行程" forState:UIControlStateNormal];
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _stopButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_stopButton addTarget:self action:@selector(stopButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}

- (JJHomeTripDetailView *)tripDetailView{
    if (!_tripDetailView) {
        _tripDetailView = [[JJHomeTripDetailView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - ConfirmButtonHeight - TripDetailViewHeight, self.view.frame.size.width, TripDetailViewHeight)];
        _tripDetailView.delegate = self;
    }
    return _tripDetailView;
}

@end
