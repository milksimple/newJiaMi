//
//  JXOptionalFeeCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXOptionalFeeCell.h"

@interface JXOptionalFeeCell()
@property (weak, nonatomic) IBOutlet UILabel *feeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionalButton;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation JXOptionalFeeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    // Configure the view for the selected state
}

- (void)setSelected:(BOOL)selected {
    
}

+ (NSString *)reuseIdentifier {
    return @"optionalFeeCell";
}

- (void)setFee:(JXFee *)fee {
    _fee = fee;
    
    self.feeNameLabel.text = fee.des;
    self.feeLabel.text = [NSString stringWithFormat:@"¥%zd", fee.prices];
    self.optionalButton.selected = fee.copies;
    
    if (fee.caption.length == 0) {
        self.captionLabel.hidden = YES;
    }
    else {
        self.captionLabel.hidden = NO;
        self.captionLabel.text = fee.caption;
    }
}

- (IBAction)optionalButtonClicked:(UIButton *)optionalButton {
    // 执行外面定义好的block操作
    if (self.optionalButtonClickedAction) {
        self.optionalButtonClickedAction();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end
