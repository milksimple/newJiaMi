//
//  JXStudentClassHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#define JXCompleteColor JXColor(131,215,112)
#define JXStudingColor JXColor(250,148,55)
#define JXNotStartColor JXColor(204,204,204)

#import "JXStudentClassHeaderView.h"
#import "JXStudentProgress.h"

@interface JXStudentClassHeaderView()
/** 圆点 */
@property (weak, nonatomic) IBOutlet UIView *pointView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
/** 阶段名 */
@property (weak, nonatomic) IBOutlet UILabel *phraseNameLabel;
/** 未开始/完成 此阶段 */
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
/** 结束时间label */
@property (weak, nonatomic) IBOutlet UILabel *finishDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation JXStudentClassHeaderView

- (void)awakeFromNib {
//    self.backgroundColor = JXRandomColor;
}

+ (instancetype)header {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentClassHeaderView class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)headerHeight {
    return 50;
}

- (void)setProgress:(JXStudentProgress *)progress {
    _progress = progress;
    
    switch (progress.subjectNO) {
        case 1:
            self.phraseNameLabel.text = @"科目一";
            break;
            
        case 2:
            self.phraseNameLabel.text = @"科目二";
            break;
            
        case 3:
            self.phraseNameLabel.text = @"科目三";
            break;
            
        case 4:
            self.phraseNameLabel.text = @"科目四";
            break;
            
        default:
            break;
    }
    
    switch (progress.state) {
        case 0:
            self.completeLabel.text = @"合格";
            if ([progress.endDate isEqualToString:@"null"]) {
                self.finishDateLabel.text = nil;
            }
            else {
                self.finishDateLabel.text = [NSString stringWithFormat:@"%@ 结束",progress.endDate];
            }
            // 修改字体颜色
            self.phraseNameLabel.textColor = self.completeLabel.textColor = self.pointView.backgroundColor = JXCompleteColor;
            break;
            
        case 1:
            self.completeLabel.text = @"在学";
            self.finishDateLabel.text = nil;
            // 修改字体颜色
            self.phraseNameLabel.textColor = self.completeLabel.textColor = self.pointView.backgroundColor = JXStudingColor;
            break;
            
        case 2:
            self.completeLabel.text = @"未开始";
            self.finishDateLabel.text = nil;
            // 修改字体颜色
            self.phraseNameLabel.textColor = self.completeLabel.textColor = self.pointView.backgroundColor = JXNotStartColor;
            break;
            
        default:
            break;
    }
}

// 覆盖按钮被点击
- (IBAction)corverButtonClicked:(id)sender {
    if (self.headerViewClickedAction) {
        self.headerViewClickedAction();
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.jx_y = 10;
    self.contentView.jx_height = self.jx_height - (self.contentView.jx_y);
    self.bgImageView.jx_height = self.contentView.jx_height;
}

@end
