//
//  JJUserViewController.m
//  JiaJia
//
//  Created by jojoting on 16/4/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

//controllers
#import "JJUserViewController.h"
#import "JJUserAuthViewController.h"
#import "JJUserModifyViewController.h"

//vendor
#import <BmobSDK/Bmob.h>
#import <UIImageView+WebCache.h>

//global
#import "JJGlobal.h"
#import "JJQiniuEngine.h"

static NSString *avatalCellIdentifier = @"avatarCell";
static NSString *normalCellIdentifier = @"normalCell";
@interface JJUserViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) BmobUser      *user;
@property (nonatomic, strong) UIPickerView  *pickerView;
@end

@implementation JJUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
     // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.user = [BmobUser getCurrentUser];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (UITableViewCell *)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.textLabel.font = [UIFont systemFontOfSize:11.f];
    cell.textLabel.textColor = COLOR_HEX(0x58595B, 1.0);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11.f];
    cell.detailTextLabel.textColor = COLOR_HEX(0x58595B, 1.0);

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


- (void)changeAvatar{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.barTintColor = MAIN_COLOR;
    picker.navigationBar.tintColor = [UIColor whiteColor];
    picker.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)uploadImageData:(NSData *)data{
    [[JJQiniuEngine sharedInstance] getQiniuTokenAndUpload:data block:^(QNResponseInfo *info, NSString *key, NSDictionary *dict) {
        WEAKSELF
        if ([key length] > 0) {
            [weakSelf.user setObject:[[JJQiniuEngine sharedInstance] getQiniuFullUrl:key] forKey:KEY_USER_AVATAR];
            [weakSelf.user updateInBackground];
            [weakSelf.tableView reloadData];
            
        }
    }];
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
        NSString *urlString = [NSString stringWithFormat:@"http://%@",[self.user objectForKey:KEY_USER_AVATAR]];
        [avatarCell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//        avatarCell.imageView.layer.masksToBounds = YES;
//        avatarCell.imageView.layer.cornerRadius = avatarCell.imageView.frame.size.width / 2;
        avatarCell.detailTextLabel.text = @"修改头像";
        avatarCell.detailTextLabel.font = [UIFont systemFontOfSize:11.f];
        avatarCell.detailTextLabel.textColor = COLOR_HEX(0x58595B, 1.0);
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        //修改头像
        [self changeAvatar];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //修改手机
        JJUserModifyViewController *validateViewController = [[JJUserModifyViewController alloc] initValidateWithType:JJUserValidateTypePhone titles:@[@"手机号码",@"验证码"] placeholders:@[self.user.username,@"请输入验证码"]];
        validateViewController.navigationItem.title = @"验证手机号";
        [self.navigationController pushViewController:validateViewController animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //修改昵称
        JJUserModifyViewController *modifyViewController = [[JJUserModifyViewController alloc] initModifyWithType:JJuserModifyTypeName titles:@[@""] placeholders:@[@"请输入昵称"]];
        modifyViewController.navigationItem.title = @"修改昵称";
        [self.navigationController pushViewController:modifyViewController animated:YES];
    }

    if (indexPath.section == 0 && indexPath.row == 3) {
        //修改密码
        JJUserModifyViewController *validateViewController = [[JJUserModifyViewController alloc] initValidateWithType:JJUserValidateTypePassword titles:@[@"原密码"] placeholders:@[@"请输入原密码"]];
        validateViewController.navigationItem.title = @"验证原密码";
        [self.navigationController pushViewController:validateViewController animated:YES];
    }

    if (indexPath.section == 0 && indexPath.row == 4) {
        //修改性别
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.user setObject:@"男" forKey:KEY_USER_GENDER];
            [self.user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    WEAKSELF
                    [weakSelf.tableView reloadData];
                }
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.user setObject:@"女" forKey:KEY_USER_GENDER];
            [self.user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    WEAKSELF
                    [weakSelf.tableView reloadData];
                }
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];

        [self presentViewController:alert animated:YES completion:nil];
    }

    
    if (indexPath.section == 1) {
        JJUserAuthViewController *userAuthViewController = [[JJUserAuthViewController alloc] init];
        [self.navigationController pushViewController:userAuthViewController animated:YES];
    }
    if (indexPath.section == 2){
        //退出登录
        [BmobUser logout];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIImagePickerViewController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.01);
    [self uploadImageData:imageData];
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
