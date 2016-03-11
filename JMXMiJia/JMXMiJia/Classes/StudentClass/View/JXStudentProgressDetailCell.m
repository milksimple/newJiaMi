//
//  JXStudentProgressDetailCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgressDetailCell.h"
#import "JXStudentProgress.h"

@interface JXStudentProgressDetailCell()
@property (weak, nonatomic) IBOutlet UIButton *bgButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
/** 日期 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** 理论知识 */
@property (weak, nonatomic) IBOutlet UILabel *theoryLabel;
/** 实际操作 */
@property (weak, nonatomic) IBOutlet UILabel *practiceLabel;
/** 上课状态:1上课，2请假，3旷课，4早退 */
@property (weak, nonatomic) IBOutlet UILabel *classStatusLabel;

@end

@implementation JXStudentProgressDetailCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.containerView.backgroundColor = selected ? [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.3] : [UIColor whiteColor];
}

- (void)setComment:(JXToStudentComment *)comment {
    _comment = comment;
    
    self.dateLabel.text = comment.date;
    self.theoryLabel.text = [NSString stringWithFormat:@"%zd", comment.starsA];
    self.practiceLabel.text = [NSString stringWithFormat:@"%zd", comment.starsB];
    switch (comment.state) {
        case 1:
            self.classStatusLabel.text = @"上课";
            break;
            
        case 2:
            self.classStatusLabel.text = @"请假";
            break;
            
        case 3:
            self.classStatusLabel.text = @"旷课";
            break;
            
        case 4:
            self.classStatusLabel.text = @"早退";
            break;
            
        default:
            self.classStatusLabel.text = nil;
            break;
    }
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressDetailCell class]) owner:nil options:nil].lastObject;
}

+ (NSString *)reuseIdentifier {
    return @"studentProgressDetailCell";
}


+ (CGFloat)rowHeight {
    return 45;
}



@end
