//
//  JJUserRegisterViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/8.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserRegisterViewController.h"

//views
#import "JJUserTableViewCell.h"

//vender
#import <BmobSDK/Bmob.h>

//global
#import "JJGlobal.h"
#define registerButtonHeight 45

static NSString *registerTableViewCellIdentifier = @"registerTableViewCellIdentifier";

@interface JJUserRegisterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIButton      *registerButton;
@end

@implementation JJUserRegisterViewController

#pragma mark - private methods
- (void)registerAction:(id)sender{
    NSString *phone = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).textField.text;
    NSString *validateNumber = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).textField.text;
    NSString *password = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).textField.text;
    if ([phone length] != 11) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号码输入不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([validateNumber length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([password length] < 6 || [password length] > 32) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入6-32位密码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [self registerAccountWithPhone:phone password:password];
}

- (void)registerAccountWithPhone:(NSString *)phone password:(NSString *)password{
    BmobUser *user = [[BmobUser alloc]init];
    user.username = phone;
    user.password = password;
    [user setObject:@"用户" forKey:KEY_USER_NAME];
    [user setObject:@"default_avatar" forKey:KEY_USER_AVATAR];
    [user setObject:@"男" forKey:KEY_USER_GENDER];
    [user setObject:@"LV1" forKey:KEY_USER_LEVEL];
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            return;
        }
        if (isSuccessful) {
            [BmobUser loginWithUsernameInBackground:phone password:password block:^(BmobUser *user, NSError *error) {
                WEAKSELF
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    }];
}

- (void)getSMSValidate:(UIButton *)sender{
    
}
#pragma mark - set up

#pragma mark - uitableview datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJUserTableViewCell *cell = (JJUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerTableViewCellIdentifier];
    if (cell == nil) {
        cell = [JJUserTableViewCell cellWithIdentifier:registerTableViewCellIdentifier tittle:@"账号" placeholder:@"请输入手机号码"];
    }
    if (indexPath.row == 0) {
        cell.isValidateButtonHidden = NO;
        [cell.validateButton addTarget:self action:@selector(getSMSValidate:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row == 1) {
        cell.title = @"验证码";
        cell.placeholder = @"请输入验证码";
    }
    if (indexPath.row == 2) {
        cell.title = @"密码";
        cell.placeholder = @"请输入密码";
        [cell.textField setSecureTextEntry:YES];
    }
    return cell;
}
#pragma mark - lify cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.registerButton];
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

- (UIButton *)registerButton{
    if (!_registerButton) {
        CGFloat positionY = 44 * 3 + 35;
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(8, positionY, self.view.frame.size.width - 16, registerButtonHeight)];
        [_registerButton setBackgroundColor:MAIN_COLOR];
        [_registerButton setTintColor:MAIN_COLOR];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 5.f;
        [_registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
@end
