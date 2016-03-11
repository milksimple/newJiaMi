//
//  JXTeacherController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

// 存储教师的json数据的路径
#define JXTeacherJsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"teacherJson.archive"]

#import "JXTeacherController.h"
#import "JXTeacherViewCell.h"
#import "JXTeacher.h"
#import "JXSearchBar.h"
#import "JXTeacherToolBar.h"
#import "UIView+Extension.h"
#import <BBBadgeBarButtonItem.h>
#import "JXNavLetterButton.h"
#import "JXTeacherDetailController.h"
#import "JXTeacherHeaderView.h"
#import "JXHttpTool.h"
#import "JXAccount.h"
#import "JXAccountTool.h"
#import <MJExtension.h>
#import "JXTeachersTool.h"
#import "JXSearchParas.h"
#import "JXFilterView.h"
#import "JXNavigationController.h"
#import "JXFilterViewController.h"
#import <MJRefresh.h>
#import "JXAutoOrderController.h"
#import "JXFeeGroupTool.h"
#import <CoreLocation/CoreLocation.h>

@interface JXTeacherController () <UITableViewDataSource, UITableViewDelegate, JXSearchBarDelegate, JXAutoOrderControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIView *toolView;

@property (nonatomic, weak) JXSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *teachers;
/** tableview上次滚动到的contentOffset的y值 */
@property (nonatomic, assign) CGFloat lastScroolY;
/** 是否正在拖动tableview */
@property (nonatomic, assign) BOOL draging;
/** 筛选参数 */
@property (nonatomic, strong) JXSearchParas *searchParas;
/** 筛选view */
@property (nonatomic, weak) JXFilterView *filterView;
/** 自主订单的总金额 */
@property (nonatomic, assign) NSInteger totalPay;
@end

@implementation JXTeacherController

#pragma mark - 懒加载
- (NSMutableArray *)teachers {
    if (_teachers == nil) {
        _teachers = [NSMutableArray array];
    }
    return _teachers;
}

- (JXSearchParas *)searchParas {
    if (_searchParas == nil) {
        _searchParas = [[JXSearchParas alloc] init];
        _searchParas.star = -1;
        _searchParas.sex = JXSexAny;
    }
    return _searchParas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"报名"];

    [self setupTableView];
    
    [self setupToolView];
    
    // 监听通知
    [self addNotificationObserver];
    
    // 先从沙盒加载上次关闭app之前的教师数据
    NSDictionary *json = [NSKeyedUnarchiver unarchiveObjectWithFile:JXTeacherJsonPath];
    if (json) { // 之前有数据
        [self dealData:json];
    }
    // 初始化上下拉刷新
    [self setupRefresh];
    
    // 加载最新数据
    [self loadNewTeachers];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.contentInset = UIEdgeInsetsMake([JXSearchBar height], 0, 0, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 80;
    
    [self.tableView registerClass:[JXTeacherViewCell class] forCellReuseIdentifier:@"teacher"];
}

- (void)setupToolView {
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor redColor];
    JXSearchBar *searchBar = [[JXSearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, JXScreenW, [JXSearchBar height]);
    [toolView addSubview:searchBar];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    
    toolView.frame = CGRectMake(0, 64, JXScreenW, CGRectGetMaxY(searchBar.frame));
    [self.view insertSubview:toolView aboveSubview:self.tableView];
    self.toolView = toolView;
}

/**
 *  监听通知
 */
- (void)addNotificationObserver {
    // 监听通知
    [JXNotificationCenter addObserver:self selector:@selector(filterViewClickedCancelButton) name:JXFilterViewClickedCancelButtonNotification object:nil];
    [JXNotificationCenter addObserver:self selector:@selector(filterViewClickedConfirmButton:) name:JXFilterViewClickedConfirmButtonNotification object:nil];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTeachers)];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTeachers)];
}

/**
 *  加载最新教练列表
 */
- (void)loadNewTeachers {
    // 1.拼接请求参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"keyword"] = self.searchParas.keyword;
    paras[@"sex"] = @(self.searchParas.sex);
    paras[@"star"] = @(self.searchParas.star);
    paras[@"school"] = self.searchParas.school.uid;
    
    if (account.location) {
        paras[@"lat"] = [NSString stringWithFormat:@"%f", account.location.coordinate.latitude];
        paras[@"lon"] = [NSString stringWithFormat:@"%f", account.location.coordinate.longitude];
    }
    
    // 请求老师数据
    [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/CoachFace" params:paras success:^(id json) {
        // 停止刷新状态
        [self.tableView.mj_header endRefreshing];
        
        // 将json数据存入沙盒
        [NSKeyedArchiver archiveRootObject:json toFile:JXTeacherJsonPath];
        
        // 处理json数据
        [self dealData:json];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        JXLog(@"请求失败 - %@", error);
    }];
}

/**
 *  处理从服务或从沙盒获取的json数据
 */
- (void)dealData:(NSDictionary *)json {
    // 字典数组转模型数组
    NSMutableArray *newTeachers = [JXTeacher mj_objectArrayWithKeyValuesArray:json[@"rows"]];
    if (self.searchParas.feeGroups) {
        for (JXTeacher *newTeacher in newTeachers) {
            newTeacher.price = [JXFeeGroupTool totalPayWithFeeGroups:self.searchParas.feeGroups];
        }
    }
    self.teachers = newTeachers;
    [self.tableView reloadData];
}

- (void)loadMoreTeachers {
    // 1.拼接请求参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"start"] = [NSString stringWithFormat:@"%zd", self.teachers.count];
    paras[@"mobile"] = self.searchParas.mobile;
    paras[@"password"] = self.searchParas.password;
    paras[@"keyword"] = self.searchParas.keyword;
    paras[@"sex"] = @(self.searchParas.sex);
    paras[@"star"] = @(self.searchParas.star);
    paras[@"school"] = self.searchParas.school.uid;
    
    JXAccount *account = [JXAccountTool account];
    if (account.location) {
        paras[@"lat"] = [NSString stringWithFormat:@"%f", account.location.coordinate.latitude];
        paras[@"lon"] = [NSString stringWithFormat:@"%f", account.location.coordinate.longitude];
    }
    
    // 取出后面的老师
    [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/CoachFace" params:paras success:^(id json) {
        // 停止刷新状态
        [self.tableView.mj_footer endRefreshing];
        
        // 字典数组转模型数组
        NSArray *moreTeachers = [JXTeacher mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        if (self.searchParas.feeGroups) {
            for (JXTeacher *moreTeacher in moreTeachers) {
                moreTeacher.price = [JXFeeGroupTool totalPayWithFeeGroups:self.searchParas.feeGroups];
            }
        }
        [self.teachers addObjectsFromArray:moreTeachers];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        JXLog(@"请求失败 - %@", error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - JXSearchBarDelegate
/**
 *  搜索按钮被点击了
 */
- (void)searchBarButtonDidClickedWithSearchContent:(NSString *)searchContent {
    // 发送请求
    self.searchParas.keyword = searchContent;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  搜索框中的内容清空了
 */
- (void)searchBarDidClearedSearchText {
    // 发送请求
    self.searchParas.keyword = nil;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  筛选按钮被点击了
 */
- (void)searchBarDidClickedFilterButton {
    JXFilterViewController *filterVC = [[JXFilterViewController alloc] init];
    filterVC.searchParas = self.searchParas;
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:filterVC];
    JXFilterView *filterView = [JXFilterView filterView];
    filterView.contentViewController = nav;
    [filterView show];
    self.filterView = filterView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teachers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacher" forIndexPath:indexPath];
    cell.teacher = self.teachers[indexPath.row];
    
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacher *teacher = self.teachers[indexPath.row];
    JXTeacherDetailController *detailVC = [[JXTeacherDetailController alloc] initWithStyle:UITableViewStylePlain];
    // 教师数据
    detailVC.teacher = teacher;
    // 学费明细数据
    detailVC.feeGroups = self.searchParas.feeGroups;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXTeacherHeaderView *header = [JXTeacherHeaderView headerView];
    header.totalPay = [JXFeeGroupTool totalPayWithFeeGroups:self.searchParas.feeGroups];
    __weak typeof(self) weakSelf = self;
    header.orderButtonClickedAction = ^{
        JXAutoOrderController *autoOrderVC = [[JXAutoOrderController alloc] init];
        // 传递数据
        autoOrderVC.searchParas = weakSelf.searchParas;
        autoOrderVC.delegate = weakSelf;
        JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:autoOrderVC];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXTeacherHeaderView headerHeight];
}


#pragma mark - filterView的通知
/**
 *  筛选控制器view的取消按钮被点击了
 */
- (void)filterViewClickedCancelButton {
    [self.filterView dismiss];
}

/**
 *  筛选控制器view的确认按钮被点击了
 */
- (void)filterViewClickedConfirmButton:(NSNotification *)noti {
    [self.filterView dismiss];
    NSDictionary *userInfo = noti.userInfo;
    JXSearchParas *searchParas = userInfo[@"JXSearchParasKey"];
    searchParas.feeGroups = nil;
    self.searchParas = searchParas;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - JXAutoOrderControllerDelegate
- (void)autoOrderDidFinishedWithSearchParas:(JXSearchParas *)searchParas {
    self.searchParas = searchParas;
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark - UITableViewDelegate
/*
 * 上滚动工具栏隐藏，下滚动工具栏出现
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
 self.draging = YES;
 self.lastScroolY = scrollView.contentOffset.y;
 }
 
 - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
 self.draging = NO;
 }
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 [self.searchBar quitKeyboard];
 
 if (self.draging == NO) return;
 
 if (scrollView.contentOffset.y > self.lastScroolY) {
 if (self.toolView.hidden == NO) {
 [UIView animateWithDuration:0.25 animations:^{
 self.toolView.y = - [JXSearchBar height];
 } completion:^(BOOL finished) {
 self.toolView.hidden = YES;
 }];
 }
 
 }
 else {
 if (self.toolView.hidden == YES) {
 self.toolView.hidden = NO;
 [UIView animateWithDuration:0.25 animations:^{
 self.toolView.y = 64;
 }];
 }
 
 }
 }
 */
@end
