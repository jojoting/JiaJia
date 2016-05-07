//
//  JJAddAddressViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/4.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJAddAddressViewController.h"

//views
#import "JJAddAddressCollectionViewCell.h"

#define collectionViewHeight    260

static NSString *collectionViewCellIdentifier = @"collectionViewCell";
static NSString *tableViewCellIdentifier = @"tableViewCell";

@interface JJAddAddressViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, copy) NSDictionary        *addressDictionary;
@property (nonatomic, copy) NSArray             *addresses;
@property (nonatomic, copy) NSArray             *selectAddresses;
@end

@implementation JJAddAddressViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.addresses = @[@"校门",@"公寓",@"公共教学楼",@"行政楼",@"饭堂",@"图书馆",@"其他",@"周边"];
    self.addressDictionary = @{@"校门":
                                   @[
                                       @"华工正门",
                                   ],
                               @"公寓":
                                   @[
                                       @"C1学生公寓",
                                       @"C2学生公寓",
                                       @"C3学生公寓",
                                       @"C4学生公寓",
                                       @"C5学生公寓",
                                       @"C6学生公寓",
                                       @"C7学生公寓",
                                       @"C8学生公寓",
                                       @"C9学生公寓",
                                       @"C10学生公寓",
                                       @"C11学生公寓",
                                       @"C12学生公寓",
                                       @"C13学生公寓",
                                       @"C14学生公寓",
                                       @"C15学生公寓",
                                       @"C16学生公寓"
                                       
                                   ],
                               @"公共教学楼":
                                   @[
                                       @"A1教学楼",
                                       @"A2教学楼",
                                       @"A3教学楼",
                                       @"B1教学楼",
                                       @"B2教学楼",
                                       @"B3教学楼",
                                       @"B4教学楼",
                                       @"B5教学楼",
                                       @"B6教学楼",
                                       @"B7教学楼",
                                       @"B8教学楼"
                                   ],
                               @"行政楼":
                                   @[
                                       @"B2行政楼"
                                   ],
                               @"饭堂":
                                   @[
                                       @"第一学生食堂",
                                       @"第二学生食堂"
                                   ],
                               @"图书馆":
                                   @[
                                       @"校图书馆"
                                   ],
                               @"其他":
                                   @[
                                       @"教学区体育场",
                                       @"生活区体育场",
                                       @"学术大讲堂",
                                       @"音乐厅",
                                       @"当代艺术空间馆",
                                       @"校医室",
                                       @"世博超市"
                                   ],
                               @"周边":
                                   @[
                                       @"餐厅",
                                       @"大学城南地铁站",
                                   ]
                               };

    self.selectAddresses = [NSArray arrayWithArray:self.addressDictionary[@"校门"]];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView dataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectAddresses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    cell.textLabel.text = self.selectAddresses[indexPath.row];
    return cell;
}
#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UICollectionView dataSource
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.addresses.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJAddAddressCollectionViewCell *cell = (JJAddAddressCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
    [cell layoutIfNeeded];
    cell.text = self.addresses[indexPath.row];
//    cell.layer.borderWidth = 1.f;
    
    return cell;
}

#pragma mark - UICollectionView delegate
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = self.addresses[indexPath.row];
    self.selectAddresses = self.addressDictionary[key];
    [self.tableView reloadData];
    
}
#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.frame.size.width / 4 , collectionViewHeight / 2);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, collectionViewHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[JJAddAddressCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
        _collectionView.scrollEnabled = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    }
    return _collectionView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, collectionViewHeight + 64, self.view.frame.size.width, self.view.frame.size.height - collectionViewHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
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
