//
//  JJUserViewController.m
//  JiaJia
//
//  Created by jojoting on 16/4/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

//controllers
#import "JJUserViewController.h"

//vendor
#import <BmobSDK/Bmob.h>

//config
#import "JJGlobal.h"
static NSString *avatalCellIdentifier = @"avatarCell";
static NSString *normalCellIdentifier = @"normalCell";
@interface JJUserViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) BmobUser      *user;
@end

@implementation JJUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.user = [BmobUser getCurrentUser];
     // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (UITableViewCell *)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        cell.textLabel.text = @"身份认证";
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"退出登录";
    }
    if (indexPath.section == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        switch (indexPath.row) {
            case 1:
            {
                //手机
                cell.textLabel.text = @"绑定手机";
                cell.detailTextLabel.text = [self.user objectForKey:KEY_USER_PHONE];
            }
                break;
            case 2:
            {
                //昵称
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = [self.user objectForKey:KEY_USER_NAME];
            }
                break;
            case 3:
            {
                //密码
                cell.textLabel.text = @"密码";
                cell.detailTextLabel.text = @"修改";
            }
                break;
            case 4:
            {
                //性别
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = [self.user objectForKey:KEY_USER_GENDER];
            }
                break;
            case 5:
            {
                //等级
                cell.textLabel.text = @"会员等级";
                cell.detailTextLabel.text = [self.user objectForKey:KEY_USER_LEVEL];

            }
                break;
            default:
                break;
        }
    }
    return cell;
}
#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }
    return 1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 55;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //头像
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:avatalCellIdentifier];
        if (avatarCell == nil) {
            avatarCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:avatalCellIdentifier];
        }
        avatarCell.imageView.image = [UIImage imageNamed:[self.user objectForKey:KEY_USER_AVATAR]];
//        avatarCell.imageView.layer.masksToBounds = YES;
//        avatarCell.imageView.layer.cornerRadius = 40;
        avatarCell.detailTextLabel.text = @"修改头像";
        avatarCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        avatarCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        return avatarCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:normalCellIdentifier];
    }
    return [self configCell:cell indexPath:indexPath];
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
        _tableView.userInteractionEnabled = YES;
    }
    return _tableView;
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
