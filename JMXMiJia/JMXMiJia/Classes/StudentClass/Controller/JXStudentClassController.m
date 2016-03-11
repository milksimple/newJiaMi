//
//  JXStudentClassController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//
// 存储最后一条评论的key
#define JXStudentProgressLastCommentKey @"JXStudentProgressLastCommentKey"
// 存储进度json数据的路径
#define JXStudentProgressJsonPath(mobile) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@studentProgressJson.archive", mobile]]

#import "JXStudentClassController.h"
#import "JXStudentProgressCell.h"
#import "JXStudentProgress.h"
#import "JXStudentProgressDetailCell.h"
#import "JXStudentScoreCell.h"
#import "JXStudentProgressHeader.h"
#import "JXStudentProgressFooter.h"
#import "JXStudentClassHeaderView.h"
#import <MJRefresh.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import <MJExtension.h>
#import "JXToStudentComment.h"
#import "JXReplyToTeacherController.h"

@interface JXStudentClassController () <UITableViewDataSource, UITableViewDelegate, JXStudentProgressFooterDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 课堂进度 */
@property (nonatomic, strong) NSArray *progresses;
/** 各行是否展开,展开为1，闭合为0 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *explands;
/** 当前选中的行 */
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/** 最后一条评论模型 */
@property (nonatomic, strong) JXToStudentComment *lastToStudentComment;
@end

@implementation JXStudentClassController
#pragma mark - 懒加载
- (NSArray *)progresses {
    
    if (_progresses == nil) {
        NSMutableArray *progresses = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            JXStudentProgress *progress = [[JXStudentProgress alloc] init];
            progress.subjectNO = i + 1;
            progress.state = 2;
            [progresses addObject:progress];
        }
        _progresses = progresses;
    }
    return _progresses;
}

- (NSMutableArray<NSNumber *> *)explands {
    if (_explands == nil) {
        _explands = @[@0, @0, @0, @0].mutableCopy;
    }
    return _explands;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的进度";
    
    [self setupTableView];
    
    JXAccount *account = [JXAccountTool account];
    // 先从本地解档
    id json = [NSKeyedUnarchiver unarchiveObjectWithFile:JXStudentProgressJsonPath(account.mobile)];
    if (json) {
        [self dealData:json];
    }
    
    // 初始化上下拉刷新
    [self setupRefresh];
    
    // 加载最新数据
    [self loadProgressData];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadProgressData)];
}

/**
 *  获取下载进度数据
 */
- (void)loadProgressData {
    JXAccount *account = [JXAccountTool account];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    
    [JXHttpTool post:[NSString stringWithFormat:@"%@/TraineeReviewsList", JXServerName] params:paras success:^(id json) {
        [self.tableView.mj_header endRefreshing];
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            // 将json归档
            [NSKeyedArchiver archiveRootObject:json toFile:JXStudentProgressJsonPath(account.mobile)];
            // 处理数据
            [self dealData:json];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        JXLog(@"请求失败 - %@", error);
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

/**
 *  处理数据
 *
 *  @param json 从服务器或者从本地沙盒获取的进度数据
 */
- (void)dealData:(id)json {
    NSMutableArray *progresses = [NSMutableArray array];
    // 4个科目进度
    for (int i = 1; i < 5; i ++) {
        NSString *stepName = [NSString stringWithFormat:@"step%zd", i];
        JXStudentProgress *progress = [JXStudentProgress mj_objectWithKeyValues:json[stepName]];
        progress.subjectNO = i;
        [progresses addObject:progress];
    }
    self.progresses = progresses;

    // 最近的评论所在的progress
    JXStudentProgress *lastCommentProgress = [JXStudentProgress mj_objectWithKeyValues:json[@"last"]];
    self.lastToStudentComment = lastCommentProgress.rows.lastObject;
    
    // 获得教练ID
    JXAccount *account = [JXAccountTool account];
    if (account.teacherCID == 0) {
        account.teacherCID = [json[@"cid"] integerValue];
        [JXAccountTool saveAccount:account];
    }
    // 处理完数据刷新表格
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 4) {
        BOOL expland = [self.explands[section] boolValue];
        if (expland) {
            JXStudentProgress *progress = self.progresses[section];
            return progress.rows.count;
        }
        else return 0;
    }
    else { // 点评
        return 1;
    }
    
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        JXStudentProgressDetailCell *detailCell = [JXStudentProgressDetailCell cell];
        JXStudentProgress *progress = self.progresses[indexPath.section];
        JXToStudentComment *comment = progress.rows[indexPath.row];
        detailCell.comment = comment;
        return detailCell;
    }
    
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        scoreCell.comment = self.lastToStudentComment.des;
        return scoreCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        return [JXStudentProgressDetailCell rowHeight];
    }
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        scoreCell.comment = self.lastToStudentComment.des;
        return [scoreCell rowHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < 4) {
        JXStudentClassHeaderView *header = [JXStudentClassHeaderView header];
        header.progress = self.progresses[section];
        header.headerViewClickedAction = ^{
            BOOL expland = [self.explands[section] boolValue];
            self.explands[section] = @(!expland);
            [self.tableView reloadData];
            [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:0];
        };
        return header;
    }
    else { // 点评
        JXStudentProgressHeader *commentHeader = [JXStudentProgressHeader header];
        
        commentHeader.date = self.lastToStudentComment.date;
        return commentHeader;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        self.selectedIndexPath = indexPath;
        JXStudentProgress *progress = self.progresses[indexPath.section];
        JXToStudentComment *comment = progress.rows[indexPath.row];
        self.lastToStudentComment = comment;
        [self.tableView reloadData];
        [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:0];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 4) {
        return [JXStudentClassHeaderView headerHeight];
    }
    else {
        return [JXStudentProgressCell rowHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        JXStudentProgressFooter *footer = [JXStudentProgressFooter footer];
        footer.delegate = self;
        footer.comment = self.lastToStudentComment;
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return [JXStudentProgressFooter footerHeight];
    }
    else {
        return 5;
    }
}

#pragma mark - JXStudentProgressFooterDelegate
- (void)studentProgressFooterDidClickReplyButton {
    JXReplyToTeacherController *replyToTeacherVC = [[JXReplyToTeacherController alloc] init];
    replyToTeacherVC.commentedDate = self.lastToStudentComment.date;
    [self.navigationController pushViewController:replyToTeacherVC animated:YES];
}
@end
