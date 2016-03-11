//
//  JXAccommodationFeeCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXAccommodationFeeCell.h"

@interface JXAccommodationFeeCell()
@property (weak, nonatomic) IBOutlet UILabel *feeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *copiesLabel;

@end

@implementation JXAccommodationFeeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"accommodationFeeCell";
}

- (void)setFee:(JXFee *)fee {
    _fee = fee;
    
    self.feeNameLabel.text = fee.des;
    self.feeLabel.text = [NSString stringWithFormat:@"¥%zd/天", fee.prices];
    self.copiesLabel.text = [NSString stringWithFormat:@"%zd", fee.copies];
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"JXAccommodationFeeCell" owner:nil options:nil].lastObject;
}

- (IBAction)plus {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(accommodationFeeCellDidClickedPlusButton)]) {
        [self.delegate accommodationFeeCellDidClickedPlusButton];
    }
}

- (IBAction)minus {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(accommodationFeeCellDidClickedMinusButton)]) {
        [self.delegate accommodationFeeCellDidClickedMinusButton];
    }
}

@end
