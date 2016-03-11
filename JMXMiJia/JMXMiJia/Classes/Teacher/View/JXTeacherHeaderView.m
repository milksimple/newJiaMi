//
//  JXTeacherHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherHeaderView.h"

@interface JXTeacherHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *autoOrderButton;

@end

@implementation JXTeacherHeaderView

- (IBAction)order:(UIButton *)sender {
    if (self.orderButtonClickedAction) {
        self.orderButtonClickedAction();
    }
}

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXTeacherHeaderView" owner:nil options:nil].firstObject;
}

+ (CGFloat)headerHeight {
    return 54;
}

- (void)setTotalPay:(NSInteger)totalPay {
    _totalPay = totalPay;
    
    NSString *title = [NSString stringWithFormat:@"自主订单:¥%zd", totalPay];
    if (totalPay == 0) {
        title = @"自主订单";
    }
    [self.autoOrderButton setTitle:title forState:UIControlStateNormal];
    
}
@end
