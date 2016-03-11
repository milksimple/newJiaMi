//
//  JXAutoOrderHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXAutoOrderHeaderView.h"
#import "JXFeeGroup.h"

@interface JXAutoOrderHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;

@end

@implementation JXAutoOrderHeaderView

- (void)setFeeGroup:(JXFeeGroup *)feeGroup {
    _feeGroup = feeGroup;
    
    self.headerTitleLabel.text = feeGroup.feeType;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.headerTitleLabel.text = title;
}

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXAutoOrderHeaderView" owner:nil options:nil].lastObject;
}
@end
