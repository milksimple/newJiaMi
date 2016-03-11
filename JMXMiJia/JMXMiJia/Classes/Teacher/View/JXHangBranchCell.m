//
//  JXHangBranchCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXHangBranchCell.h"

@interface JXHangBranchCell()
@property (weak, nonatomic) IBOutlet UILabel *feeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;

@end

@implementation JXHangBranchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
