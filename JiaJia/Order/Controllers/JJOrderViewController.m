//
//  JJOrderViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/28.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJOrderViewController.h"

//views
#import "JJOrderTableViewCell.h"
#import "JJTableViewFooter.h"

//view models
#import "JJOrderViewModel.h"

//global
#import "JJBmobEngine.h"
#import "JJGlobal.h"

@interface JJOrderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, copy) NSArray         *orders;
@end

@implementation JJOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    JJBmobEngine *bmobEngine = [[JJBmobEngine alloc] init];
    [bmobEngine getOrderWithUser:[BmobUser getCurrentUser] returnBlock:^(NSArray *array, NSError *error) {
        WEAKSELF
        weakSelf.orders = array;
        [weakSelf.tableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitableView datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orders.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"orderTableViewIdentifier";
    
    JJOrderViewModel *viewModel = [[JJOrderViewModel alloc] initWithOrderObject:self.orders[indexPath.row]];
    JJOrderTableViewCell *cell = (JJOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JJOrderTableViewCell alloc] initWithViewModel:viewModel reuseIdentifier:identifier];
    }
    cell.viewModel = viewModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 55.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[JJTableViewFooter alloc] initWithTitle:@"无更多行程" frame:[tableView rectForFooterInSection:section]];
}
#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
