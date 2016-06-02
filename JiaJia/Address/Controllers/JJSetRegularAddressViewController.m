//
//  JJSetRegularAddressViewController.m
//  JiaJia
//
//  Created by jojoting on 16/5/26.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJSetRegularAddressViewController.h"

//global
#import "JJGlobal.h"

//vendor
#import <AMapSearchKit/AMapSearchKit.h>

@interface JJSetRegularAddressViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AMapSearchDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UISearchBar       *searchBar;
@property (nonatomic, copy) NSArray             *pois;
@property (nonatomic, strong) AMapSearchAPI     *search;

@end

@implementation JJSetRegularAddressViewController

#pragma mark - private methods
- (void)setUpNavigationItem{
    [self.navigationItem setTitleView:self.searchBar];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissAction:)];
}

- (void)dismissAction:(id)sender{
    self.resultBlock(nil);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchWithKeywords:(NSString *)keywords{
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = keywords;
    request.city = @"广州";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"餐饮服务|生活服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施|汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [self.search AMapPOIKeywordsSearch: request];
}
- (void)cancelSearch{
    self.searchBar.text = @"";
    [self.searchBar endEditing:YES];
    self.searchBar.showsCancelButton = NO;
}


#pragma mark - life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    self.pois = [NSArray array];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;

    [self setUpNavigationItem];
    [self.view addSubview:self.tableView];
    
    [self.searchBar becomeFirstResponder];
}

#pragma mark - UITableView dataSource
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pois.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableViewCellIdentifier = @"tableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    
    AMapPOI *poi = (AMapPOI *)self.pois[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.textLabel.textColor = COLOR_HEX(0x6D6E70, 1.0);
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AMapPOI *poi = (AMapPOI *)self.pois[indexPath.row];
    if (self.resultBlock) {
        self.resultBlock(poi);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
#pragma mark - search bar delegate
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
}

#pragma mark - amap search delegate

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    self.pois = response.pois;
    [self.tableView reloadData];
}

#pragma mark - getter

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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
