//
//  JXFeeDetailController.m
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXFeeDetailController.h"
#import "JXSearchParas.h"
#import <MJExtension.h>
#import "JXBaseFeeCell.h"
#import "JXOptionalFeeCell.h"
#import "JXAccommodationFeeCell.h"
#import "JXTeacherFeeCell.h"
#import "JXStudyPlaceCell.h"
#import "JXFee.h"
#import "JXFeeGroup.h"
#import "JXChooseSchoolController.h"
#import "JXAutoOrderHeaderView.h"
#import "JXAutoOrderFooterView.h"
#import "JXHttpTool.h"

@interface JXFeeDetailController () <JXAccommodationFeeCellDelegate, JXAutoOrderFooterViewDelegate>

@end

@implementation JXFeeDetailController

// 重用标示
static NSString * const JXOptionalFeeID = @"optionalFeeCell";

#pragma mark - 懒加载
- (NSArray *)feeGroups {
    if (_feeGroups == nil) {
        _feeGroups = [JXFeeGroup mj_objectArrayWithFilename:@"feeGroup.plist"];
    }
    return _feeGroups;
}

//- (void)setSearchParas:(JXSearchParas *)searchParas {
//    _searchParas = searchParas;
//    
//    self.feeGroups = searchParas.feeGroups;
//    
//}

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"学费明细";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    // 下载订单数据
    [self loadOrderData];
    
    // 注册
    // 基础费用cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JXBaseFeeCell" bundle:nil] forCellReuseIdentifier:[JXBaseFeeCell reuseIdentifier]];
    // 可选费用cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JXOptionalFeeCell" bundle:nil] forCellReuseIdentifier:[JXOptionalFeeCell reuseIdentifier]];
    // 教练
    [self.tableView registerNib:[UINib nibWithNibName:@"JXTeacherFeeCell" bundle:nil] forCellReuseIdentifier:[JXTeacherFeeCell reuseIdentifier]];
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
 *  取消
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        JXFeeGroup *feeGroup = self.feeGroups[section];
        NSArray *fees = feeGroup.fees;
        return fees.count;
    }
    // 星级
    return 1;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXFee *fee = nil;
    if (indexPath.section < 2) {
        JXFeeGroup *feeGroup = self.feeGroups[indexPath.section];
        fee = feeGroup.fees[indexPath.row];
    }
    
    if (indexPath.section == 0) { // 基础费用
        JXBaseFeeCell *baseFeeCell = [tableView dequeueReusableCellWithIdentifier:[JXBaseFeeCell reuseIdentifier] forIndexPath:indexPath];
        baseFeeCell.fee = fee;
        return baseFeeCell;
    }
    
    else if (indexPath.section == 1) { // 可选费用
        if (indexPath.row < 4) { // 可选费用
            JXOptionalFeeCell *optionalFeeCell = [tableView dequeueReusableCellWithIdentifier:[JXOptionalFeeCell reuseIdentifier] forIndexPath:indexPath];
            optionalFeeCell.fee = fee;
            optionalFeeCell.optionalButtonClickedAction = ^{
                fee.copies = !fee.copies;
                [self.tableView reloadData];
            };
            return optionalFeeCell;
        }
        
        else { // 长途食宿费
            JXAccommodationFeeCell *accommFeeCell = [JXAccommodationFeeCell cell];
            accommFeeCell.delegate = self;
            accommFeeCell.fee = fee;
            return accommFeeCell;
        }
    }
    
    else { // 选择教练
        JXTeacherFeeCell *teacherFeeCell = [tableView dequeueReusableCellWithIdentifier:[JXTeacherFeeCell reuseIdentifier] forIndexPath:indexPath];
        // 只显示copies=1的教练费用
        JXFeeGroup *teacherGroup = self.feeGroups[2];
        for (JXFee *teacherFee in teacherGroup.fees) {
            if (teacherFee.copies == 1) {
                teacherFeeCell.fee = teacherFee;
            }
        }
        
        return teacherFeeCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 3) {
        return 88;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXAutoOrderHeaderView *header = [JXAutoOrderHeaderView headerView];
    header.feeGroup = self.feeGroups[section];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) { // 最下面的确定按钮
        JXAutoOrderFooterView *footer = [JXAutoOrderFooterView footerView];
        footer.totalPay = [self calculateTotalPay];
        footer.delegate = self;
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 70;
    }
    return 0.1;
}

/**
 *  计算总价
 */
- (NSInteger)calculateTotalPay {
    NSInteger totalPay = 0;
    for (JXFeeGroup *feeGroup in self.feeGroups) {
        for (JXFee *fee in feeGroup.fees) {
            totalPay += fee.prices * fee.copies;
        }
    }
    return totalPay;
}

#pragma mark - JXAccommodationFeeCellDelegate
- (void)accommodationFeeCellDidClickedPlusButton {
    // 食宿费
    JXFeeGroup *feeGroup = self.feeGroups[1];
    JXFee *fee = feeGroup.fees[4];
    fee.copies += 1;
    [self.tableView reloadData];
}

- (void)accommodationFeeCellDidClickedMinusButton {
    // 食宿费
    JXFeeGroup *feeGroup = self.feeGroups[1];
    JXFee *fee = feeGroup.fees[4];
    if (fee.copies == 0) return;
    fee.copies -= 1;
    [self.tableView reloadData];
}

#pragma mark - JXAutoOrderFooterViewDelegate
- (void)autoOrderFooterViewDidClickedConfirmButton {
    [self dismissViewControllerAnimated:YES completion:^{
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(feeDetailDidFinishedChooseWithFeeGroups:)]) {
            [self.delegate feeDetailDidFinishedChooseWithFeeGroups:self.feeGroups];
        }
    }];
}

- (void)dealloc {
    JXLog(@"JXFeeDetailController - dealloc");
}
@end
