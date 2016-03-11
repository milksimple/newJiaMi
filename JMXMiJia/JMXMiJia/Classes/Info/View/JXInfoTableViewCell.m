//
//  JXInfoTableViewCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXInfoTableViewCell.h"
#import "UIView+JXExtension.h"

@implementation JXInfoTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.contentView.jx_y = 10;
    self.contentView.jx_height = self.jx_height - self.contentView.jx_y;
    self.contentView.jx_x = 10;
    self.contentView.jx_width = self.jx_width - (2 * self.contentView.jx_x);
}
@end
