//
//  JXMessageHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXMessageHeaderView.h"
#import <Masonry.h>

@interface JXMessageHeaderView()

/** 资讯图标 */
@property (nonatomic, weak) UIButton *iconButton;
/** 资讯内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 箭头 */
@property (nonatomic, weak) UIButton *accessoryButton;
/** 覆盖整个view的button */
@property (nonatomic, weak) UIButton *corverButton;
@end

@implementation JXMessageHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIButton *iconButton = [[UIButton alloc] init];
#warning 因normal图片尺寸不对
    [iconButton setImage:[UIImage imageNamed:@"msg_icon"] forState:UIControlStateNormal];
    [iconButton setImage:[UIImage imageNamed:@"msg_icon_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:iconButton];
    self.iconButton = iconButton;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.adjustsFontSizeToFitWidth = YES;
    contentLabel.textColor = JXColor(144, 144, 144);
#warning 测试数据
    contentLabel.text = @"同学你好，科目二你挂了";
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIButton *accessoryButton = [[UIButton alloc] init];
    [accessoryButton setImage:[UIImage imageNamed:@"accessory_down"] forState:UIControlStateNormal];
    [accessoryButton setImage:[UIImage imageNamed:@"accessory_up"] forState:UIControlStateSelected];
    [self.contentView addSubview:accessoryButton];
    self.accessoryButton = accessoryButton;
    
    UIButton *corverButton = [[UIButton alloc] init];
    corverButton.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:corverButton];
    // 监听按钮点击
    [corverButton addTarget:self action:@selector(corverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.corverButton = corverButton;
    
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.left.offset(10);
        make.centerY.equalTo(self.contentView.centerY);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(iconButton.right).offset(10);
    }];
    
    [accessoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.equalTo(accessoryButton.height);
        make.right.offset(-10);
        make.left.equalTo(contentLabel.right).offset(10);
    }];
    
    [corverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)corverButtonClicked {
    JXLog(@"corverButtonClicked");
    // 通知代理
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.jx_y = 10;
    self.contentView.jx_height = self.jx_height - self.contentView.jx_y;
}



@end
