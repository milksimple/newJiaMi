//
//  JXStarView.m
//  JMXMiJia
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStarView.h"

@interface JXStarView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;


@end

@implementation JXStarView

+ (instancetype)starView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStarView class]) owner:nil options:nil].lastObject;
}

- (IBAction)starClicked:(UIButton *)star {
    // 之前的高亮,之后的normal
    NSInteger tag = star.tag;
    for (int i = 1; i <= 5; i ++) {
        UIButton *star = (UIButton *)[self viewWithTag:i];
        if (i <= tag) {
            [star setSelected:YES];
        }
        else {
            [star setSelected:NO];
        }
    }
    // 分数
    _score = tag;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

@end
