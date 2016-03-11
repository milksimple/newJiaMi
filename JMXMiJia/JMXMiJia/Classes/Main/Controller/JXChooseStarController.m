//
//  JXChooseStarController.m
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChooseStarController.h"

@interface JXChooseStarController ()

//@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation JXChooseStarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择星级";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return JXStars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"filterStarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.tintColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = cell.textLabel.font;
    }
    cell.textLabel.text = JXStars[indexPath.row];
    
    // 默认选中
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == self.defaultStar + 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selectedCell.selected = NO;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    // 通知代理选择的项目
    if ([self.delegate respondsToSelector:@selector(chooseStarDidFinished:)]) {
        NSInteger star = indexPath.row - 1;
        [self.delegate chooseStarDidFinished:star];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *deselectedCell = [tableView cellForRowAtIndexPath:indexPath];
    deselectedCell.accessoryType = UITableViewCellAccessoryNone;
}
@end
