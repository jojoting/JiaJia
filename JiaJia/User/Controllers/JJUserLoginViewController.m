//
//  JJUserLoginViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserLoginViewController.h"

//views
#import "JJUserTableViewCell.h"

static NSString *userNameCellIdentifier = @"userNameCellIdentifier";
static NSString *userPasswordCellIdentifier = @"userPasswordCellIdentifier";

@interface JJUserLoginViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIButton      *loginButton;

@end


@implementation JJUserLoginViewController

#pragma mark - uitableview datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        JJUserTableViewCell *cell = (JJUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:userNameCellIdentifier];
        if (cell == nil) {
            cell = [JJUserTableViewCell cellWithTittle:@"账号" placeholder:@"请输入手机号码"];
        }
        return cell;
    }
    if (indexPath.row == 1) {
        JJUserTableViewCell *cell = (JJUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:userPasswordCellIdentifier];
        if (cell == nil) {
            cell = [JJUserTableViewCell cellWithTittle:@"密码" placeholder:@"6-32位字母数字组合"];
        }
        return cell;
    }
    return nil;
}
#pragma mark - lify cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
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
    }
    return _tableView;
}
@end
