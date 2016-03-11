//
//  JXStudentProgressFooter.m
//  JMXMiJia
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgressFooter.h"
#import "JXToStudentComment.h"

@interface JXStudentProgressFooter()
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation JXStudentProgressFooter

+ (instancetype)footer {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressFooter class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)footerHeight {
    return 70;
}

- (IBAction)replyButtonClicked:(UIButton *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(studentProgressFooterDidClickReplyButton)]) {
        [self.delegate studentProgressFooterDidClickReplyButton];
    }
}

- (void)setComment:(JXToStudentComment *)comment {
    _comment = comment;
    
    // 如果为已回评，按钮显示为已回评，且不可点击
    if (comment == nil || comment.replied) {
        [self.commentButton setTitle:@"已回评" forState:UIControlStateNormal];
        self.commentButton.backgroundColor = [UIColor lightGrayColor];
        self.commentButton.enabled = NO;
    }
    else if (!comment.replied) {
        [self.commentButton setTitle:@"点击回评老师" forState:UIControlStateNormal];
        self.commentButton.backgroundColor = JXColor(244, 128, 32);
        self.commentButton.enabled = YES;
    }
}

@end
