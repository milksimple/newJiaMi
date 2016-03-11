//
//  JXInfoController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#define JXPushInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"pushInfo.archive"]

#import "JXInfoController.h"
#import "JXMessageTableViewCell.h"
#import <SDWebImageManager.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "JXPushInfo.h"
#import "MBProgressHUD+MJ.h"

@interface JXInfoController () <SDWebImageManagerDelegate>

/** 各组展开情况
 *  0 代表闭合
 *  非0 代表展开，并代表改组有多少row
 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *isExplands;
@property (nonatomic, strong) SDWebImageManager *manager;
/** 推送消息数组 */
@property (nonatomic, strong) NSMutableArray *pushInfos;
@end

@implementation JXInfoController

#pragma mark - 懒加载
- (NSMutableArray<NSNumber *> *)isExplands {
    if (_isExplands == nil) {
        _isExplands = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            [_isExplands addObject:@0];
        }
    }
    return _isExplands;
}

- (NSMutableArray *)pushInfos {
    if (_pushInfos == nil) {
        _pushInfos = [NSMutableArray array];
    }
    return _pushInfos;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStylePlain]) {

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
    NSString *letterBadge = [JXUserDefaults objectForKey:JXNavLetterItemBadgeKey];
    if (![letterBadge isEqualToString:@"0"]) {
        [JXUserDefaults setObject:@"0" forKey:JXNavLetterItemBadgeKey];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"最新资讯";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClicked)];
    self.view.backgroundColor = JXGlobalBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JXMessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"messageCell"];
    
    [self setupRefresh];

    // 加载本地数据
    NSMutableArray *localPushInfos = [NSKeyedUnarchiver unarchiveObjectWithFile:JXPushInfoPath];
    if (localPushInfos.count) {
        self.pushInfos = localPushInfos;
        [self.tableView reloadData];
    }
    
    // 获取最新数据
    [self loadInfos];
}

- (void)setupRefresh {
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadInfos)];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfos)];
}

/**
 *  获取最新资讯信息
 */
- (void)loadInfos {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"start"] = @0;
    paras[@"count"] = @8;
    [JXHttpTool post:[NSString stringWithFormat:@"%@/InformationList", JXServerName] params:paras success:^(id json) {
        [self.tableView.mj_header endRefreshing];
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            [self dealData:json];
        }
        else {
            [MBProgressHUD showError:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        JXLog(@"请求失败 - %@", error);
    }];
}

- (void)dealData:(NSDictionary *)json {
    // 字典数组转模型数组
    NSMutableArray *newInfos = [JXPushInfo mj_objectArrayWithKeyValuesArray:json[@"rows"]];
    self.pushInfos = newInfos;
    
    // 将最新资讯存入沙盒
    [NSKeyedArchiver archiveRootObject:self.pushInfos toFile:JXPushInfoPath];
    
    self.isExplands = [NSMutableArray array];
    for (int i = 0; i < self.pushInfos.count; i ++) {
        [self.isExplands addObject:@0];
    }
    [self.tableView reloadData];
}

/**
 *  获取更多资讯
 */
- (void)loadMoreInfos {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"start"] = @(self.pushInfos.count);
    paras[@"count"] = @8;
    [JXHttpTool post:[NSString stringWithFormat:@"%@/InformationList", JXServerName] params:paras success:^(id json) {
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            NSMutableArray *infos = [JXPushInfo mj_objectArrayWithKeyValuesArray:json[@"rows"]];
            [self.pushInfos addObjectsFromArray:infos];
            
            self.isExplands = [NSMutableArray array];
            for (int i = 0; i < self.pushInfos.count; i ++) {
                [self.isExplands addObject:@0];
            }
            
            [self.tableView reloadData];
        }
        else {
            [MBProgressHUD showError:json[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        JXLog(@"请求失败 - %@", error);
    }];
}

/**
 *  编辑按钮被点击
 */
//- (void)editItemClicked {
//    BOOL editing = !self.tableView.editing;
//    [self.tableView setEditing:editing animated:YES];
//    self.navigationItem.rightBarButtonItem.title = editing ? @"完成" : @"编辑";
//}

#pragma mark - tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.pushInfos.count;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXMessageTableViewCell *msgCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    JXPushInfo *pushInfo = self.pushInfos[indexPath.row];
    msgCell.pushInfo = pushInfo;
    msgCell.corverButtonClickedAction = ^{
        self.isExplands[indexPath.row] = @(![self.isExplands[indexPath.row] integerValue]);
        [self.tableView reloadData];
    };
    msgCell.expland = [self.isExplands[indexPath.row] boolValue];
    return msgCell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section % 2 == 0) {
////        JXInfoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"infoHeader"];
////        if (headerView == nil) {
////            headerView = [[JXInfoHeaderView alloc] initWithReuseIdentifier:@"infoHeader"];
////        }
////        return headerView;
//    }
//    else {
//        JXMessageHeaderView *msgHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"msgHeader"];
//        if (msgHeader == nil) {
//            msgHeader = [[JXMessageHeaderView alloc] initWithReuseIdentifier:@"msgHeader"];
//        }
//        return msgHeader;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if ([self.isExplands[row] integerValue] == 1) { // 该行为展开
        JXMessageTableViewCell *explandCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        return [explandCell rowHeight];
    }
    return 54;
}

#pragma mark - 实现滑动删除
/*
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.isExplands removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}
*/
@end
