//
//  JXTeacherFeeCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherFeeCell.h"

@interface JXTeacherFeeCell()
@property (weak, nonatomic) IBOutlet UILabel *feeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionalButton;

@end

@implementation JXTeacherFeeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setFee:(JXFee *)fee {
    _fee = fee;
    
    self.feeNameLabel.text = fee.des;
    self.feeLabel.text = [NSString stringWithFormat:@"¥%zd", fee.prices];
    self.optionalButton.selected = fee.copies;
}

/**
 *  选择按钮被点击了
 */
- (IBAction)optionalButtonClicked:(UIButton *)optionalButton {
    // 调用外部定义好的block
    if (self.optionalButtonClickedAction) {
        self.optionalButtonClickedAction();
    }
}

+ (NSString *)reuseIdentifier {
    return @"teacherFeeCell";
}

@end
