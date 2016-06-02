//
//  JJUserAboutViewController.m
//  JiaJia
//
//  Created by jojoting on 16/6/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserAboutViewController.h"
#import <BmobSDK/Bmob.h>
#import "MWPhotoBrowser.h"

@interface JJUserAboutViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSArray       *titles;

@end

@implementation JJUserAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"视频介绍（一）",@"视频介绍（二）",@"图片介绍"];
    self.navigationItem.title = @"关于E-Car";
    [self.view addSubview:self.tableView];
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
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableViewCellIdentifier = @"aboutTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 2){
        //视频介绍
        BmobQuery *query = [BmobQuery queryWithClassName:@"Config"];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            NSString *urlString = [array[indexPath.row] objectForKey:@"vedio_url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
//        [UIApplication sharedApplication]
    }
    if (indexPath.row == 2) {
        //图片介绍
        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:@[[MWPhoto photoWithImage:[UIImage imageNamed:@"about_photo.jpg"]]]];
        [self.navigationController pushViewController:photoBrowser animated:YES];
    }
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
