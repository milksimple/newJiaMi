//
//  JXSearchBar.m
//  JMXMiJia
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 mac. All rights reserved.
//
// 搜索控件内的文字大小
#define JXSearchBarContentFont [UIFont systemFontOfSize:13];

#import "JXSearchBar.h"
#import <Masonry.h>

@interface JXSearchBar()
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *searchButton;
@property (nonatomic, weak) UIButton *filterButton;
@property (nonatomic, weak) UIView *filterListView;
@end

@implementation JXSearchBar

static CGFloat const margin = 10;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JXColor(249, 249, 249);
        [self setupBgview];
    }
    return self;
}

- (void)setupBgview {
    UITextField *textField = [[UITextField alloc] init];
    textField.font = JXSearchBarContentFont;
    textField.backgroundColor = [UIColor whiteColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magnifier"]];
    left.contentMode = UIViewContentModeCenter;
    left.frame = CGRectMake(0, 0, 40, 19);
    textField.leftView = left;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:textField];
    self.textField = textField;
    textField.placeholder = @"输入查找教练";
    
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton addTarget:self action:@selector(searchButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = JXSearchBarContentFont;
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setTitleColor:JXColor(200, 200, 200) forState:UIControlStateNormal];
    searchButton.layer.borderWidth = 1;
    searchButton.layer.borderColor = JXColor(239, 239, 239).CGColor;
    [self addSubview:searchButton];
    self.searchButton = searchButton;
    
    UIButton *filterButton = [[UIButton alloc] init];
    [filterButton addTarget:self action:@selector(filterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    filterButton.titleLabel.font = JXSearchBarContentFont;
    [filterButton setTitleColor:JXColor(119, 119, 119) forState:UIControlStateNormal];
    [self addSubview:filterButton];
    self.filterButton = filterButton;
    
    // 监听textfield的输入
    [JXNotificationCenter addObserver:self selector:@selector(nameFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

/**
 *  监听textfield的输入
 */
- (void)nameFieldTextDidChange:(NSNotification *)noti {
    if (self.textField.text.length == 0) {
        // 通知代理，搜索框的内容为空
        if ([self.delegate respondsToSelector:@selector(searchBarDidClearedSearchText)]) {
            [self.delegate searchBarDidClearedSearchText];
        }
    }
}

/**
 *  搜索按钮被点击了
 */
- (void)searchButtonDidClicked {
    // 退出键盘
    [self endEditing:YES];
    // 获得textfield中的内容
    NSString *searchContent = self.textField.text;
    if (searchContent.length != 0) { // 内容不为空
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(searchBarButtonDidClickedWithSearchContent:)]) {
            [self.delegate searchBarButtonDidClickedWithSearchContent:searchContent];
        }
    }
}

/**
 *  筛选按钮被点击了
 */
- (void)filterButtonClicked:(JXRightImageButton *)filterButton {
    filterButton.selected = !filterButton.isSelected;
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(searchBarDidClickedFilterButton)]) {
        [self.delegate searchBarDidClickedFilterButton];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf);
    
    MASAttachKeys(self, self.textField, self.searchButton);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.width).multipliedBy(0.5);
        make.left.offset(margin);
        make.top.offset(margin);
        make.bottom.offset(-margin);
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(self.searchButton.left).offset(-margin);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.textField);
        make.left.equalTo(self.textField.right).offset(margin);
    }];
    
    [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchButton.right).offset(margin);
        make.width.equalTo(self.searchButton.width);
        make.top.bottom.equalTo(self.searchButton);
        make.right.offset(-margin);
    }];
}

+ (CGFloat)height {
    return 54;
}

- (void)quitKeyboard {
    [self.textField resignFirstResponder];
}

//#pragma mark - UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"filterTableview";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//    }
//    switch (indexPath.row) {
//        case 0:
//            cell.textLabel.text = @"星级";
//            cell.detailTextLabel.text = ;
//            break;
//            
//        case 1:
//            cell.textLabel.text = @"学校";
//            break;
//            
//        case 2:
//            cell.textLabel.text = @"性别";
//            break;
//            
//        default:
//            break;
//    }
//    return cell;
//}
//
//#pragma mark - UITableViewDelegate

@end
