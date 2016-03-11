//
//  JXTeacherDetailCell.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherDetailCell.h"
#import "NSString+Extension.h"
#import "JXTeacher.h"
#import "JXFeeGroupTool.h"

@interface JXTeacherDetailCell()
//@property (nonatomic, weak) UILabel *qualifiLabel;

//@property (nonatomic, weak) UILabel *qualifiContentLabel;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab4;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab5;
//@property (weak, nonatomic) IBOutlet UIView *sepView;
//@property (weak, nonatomic) IBOutlet UIView *circle1;
//@property (weak, nonatomic) IBOutlet UIView *circle2;
//@property (weak, nonatomic) IBOutlet UIView *circle3;
//@property (weak, nonatomic) IBOutlet UIView *circle5;
//@property (weak, nonatomic) IBOutlet UIView *circle6;

@property (weak, nonatomic) IBOutlet UILabel *qualifiLabel;
@property (weak, nonatomic) IBOutlet UILabel *signupCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@end

@implementation JXTeacherDetailCell

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
    self.qualifiLabel.text = teacher.year;
    self.signupCountLabel.text = [NSString stringWithFormat:@"%zd人", teacher.count];
    
    NSMutableString *mutableDes = teacher.des.mutableCopy;
    NSString *des = [mutableDes stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (des.length != 0) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:des];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        [paraStyle setLineSpacing:5];
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, attributedStr.length)];
        self.introduceLabel.attributedText = attributedStr;
    }
    else {
        self.introduceLabel.attributedText = [[NSAttributedString alloc] initWithString:@"暂无介绍"];
    }
    
}

- (void)setFeeGroups:(NSArray *)feeGroups {
    _feeGroups = feeGroups;
    
    self.feeLabel.text = [NSString stringWithFormat:@"￥%zd", [JXFeeGroupTool totalPayWithFeeGroups:feeGroups]];
}

/**
 *  学费明细按钮被点击了
 */
- (IBAction)feeDetailButtonClicked {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(teacherDetailCellDidClickedFeeDetailButton)]) {
        [self.delegate teacherDetailCellDidClickedFeeDetailButton];
    }
}

@end
