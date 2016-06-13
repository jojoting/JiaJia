//
//  JJUserAuthViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserAuthViewController.h"

//views
#import "JJUserTableViewCell.h"

//global
#import "JJGlobal.h"

#define authButtonHeight 35
#define confirmButtonPositionY (44 * [self.tableView numberOfRowsInSection:0] + 18 + 64 + 19 + authButtonHeight)

typedef NS_ENUM(NSInteger, JJUserAuthType) {
    JJUserAuthTypeStudent = 0,
    JJUserAuthTypeTeacher
};

@interface JJUserAuthViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, assign) JJUserAuthType    userAuthType;
@property (nonatomic, strong) UIButton          *studentAuthButton;
@property (nonatomic, strong) UIButton          *teacherAuthButton;
@property (nonatomic, strong) UIButton          *confirmButton;
@property (nonatomic, strong) NSArray           *authInfos;


@end

@implementation JJUserAuthViewController

#pragma mark - private methods
- (void)configInfos{
    self.authInfos = @[@[
                           @[@"姓名",@"姓名"],
                           @[@"电话",@"请输入电话号码"],
                           @[@"身份证号",@"请输入身份证号"],
                           @[@"学校",@"请输入学校完整全称"],
                           @[@"学院",@"请输入学校完整全称"],
                           @[@"专业班级",@"请输入专业完整全称及班级"],
                           @[@"学号",@"请输入学号"]
                         ],
                       @[
                           @[@"姓名",@"姓名"],
                           @[@"电话",@"请输入电话号码"],
                           @[@"身份证号",@"请输入身份证号"],
                           @[@"学校",@"请输入学校完整全称"],
                           @[@"职位",@"请输入职位完整全称"]
                           ]];
}
- (void)setUpViews{
    self.navigationItem.title = @"身份认证";
    [self.view addSubview:self.studentAuthButton];
    [self.view addSubview:self.teacherAuthButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmButton];
}

- (void)studentAuthButtonClicked:(UIButton *)button{
    self.userAuthType = JJUserAuthTypeStudent;
}

- (void)teacherAuthButtonClicked:(UIButton *)button{
    self.userAuthType = JJUserAuthTypeTeacher;
}

- (void)confirmAction:(UIButton *)button{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - uitableview delegate
#pragma mark - uitableview datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(self.authInfos[self.userAuthType]) count];
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
    cell.title = self.authInfos[self.userAuthType][indexPath.row][0];
    cell.placeholder = self.authInfos[self.userAuthType][indexPath.row][1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.returnKeyType = UIReturnKeyDone;
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 19.f;
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configInfos];
    [self setUpViews];
    self.userAuthType = JJUserAuthTypeStudent;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter
- (void)setUserAuthType:(JJUserAuthType )userAuthType{
    _userAuthType = userAuthType;
    
    switch (_userAuthType) {
        case JJUserAuthTypeStudent:
        {
            [self.studentAuthButton setTintColor:COLOR_HEX(0xF0E92F, 1.0)];
            [self.studentAuthButton setBackgroundColor:COLOR_HEX(0xF0E92F, 1.0)];
            [self.studentAuthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.teacherAuthButton setTintColor:[UIColor whiteColor]];
            [self.teacherAuthButton setBackgroundColor:[UIColor whiteColor]];
            [self.teacherAuthButton setTitleColor:COLOR_HEX(0x58595B, 1.0) forState:UIControlStateNormal];
            
            [self.tableView reloadData];
            
            self.confirmButton.frame = CGRectMake(12, confirmButtonPositionY, self.view.frame.size.width - 24, 45);
        }
            break;
        
        case JJUserAuthTypeTeacher:
        {
            [self.teacherAuthButton setTintColor:COLOR_HEX(0xF0E92F, 1.0)];
            [self.teacherAuthButton setBackgroundColor:COLOR_HEX(0xF0E92F, 1.0)];
            [self.teacherAuthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.studentAuthButton setTintColor:[UIColor whiteColor]];
            [self.studentAuthButton setBackgroundColor:[UIColor whiteColor]];
            [self.studentAuthButton setTitleColor:COLOR_HEX(0x58595B, 1.0) forState:UIControlStateNormal];
            
            [self.tableView reloadData];
            
            self.confirmButton.frame = CGRectMake(12, confirmButtonPositionY, self.view.frame.size.width - 24, 45);

        }
            break;
        default:
            break;
    }
}
#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, authButtonHeight + 64, self.view.frame.size.width, self.view.frame.size.height - authButtonHeight - 64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIButton *)studentAuthButton{
    if (!_studentAuthButton) {
        _studentAuthButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width / 2, authButtonHeight)];
        [_studentAuthButton setTitle:@"学生认证" forState:UIControlStateNormal];
        _studentAuthButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _studentAuthButton.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [_studentAuthButton setBackgroundColor:[UIColor whiteColor]];
        [_studentAuthButton setTintColor:[UIColor whiteColor]];
        [_studentAuthButton addTarget:self action:@selector(studentAuthButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _studentAuthButton;
}

- (UIButton *)teacherAuthButton{
    if (!_teacherAuthButton) {
        _teacherAuthButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 64, self.view.frame.size.width / 2, authButtonHeight)];
        [_teacherAuthButton setTitle:@"教师认证" forState:UIControlStateNormal];
        [_teacherAuthButton setBackgroundColor:[UIColor whiteColor]];
        [_teacherAuthButton setTintColor:[UIColor whiteColor]];
        _teacherAuthButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _teacherAuthButton.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [_teacherAuthButton addTarget:self action:@selector(teacherAuthButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _teacherAuthButton;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(12, confirmButtonPositionY, self.view.frame.size.width - 24, 45)];
        [_confirmButton setBackgroundColor:MAIN_COLOR];
        [_confirmButton setTintColor:MAIN_COLOR];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 7.f;
    }
    return _confirmButton;
}

@end
