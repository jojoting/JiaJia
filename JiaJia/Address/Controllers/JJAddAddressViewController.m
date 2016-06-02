//
//  JJAddAddressViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/4.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJAddAddressViewController.h"
#import "JJSetRegularAddressViewController.h"

//views
#import "JJAddAddressCollectionViewCell.h"
#import "JJRegularAddressView.h"

//vendor
#import <AMapSearchKit/AMapSearchKit.h>

//global
#import "JJGlobal.h"


#define collectionViewHeight    220
#define searchBarWidth          220
#define searchBarHeight         40
#define regularAddressViewHeight 40
static NSString *collectionViewCellIdentifier = @"collectionViewCell";
static NSString *tableViewCellIdentifier = @"tableViewCell";

@interface JJAddAddressViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, AMapSearchDelegate, UISearchBarDelegate>{
}

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIView            *regularAddressContainerView;
@property (nonatomic, copy) NSArray             *addresses;
@property (nonatomic, copy) NSArray             *selectAddresses;
@property (nonatomic, strong) AMapSearchAPI     *search;
@property (nonatomic, strong) UISearchBar       *searchBar;
@property (nonatomic, assign) BOOL               showCollectionView;
@end

@implementation JJAddAddressViewController


#pragma mark - private methods
- (void)searchWithKeywords:(NSString *)keywords{
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:self.currentLatitude longitude:self.currentLongitude];
    request.keywords = keywords;
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"餐饮服务|生活服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施|汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [self.search AMapPOIAroundSearch: request];
}

- (void)setUpNavigationBar{
    [self.navigationItem setTitleView:self.searchBar];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissAction:)];
    self.navigationController.navigationBar.tintColor = MAIN_COLOR;
}

- (void)setUpRegularAddressViews{
    CGFloat regularAddressViewWidth = self.view.frame.size.width / 2;
    NSArray *regularAddresses = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_USER_DEFAULT_REGULAR_ADDRESS];
    NSString *addressName = @"";
    for (int i = 0 ; i < 2 ; i ++ ) {
        if (regularAddresses.count == 0) {
            addressName = [NSString stringWithFormat:@"设置常用地址%d", i+1];
        }
        else if (regularAddresses.count >= i+1) {
            addressName = [regularAddresses[i] objectForKey:KEY_USER_DEFAULT_REGULAR_ADDRESS_NAME];
        }
        else {
            addressName = [NSString stringWithFormat:@"设置常用地址%d", i+1];
        }
        JJRegularAddressView *regularAddressView = [[JJRegularAddressView alloc] initWithFrame:CGRectMake(i * regularAddressViewWidth, 0, regularAddressViewWidth, regularAddressViewHeight)];
        regularAddressView.addressName = addressName;
        regularAddressView.tag = i;
        [regularAddressView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addRegularAddressAction:)]];
        [self.regularAddressContainerView addSubview:regularAddressView];
    }
}


- (void)clearSearchData{
    self.selectAddresses = @[];
    [self.tableView reloadData];
}

- (void)cancelSearch{
    self.searchBar.text = @"";
    [self.searchBar endEditing:YES];
    self.searchBar.showsCancelButton = NO;
    self.showCollectionView = YES;
}

- (void)dismissAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addRegularAddressAction:(UITapGestureRecognizer *)tap{
    JJRegularAddressView *regularAddressView = (JJRegularAddressView *)tap.view;
    
    if (![regularAddressView.addressName isEqualToString:[NSString stringWithFormat:@"设置常用地址%ld", tap.view.tag + 1]]) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_USER_DEFAULT_REGULAR_ADDRESS][tap.view.tag];
        if (self.returnBlock) {
            self.returnBlock(dic[KEY_USER_DEFAULT_REGULAR_ADDRESS_NAME], [dic[KEY_USER_DEFAULT_REGULAR_ADDRESS_LATITUDE] floatValue], [dic[KEY_USER_DEFAULT_REGULAR_ADDRESS_LONGITUDE] floatValue]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    JJSetRegularAddressViewController *setRegularAddressViewController = [[JJSetRegularAddressViewController alloc] init];
    setRegularAddressViewController.resultBlock = ^(AMapPOI *poi){
        if (poi) {
            NSDictionary *dic = @{
                                  KEY_USER_DEFAULT_REGULAR_ADDRESS_NAME : poi.name,
                                  KEY_USER_DEFAULT_REGULAR_ADDRESS_LATITUDE : @(poi.location.latitude),
                                  KEY_USER_DEFAULT_REGULAR_ADDRESS_LONGITUDE : @(poi.location.longitude)
                                  };
            NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:KEY_USER_DEFAULT_REGULAR_ADDRESS]];
            if (!array) {
                array = [NSMutableArray arrayWithCapacity:2];
            }
            array[tap.view.tag] = dic;
            [[NSUserDefaults standardUserDefaults] setObject:[array copy] forKey:KEY_USER_DEFAULT_REGULAR_ADDRESS];
            
            regularAddressView.addressName = poi.name;
        }
    };
    [self.navigationController pushViewController:setRegularAddressViewController animated:YES];
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.addresses = @[@"正门",@"公寓",@"公共教学楼",@"行政楼",@"饭堂",@"图书馆",@"体育馆",@"礼堂"];

    [self setUpNavigationBar];
    
    [self.view addSubview:self.regularAddressContainerView];
    [self setUpRegularAddressViews];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
    
    AMapPOI *poi = (AMapPOI *)self.selectAddresses[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.textLabel.textColor = COLOR_HEX(0x6D6E70, 1.0);
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}
#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AMapPOI *poi = (AMapPOI *)self.selectAddresses[indexPath.row];
    if (self.returnBlock) {
        self.returnBlock(poi.name, poi.location.latitude, poi.location.longitude);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [self searchWithKeywords:key];
}

#pragma mark - AMapSearch Delegate
//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    self.selectAddresses = response.pois;
    [self.tableView reloadData];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self cancelSearch];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *key = searchBar.text;
    if ([key length] <= 0) {
        return;
    }
    [searchBar endEditing:YES];
    [self searchWithKeywords:key];
    self.showCollectionView = NO;
}

#pragma makr - scroll view delegate

#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.frame.size.width / 4 , collectionViewHeight / 2);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + regularAddressViewHeight, self.view.frame.size.width, collectionViewHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[JJAddAddressCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
        _collectionView.scrollEnabled = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _collectionView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, collectionViewHeight + 64 + regularAddressViewHeight, self.view.frame.size.width, self.view.frame.size.height - collectionViewHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UIView *)regularAddressContainerView{
    if (!_regularAddressContainerView) {
        _regularAddressContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, regularAddressViewHeight)];
    }
    return _regularAddressContainerView;
}

- (NSArray *)selectAddresses{
    if (!_selectAddresses) {
        _selectAddresses = [NSArray array];
    }
    return _selectAddresses;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.tintColor = MAIN_COLOR;
    }
    return _searchBar;
}


#pragma mark - setter
- (void)setShowCollectionView:(BOOL)showCollectionView{
    _showCollectionView = showCollectionView;
    self.collectionView.hidden = !showCollectionView;
    if (!showCollectionView) {
        self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        self.collectionView.frame = CGRectZero;
        self.regularAddressContainerView.frame = CGRectZero;
    } else {
        self.collectionView.frame = CGRectMake(0, 64 + regularAddressViewHeight, self.view.frame.size.width, collectionViewHeight) ;
        self.tableView.frame = CGRectMake(0, collectionViewHeight + regularAddressViewHeight + 64, self.view.frame.size.width, self.view.frame.size.height - collectionViewHeight - 64);
        self.regularAddressContainerView.frame = CGRectMake(0, 64, self.view.frame.size.width, regularAddressViewHeight);
        [self clearSearchData];
    }
}
@end
