//
//  JJUserLoginViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

//controllers
#import "JJUserLoginViewController.h"
#import "JJUserRegisterViewController.h"

//views
#import "JJUserTableViewCell.h"

//vendor
#import <BmobSDK/Bmob.h>

//global
#import "JJGlobal.h"
#define loginButtonHeight 45

static NSString *userNameCellIdentifier = @"userNameCellIdentifier";
static NSString *userPasswordCellIdentifier = @"userPasswordCellIdentifier";

@interface JJUserLoginViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIButton      *loginButton;

@end


@implementation JJUserLoginViewController
#pragma mark - private methods
- (void)registerAction:(id)sender{
    JJUserRegisterViewController *registerViewController = [[JJUserRegisterViewController alloc] init];
    registerViewController.navigationItem.title = @"注册";
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)loginAction:(id)sender{
    NSString *phone = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).textField.text;
    NSString *password = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).textField.text;
    if ([phone length] != 11) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号码输入不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([password length] < 6 || [password length] > 32) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码输入不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [BmobUser loginWithUsernameInBackground:phone password:password block:^(BmobUser *user, NSError *error) {
        WEAKSELF
        if (error) {
            return;
        }
        if (user) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
#pragma mark - set up
- (void)setUpNavigationItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerAction:)];
}
#pragma mark - uitableview datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        JJUserTableViewCell *cell = (JJUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:userNameCellIdentifier];
        if (cell == nil) {
            cell = [JJUserTableViewCell cellWithIdentifier:userNameCellIdentifier tittle:@"账号" placeholder:@"请输入手机号码"];
        }
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 0)];
        return cell;
    }
    if (indexPath.row == 1) {
        JJUserTableViewCell *cell = (JJUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:userPasswordCellIdentifier];
        if (cell == nil) {
            cell = [JJUserTableViewCell cellWithIdentifier:userPasswordCellIdentifier tittle:@"密码" placeholder:@"6-32位字母数字组合"];
            [cell.textField setSecureTextEntry:YES];
        }
        return cell;
    }
    return nil;
}
#pragma mark - lify cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.loginButton];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        CGFloat positionY = 44 * 2 + 35;
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(8, positionY, self.view.frame.size.width - 16, loginButtonHeight)];
        [_loginButton setBackgroundColor:MAIN_COLOR];
        [_loginButton setTintColor:MAIN_COLOR];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5.f;
        [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
@end
