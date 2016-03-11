//
//  JXAutoOrderFooterView.m
//  JMXMiJia
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXAutoOrderFooterView.h"

@interface JXAutoOrderFooterView()
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation JXAutoOrderFooterView

+ (instancetype)footerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXAutoOrderFooterView" owner:nil options:nil].lastObject;
}

- (void)setTotalPay:(NSInteger)totalPay {
    _totalPay = totalPay;
    
    [self.confirmButton setTitle:[NSString stringWithFormat:@"确定选择总计:¥%zd", totalPay] forState:UIControlStateNormal];
}

- (IBAction)confirm:(UIButton *)confirmButton {
    if ([self.delegate respondsToSelector:@selector(autoOrderFooterViewDidClickedConfirmButton)]) {
        [self.delegate autoOrderFooterViewDidClickedConfirmButton];
    }
}

@end
