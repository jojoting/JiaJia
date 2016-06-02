//
//  JJPayViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJPayViewController.h"
#import "JJPaySuccessViewController.h"
//views
#import "JJPaySectionHeadView.h"
#import "JJPayDetailAmountCell.h"
#import "JJPayTypeCell.h"

//global
#import "JJGlobal.h"
#import "JJBmobEngine.h"

//models
#import "JJorderModel.h"

@interface JJPayViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIButton      *confirmPayButton;

@end

@implementation JJPayViewController

#pragma mark - private methods
- (void)confirmPayAction:(id)sender{
    NSDictionary *params = @{
                             KEY_ORDER_TIME : self.orderModel.totalTime,
                             KEY_ORDER_AMOUNT : self.orderModel.totalAmount,
                             KEY_ORDER_DISTANCE : self.orderModel.totalDistance,
                             KEY_ORDER_START_LOCATION : self.orderModel.startLocation,
                             KEY_ORDER_END_LOCATION : self.orderModel.endLocation
                             };
    JJBmobEngine *bmobEngine = [[JJBmobEngine alloc] init];
    [bmobEngine addOrderWithUser:[BmobUser getCurrentUser] params:params resultBlock:^(BOOL isSuccessful, NSError *error) {
        WEAKSELF
        if (isSuccessful) {
            JJPaySuccessViewController *paySuccessViewController = [[JJPaySuccessViewController alloc] init];
            [weakSelf.navigationController pushViewController:paySuccessViewController animated:YES];
        }
    }];
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付车费";

    //debug
    self.orderModel = [[JJOrderModel alloc] init];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmPayButton];
    [self.view bringSubviewToFront:self.confirmPayButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitable view delegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    if (section == 1) return 3;
    if (section == 2) return 2;
    else return 0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 105.f;
    }
    else return 45.f;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 0.01f;
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) return nil;
    
    JJPaySectionHeadView *headView = [[JJPaySectionHeadView alloc] init];
    if (section == 1) {
        headView.title = @"车费详情";
    }
    if (section == 2) {
        headView.title = @"支付方式";
    }
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *totalAmountCellIdentifier = @"totalAmountCellIdentifier";
    static NSString *detailAmountCellIdentifier = @"detailAmountCellIdentifier";
    static NSString *payTypeCellIdentifier = @"payTypeCellIdentifier";

    if (indexPath.section == 0) {
        UITableViewCell *totalAmountCell = [tableView dequeueReusableCellWithIdentifier:totalAmountCellIdentifier];
        if (!totalAmountCell) {
            totalAmountCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:totalAmountCellIdentifier];
        }
        totalAmountCell.textLabel.textAlignment = NSTextAlignmentCenter;
        totalAmountCell.textLabel.textColor = MAIN_COLOR;
        totalAmountCell.textLabel.font = [UIFont systemFontOfSize:29.f];
        totalAmountCell.textLabel.text = [NSString stringWithFormat:@"车费合计：%@元",self.orderModel.totalAmount];
        totalAmountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return totalAmountCell;
    }
    
    if (indexPath.section == 1) {
        JJPayDetailAmountCell *detailAmountCell = [tableView dequeueReusableCellWithIdentifier:detailAmountCellIdentifier];
        if (!detailAmountCell) {
            detailAmountCell = [[JJPayDetailAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailAmountCellIdentifier];
        }
        if (indexPath.row == 0) {
            [detailAmountCell setTitle:[NSString stringWithFormat:@"里程费（%@公里）",self.orderModel.totalDistance] detail:[NSString stringWithFormat:@"%.2f元",FEE_KM([self.orderModel.totalDistance floatValue])]];
        }
        if (indexPath.row == 1) {
            [detailAmountCell setTitle:[NSString stringWithFormat:@"时长费（%d分%d秒）",(int)([self.orderModel.totalTime integerValue] / 60),(int)([self.orderModel.totalTime integerValue] % 60)] detail:[NSString stringWithFormat:@"%.2f元",FEE_TIME([self.orderModel.totalTime integerValue])]];
        }
        if (indexPath.row == 2) {
            [detailAmountCell setTitle:@"优惠合计" detail:@"0.00元"];
            [detailAmountCell settitleColor:COLOR_HEX(0xF8A258, 1.0) detailColor:COLOR_HEX(0xF8A258, 1.0)];
        }
        return detailAmountCell;
    }
    if (indexPath.section == 2) {
        JJPayTypeCell *payTypeCell = [tableView dequeueReusableCellWithIdentifier:payTypeCellIdentifier];
        if (!payTypeCell) {
            payTypeCell = [[JJPayTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payTypeCellIdentifier];
        }
        if (indexPath.row == 0) {
            [payTypeCell setImage:[UIImage imageNamed:@"pay_wechat"] title:@"微信支付"];
        }
        if (indexPath.row == 1) {
            [payTypeCell setImage:[UIImage imageNamed:@"pay_ali"] title:@"支付宝支付"];
        }
        payTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return payTypeCell;
    }
    return nil;
}
#pragma mark - uitableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mak - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)confirmPayButton{
    if (!_confirmPayButton) {
        _confirmPayButton = [[UIButton alloc] initWithFrame:CGRectMake(37, self.view.frame.size.height - 64 - 45, self.view.frame.size.width - 74, 45)];
        [_confirmPayButton setBackgroundColor:MAIN_COLOR];
        [_confirmPayButton setTintColor:MAIN_COLOR];
        [_confirmPayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmPayButton setTitle:[NSString stringWithFormat:@"确认支付%@元",self.orderModel.totalAmount] forState:UIControlStateNormal];
        _confirmPayButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmPayButton addTarget:self action:@selector(confirmPayAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmPayButton.layer.masksToBounds = YES;
        _confirmPayButton.layer.cornerRadius = 7.f;
    }
    return _confirmPayButton;
}
@end
