//
//  JXChooseSexController.m
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChooseSexController.h"

@interface JXChooseSexController ()

@end

@implementation JXChooseSexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择性别";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return JXSexs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"chooseSexCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.tintColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = cell.textLabel.font;
    }
    cell.textLabel.text = JXSexs[indexPath.row];
    
    // 默认选中
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == self.defaultSex + 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    selectedCell.tintColor = [UIColor lightGrayColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selectedCell.selected = NO;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    // 通知代理选择的项目
    if ([self.delegate respondsToSelector:@selector(chooseSexDidFinished:)]) {
        JXSex sex = (JXSex)(indexPath.row - 1);
        [self.delegate chooseSexDidFinished:sex];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *deselectedCell = [tableView cellForRowAtIndexPath:indexPath];
    deselectedCell.accessoryType = UITableViewCellAccessoryNone;
}
@end
