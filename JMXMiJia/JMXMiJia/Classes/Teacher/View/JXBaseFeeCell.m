//
//  JXBaseFeeCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXBaseFeeCell.h"

@interface JXBaseFeeCell()
@property (weak, nonatomic) IBOutlet UILabel *feeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;

@end

@implementation JXBaseFeeCell

static NSString * const JXBaseFeeID = @"baseFeeCell";

+ (instancetype)baseFeeCell {
    return [[NSBundle mainBundle] loadNibNamed:@"JXBaseFeeCell" owner:nil options:nil].lastObject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return JXBaseFeeID;
}

- (void)setFee:(JXFee *)fee {
    _fee = fee;
    
    self.feeNameLabel.text = fee.des;
    self.feeLabel.text = [NSString stringWithFormat:@"¥%zd", fee.prices];
}
@end
