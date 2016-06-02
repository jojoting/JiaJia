//
//  JJUserModifyViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/29.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserModifyViewController.h"

//views
#import "JJUserTableViewCell.h"

//global
#import "JJGlobal.h"

//vendors
#import <BmobSDK/Bmob.h>

#define confirmButtonPositionY (44 * [self.tableView numberOfRowsInSection:0] + 18 + 64 + 19)


@interface JJUserModifyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) UIButton              *confirmButton;
@property (nonatomic, copy) NSArray                 *titles;
@property (nonatomic, copy) NSArray                 *placeHolders;
@property (nonatomic, assign) JJUserValidateType    validateType;
@property (nonatomic, assign) JJUserModifyType      modifyType;

@end

@implementation JJUserModifyViewController

#pragma mark - init
- (instancetype)initValidateWithType:(JJUserValidateType )validateType titles:(NSArray *)titles placeholders:(NSArray *)placeholders{
    self = [super init];
    if (self) {
        self.validateType = validateType;
        self.modifyType = JJUserModifyTypeNone;
        self.titles = titles;
        self.placeHolders = placeholders;
    }
    return self;
}
- (instancetype)initModifyWithType:(JJUserModifyType )modifyType titles:(NSArray *)titles placeholders:(NSArray *)placeholders{
    self = [super init];
    if (self) {
        self.modifyType = modifyType;
        self.validateType = JJUserValidateTypeNone;
        self.titles = titles;
        self.placeHolders = placeholders;
    }
    return self;

}

#pragma mark - private methods
- (void)modifyConfirmButtonClicked:(id)sender{
    if (self.validateType == JJUserValidateTypeNone) {
        BmobUser *user = [BmobUser getCurrentUser];
        NSString *result = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).textField.text;
        if (result.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息不得为空" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        //确定操作
        switch (self.modifyType) {
            case JJuserModifyTypeName:
            {
                [user setObject:result forKey:@"name"];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    WEAKSELF
                    NSLog(@"%@",error);
                    if (isSuccessful) {
                        [weakSelf.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                    }
                }];

            }
                break;
            case JJUserModifyTypePhone:
            {
                [user setUsername:result];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    WEAKSELF
                    NSLog(@"%@",error);
                    if (isSuccessful) {
                        [weakSelf.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                    }
                }];

            }
                break;
            case JJUserModifyTypePassword:
            {
                NSString *password = ((JJUserTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).textField.text;
                [user updateCurrentUserPasswordWithOldPassword:user.password newPassword:password block:^(BOOL isSuccessful, NSError *error) {
                    WEAKSELF
                    if (isSuccessful) {
                        [weakSelf.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }
    if (self.modifyType == JJUserModifyTypeNone) {
        //验证操作
        switch (self.validateType) {
            case JJUserValidateTypePassword:
            {
                JJUserModifyViewController *modifyViewController = [[JJUserModifyViewController alloc] initModifyWithType:JJUserModifyTypePassword titles:@[@"新密码"] placeholders:@[@"请输入新密码"]];
                modifyViewController.navigationItem.title = @"修改密码";
                [self.navigationController pushViewController:modifyViewController animated:YES];
            }
                break;
            case JJUserValidateTypePhone:
            {
                JJUserModifyViewController *modifyViewController = [[JJUserModifyViewController alloc] initModifyWithType:JJUserModifyTypePhone titles:@[@"手机号码",@"验证码"] placeholders:@[@"请输入手机号码",@"请输入验证码"]];
                modifyViewController.navigationItem.title = @"修改手机号";
                [self.navigationController pushViewController:modifyViewController animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.validateType == JJUserValidateTypeNone ) {
        return 1;
    }
    return self.validateType;
}
//- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"authTableViewIdentifier";
    JJUserTableViewCell *cell = (JJUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [JJUserTableViewCell cellWithIdentifier:identifier tittle:@"" placeholder:@""];
    }
    cell.title = self.titles[indexPath.row];
    cell.placeholder = self.placeHolders[indexPath.row];
    if (self.validateType == JJUserValidateTypePhone && indexPath.row == 0) {
        cell.isValidateButtonHidden = NO;
    }
    if (self.validateType == JJUserValidateTypePassword || self.modifyType == JJUserModifyTypePassword) {
        [cell.textField setSecureTextEntry:YES];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 19.f;
}

#pragma mark - getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.separatorInset = UIEdgeInsetsZero;
        if (self.titles.count == 1){
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        }
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(12, confirmButtonPositionY, self.view.frame.size.width - 24, 45)];
        [_confirmButton setBackgroundColor:MAIN_COLOR];
        [_confirmButton setTintColor:MAIN_COLOR];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (self.validateType == JJUserValidateTypeNone) {
            [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        }else {
            [_confirmButton setTitle:@"验证" forState:UIControlStateNormal];
        }
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [_confirmButton addTarget:self action:@selector(modifyConfirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 7.f;
    }
    return _confirmButton;
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
