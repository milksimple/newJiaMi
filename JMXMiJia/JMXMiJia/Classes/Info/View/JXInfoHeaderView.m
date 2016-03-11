//
//  JXInfoHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXInfoHeaderView.h"
#import <Masonry.h>
#import "UIView+JXExtension.h"

@interface JXInfoHeaderView()
/** 资讯图标 */
@property (nonatomic, weak) UIButton *iconButton;
/** 资讯内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
@end

@implementation JXInfoHeaderView

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
    [iconButton setImage:[UIImage imageNamed:@"info_icon_selected"] forState:UIControlStateNormal];
    [iconButton setImage:[UIImage imageNamed:@"info_icon_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:iconButton];
    self.iconButton = iconButton;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.adjustsFontSizeToFitWidth = YES;
    contentLabel.textColor = JXColor(144, 144, 144);
#warning 测试数据
    contentLabel.text = @"您刚刚报名了 黄志刚 的课程";
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.textColor = JXColor(144, 144, 144);
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.text = @"2016-02-22";
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.left.offset(10);
        make.centerY.equalTo(self.contentView.centerY);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(iconButton.right).offset(10);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.equalTo(@50);
        make.right.offset(-10);
        make.left.equalTo(contentLabel.right).offset(10);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.jx_y = 10;
    self.contentView.jx_height = self.jx_height - self.contentView.jx_y;
    self.contentView.jx_x = 10;
    self.contentView.jx_width = self.jx_width - (2 * self.contentView.jx_x);
}

@end
