//
//  JXStudentScoreCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentScoreCell.h"
#import "UIView+JXExtension.h"

@interface JXStudentScoreCell()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@end

@implementation JXStudentScoreCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentScoreCell class]) owner:nil options:nil].lastObject;
}

- (CGFloat)rowHeight {
    [self layoutIfNeeded];
    return self.commentLabel.jx_y + self.commentLabel.jx_height + 10;
}

- (void)setComment:(NSString *)comment {
    _comment = comment;
    
    if (comment.length == 0) {
        self.commentLabel.text = @"暂无对您的点评信息";
    }
    else {
        NSMutableString *mutableStr = comment.mutableCopy;
        // utf8转
        self.commentLabel.text = [mutableStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

@end
