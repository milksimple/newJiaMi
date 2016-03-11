//
//  JXDetailFooterView.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXDetailFooterView.h"

@interface JXDetailFooterView()
@property (weak, nonatomic) IBOutlet UIButton *phoneCallButton;

@end

@implementation JXDetailFooterView

+ (instancetype)footerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXDetailFooterView" owner:nil options:nil].lastObject;
}

+ (CGFloat)footerHeight {
    return 110;
}

- (void)setMobile:(NSString *)mobile {
    _mobile = mobile;
    
    [self.phoneCallButton setTitle:@"拨打报名电话:18987460601" forState:UIControlStateNormal];
}

- (IBAction)signup:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detailFooterViewDidClickedSignupButton)]) {
        [self.delegate detailFooterViewDidClickedSignupButton];
    }
}

- (IBAction)call:(UIButton *)sender {
   
    if ([self.delegate respondsToSelector:@selector(detailFooterViewDidClickedCallButton)]) {
        [self.delegate detailFooterViewDidClickedCallButton];
    }
}

@end
