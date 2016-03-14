//
//  JXTeacherDetailController.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

// 存储教师详情的json数据 沙盒路径
#define JXTeacherDetailJsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"teacherDetailJson.archive"]

#import "JXTeacherDetailController.h"
#import "JXTeacherDetailCell.h"
#import "JXTeacher.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "JXDetailHeaderView.h"
#import "JXDetailFooterView.h"
#import "JXFeeDetailController.h"
#import "JXNavigationController.h"
#import "JXSearchParas.h"
#import "JXFeeGroup.h"
#import "JXFee.h"
#import <MJExtension.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import "JXFeeGroupTool.h"
#import <SVProgressHUD.h>
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#import "JXTeacherMovieCell.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>

@interface JXTeacherDetailController () <JXTeacherDetailCellDelegate, JXFeeDetailControllerDelegate, JXDetailFooterViewDelegate>
@property (nonatomic, strong) MPMoviePlayerController *playerController;

@property (nonatomic, weak) JXTeacherMovieCell *movieCell;
@end

@implementation JXTeacherDetailController

#pragma mark - 懒加载
- (NSArray *)feeGroups {
    if (_feeGroups == nil) {
        _feeGroups = [JXFeeGroup mj_objectArrayWithFilename:@"feeGroup.plist"];
        
        JXFeeGroup *starGroup = _feeGroups[2];
        for (int i = 0; i < starGroup.fees.count; i ++) {
            if (self.teacher.star == starGroup.fees.count - 1 - i) {
                JXFee *starFee = starGroup.fees[i];
                starFee.copies = 1;
            }
        }
    }
    return _feeGroups;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"教练介绍";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"JXTeacherDetailCell" bundle:nil] forCellReuseIdentifier:@"teacherDetail"];
    // 获取订单数据
    [self loadOrderData];
    
    // 从沙盒取出之前的教师详情json数据
    NSDictionary *json = [NSKeyedUnarchiver unarchiveObjectWithFile:JXTeacherDetailJsonPath];
    if (json) { // 之前有数据
        [self dealData:json];
    }
    
    [self loadTeacherData];
    
    [self.playerController prepareToPlay];
    
    // 监听屏幕旋转
    [JXNotificationCenter addObserver:self selector:@selector(deviceOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealData:(NSDictionary *)json {
    BOOL success = json[@"success"];
    if (success) {
        JXTeacher *teacher = [JXTeacher mj_objectWithKeyValues:json];
        // 坑爹的代码
        self.teacher.count = teacher.count;
        self.teacher.des = teacher.des;
        self.teacher.mobile = teacher.mobile;
        self.teacher.schoolID = teacher.schoolID;
        self.teacher.credentials = teacher.credentials;
        self.teacher.videos = teacher.videos;
        
        [self.tableView reloadData];
    }
}

/**
 *  监听屏幕旋转
 */
- (void)deviceOrientation {
    // 获得屏幕的真实方向
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIDeviceOrientation orientation = [delegate realDeviceOrientation];
    
    // 控制播放器 进入全屏 或 退出全屏
    MPMoviePlayerController *playerController = self.movieCell.playerController;
    if (playerController.playbackState == MPMoviePlaybackStatePlaying) {
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            [playerController setFullscreen:YES animated:YES];
        }
        else {
            [playerController setFullscreen:NO animated:YES];
        }
    }
    
}

/**
 *  下载订单数据
 */
- (void)loadOrderData {
    [JXHttpTool post:[NSString stringWithFormat:@"%@/TuitionConstitute", JXServerName] params:nil success:^(id json) {
        BOOL success = json[@"success"];
        if (success) { // 请求成功
            // 基础费用组
            NSArray *remoteBaseFees = [JXFee mj_objectArrayWithKeyValuesArray:json[@"base"]];
            NSArray *localBaseFees = [self.feeGroups[0] fees];
            // 将本地数据用远程数代替
            for (int i = 0; i < localBaseFees.count; i ++) {
                JXFee *remoteFee = remoteBaseFees[i];
                JXFee *localFee = localBaseFees[i];
                localFee.prices = remoteFee.prices;
                localFee.itemNum = remoteFee.itemNum;
                localFee.des = remoteFee.des;
            }
            
            // 可选费用组
            NSArray *remoteAidFees = [JXFee mj_objectArrayWithKeyValuesArray:json[@"aid"]];
            NSArray *localAidFees = [self.feeGroups[1] fees];
            // 将本地数据用远程数代替
            for (int i = 0; i < localAidFees.count; i ++) {
                JXFee *remoteFee = remoteAidFees[i];
                JXFee *localFee = localAidFees[i];
                localFee.prices = remoteFee.prices;
                localFee.itemNum = remoteFee.itemNum;
                localFee.des = remoteFee.des;
            }
            
            // 教练星级费用组
            NSArray *remoteStarFees = [JXFee mj_objectArrayWithKeyValuesArray:json[@"stars"]];
            NSArray *localStarFees = [self.feeGroups[2] fees];
            // 将本地数据用远程数代替
            for (int i = 0; i < localStarFees.count; i ++) {
                JXFee *remoteFee = remoteStarFees[5 - i]; // 因之前自己设计的plist模型和服务器模型有差异，故以本地plist为准
                JXFee *localFee = localStarFees[i];
                localFee.prices = remoteFee.prices;
                localFee.itemNum = remoteFee.itemNum;
                localFee.des = remoteFee.des;
            }
            
            // 刷新表格
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  获取教师数据
 */
- (void)loadTeacherData {
    JXAccount *account = [JXAccountTool account];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"uid"] = self.teacher.uid;
    [JXHttpTool post:[NSString stringWithFormat:@"%@/CoachInfo", JXServerName] params:paras success:^(id json) {
        [NSKeyedArchiver archiveRootObject:json toFile:JXTeacherDetailJsonPath];
        JXLog(@"%@", json);
        // 处理数据
        [self dealData:json];
        
    } failure:^(NSError *error) {
        JXLog(@"请求失败 - %@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        JXTeacherDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacherDetail" forIndexPath:indexPath];
        cell.teacher = self.teacher;
        cell.feeGroups = self.feeGroups;
        cell.delegate = self;
        return cell;
    }
    else {
        JXTeacherMovieCell *movieCell = [[JXTeacherMovieCell alloc] init];
        movieCell.teacher = self.teacher;
        self.movieCell = movieCell;
        return movieCell;
    }
    
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"teacherDetail" cacheByIndexPath:indexPath configuration:^(JXTeacherDetailCell *cell) {
            cell.teacher = self.teacher;
        }];
    }
    else {
        return [JXTeacherMovieCell rowHeight];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXDetailHeaderView *header = [JXDetailHeaderView headerView];
    header.teacher = self.teacher;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXDetailHeaderView headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    JXDetailFooterView *footer = [JXDetailFooterView footerView];
    footer.delegate = self;
    footer.mobile = self.teacher.mobile;
    
    return footer;
}
/*
 
 else {
 
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [JXDetailFooterView footerHeight];
}

#pragma mark - JXTeacherDetailCellDelegate
- (void)teacherDetailCellDidClickedFeeDetailButton {
    JXFeeDetailController *feeDetailVC = [[JXFeeDetailController alloc] init];
    feeDetailVC.feeGroups = self.feeGroups;
    
    feeDetailVC.delegate = self;
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:feeDetailVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - JXFeeDetailControllerDelegate
- (void)feeDetailDidFinishedChooseWithFeeGroups:(NSArray *)feeGroups {
    self.feeGroups = feeGroups;
    
    [self.tableView reloadData];
}

#pragma mark - JXDetailFooterViewDelegate
/**
 *  点击了报名按钮
 */
- (void)detailFooterViewDidClickedSignupButton {
    // 报名按钮被点击，发送数据给服务器
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"cid"] = self.teacher.uid;
    paras[@"aidItem"] = [JXFeeGroupTool aidItemWithFeeGroups:self.feeGroups];

    [MBProgressHUD showMessage:@"正在报名" toView:self.view];
    
    [JXHttpTool post:[NSString stringWithFormat:@"%@/Reservation", JXServerName] params:paras success:^(id json) {
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view];
                    [MBProgressHUD showSuccess:json[@"msg"] toView:self.view];
                });
                
            });
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view];
                    [MBProgressHUD showError:json[@"msg"] toView:self.view];
                });
                
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:@"网络请求超时,请稍后再试!" toView:self.view];
            });
            
        });
        JXLog(@"请求失败 - %@", error);
    }];
}

/**
 *  点击了拨打电话按钮
 */
- (void)detailFooterViewDidClickedCallButton {
    // 拨打电话按钮被点击
    NSString *mobile = self.teacher.mobile;
    if (mobile.length) {
        NSString *str= @"tel:18987460601";
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}

@end
