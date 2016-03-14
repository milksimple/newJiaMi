//
//  JXRecommendPopView.m
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXRecommendPopView.h"
#import "MBProgressHUD+MJ.h"
#import "JXAccountTool.h"

@interface JXRecommendPopView()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
/** 二维码 */
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeView;

@end

@implementation JXRecommendPopView

+ (instancetype)recommendPopView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXRecommendPopView class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(qrCodeViewLongPressed:)];
    [self.qrCodeView addGestureRecognizer:recognizer];
    
    JXAccount *account = [JXAccountTool account];
    self.userNameLabel.text = account.name;
    self.mobileLabel.text = account.mobile;
}

- (void)qrCodeViewLongPressed:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan){
        return;//什么操作都不做，直接跳出此方法
    }
    else {
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(recommendPopViewDidLongPressed)]) {
            [self.delegate recommendPopViewDidLongPressed];
        }
        
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
