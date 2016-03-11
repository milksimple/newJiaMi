//
//  JXStudentProgressCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgressCell.h"

@implementation JXStudentProgressCell

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressCell class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight {
    return 80;
}

@end
