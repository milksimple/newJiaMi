//
//  JXHelpViewController.m
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXHelpViewController.h"
#import "JXHelpGroup.h"
#import "JXHelpItem.h"
#import <MJExtension.h>
#import "JXHelpTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface JXHelpViewController ()
/** 帮助模型 */
@property (nonatomic, strong) NSMutableArray *helpGroups;

@end

@implementation JXHelpViewController
#pragma mark - 懒加载
- (NSMutableArray *)helpGroups {
    if (_helpGroups == nil) {
        _helpGroups = [JXHelpGroup mj_objectArrayWithFilename:@"help.plist"];
    }
    return _helpGroups;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"帮助";
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JXHelpTableViewCell class]) bundle:nil] forCellReuseIdentifier:[JXHelpTableViewCell reuseIdentifier]];

}

#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.helpGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JXHelpGroup *helpGroup = self.helpGroups[section];
    return helpGroup.helpItems.count;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXHelpTableViewCell *helpCell = [tableView dequeueReusableCellWithIdentifier:[JXHelpTableViewCell reuseIdentifier] forIndexPath:indexPath];
    JXHelpGroup *helpGroup = self.helpGroups[indexPath.section];
    JXHelpItem *helpItem = helpGroup.helpItems[indexPath.row];
    helpCell.helpItem = helpItem;
    helpCell.rowNO = indexPath.row;
    
    return helpCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    JXHelpGroup *helpGroup = self.helpGroups[section];
    return helpGroup.groupName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXHelpTableViewCell *helpCell = [JXHelpTableViewCell cell];
    JXHelpGroup *helpGroup = self.helpGroups[indexPath.section];
    JXHelpItem *helpItem = helpGroup.helpItems[indexPath.row];
    helpCell.helpItem = helpItem;
    
    return [helpCell rowHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
