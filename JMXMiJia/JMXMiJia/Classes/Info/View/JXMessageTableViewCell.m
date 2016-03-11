//
//  JXMessageTableViewCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXMessageTableViewCell.h"
#import "UIView+JXExtension.h"
#import "JXPushInfo.h"

@interface JXMessageTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *accessoryButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *corverButton;

@end

@implementation JXMessageTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPushInfo:(JXPushInfo *)pushInfo {
    _pushInfo = pushInfo;
    
    self.titleLabel.text = pushInfo.title;
    
    NSMutableString *cont = pushInfo.des.mutableCopy;
    self.contentLabel.text = [cont stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (IBAction)corverButtonClicked:(UIButton *)corverButton {
    // 调用外面定义的block
    if (self.corverButtonClickedAction) {
        self.corverButtonClickedAction();
    }
}

- (void)setExpland:(BOOL)expland {
    _expland = expland;
    
    self.accessoryButton.selected = expland;
    self.contentLabel.hidden = !expland;
}

- (CGFloat)rowHeight {
    [self layoutIfNeeded];
    
    NSInteger rowHeight = 10 + self.titleLabel.jx_height + 10 + self.contentLabel.jx_height + 10;
    return rowHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.jx_y = 10;
    self.contentView.jx_height = self.jx_height - self.contentView.jx_y;
    self.contentView.jx_x = 10;
    self.contentView.jx_width = self.jx_width - (2 * self.contentView.jx_x);
}

@end
