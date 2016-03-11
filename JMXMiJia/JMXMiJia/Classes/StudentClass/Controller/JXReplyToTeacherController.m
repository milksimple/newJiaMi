//
//  JXReplyToTeacherController.m
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXReplyToTeacherController.h"
#import "UIView+JXExtension.h"
#import "JXTextView.h"
#import "JXStarView.h"
#import <SVProgressHUD.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import "JXChooseNumberView.h"

@interface JXReplyToTeacherController ()

@property (nonatomic, weak) JXTextView *replyTextView;

@property (nonatomic, weak) JXStarView *feeStarView;

@property (nonatomic, weak) JXStarView *introductView;

@property (nonatomic, weak) JXChooseNumberView *redBagView;
@end

@implementation JXReplyToTeacherController
// 各控件的垂直间距
static CGFloat margin = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"回评教练";
    self.view.backgroundColor = JXGlobalBgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTextView];
    [self setupStarView];
    [self setupRedBagView];
    [self setupConfirmButton];
}

- (void)setupTextView {
    JXTextView *replyTextView = [[JXTextView alloc] init];
    CGFloat replyW = JXScreenW * 0.9;
    CGFloat replyH = replyW * 0.4;
    CGFloat replyX = (JXScreenW - replyW) * 0.5;
    CGFloat replyY = 64 + margin;
    replyTextView.frame = CGRectMake(replyX, replyY, replyW, replyH);
    replyTextView.textAlignment = NSTextAlignmentJustified;
    replyTextView.font = [UIFont systemFontOfSize:17];
    replyTextView.placeholder = @"点击评论您的教练。(教练本人不可见喔)";
    [self.view addSubview:replyTextView];
    self.replyTextView = replyTextView;
}

- (void)setupStarView {
    JXStarView *feeStarView = [JXStarView starView];
    feeStarView.title = @"报名学费";
    feeStarView.type = JXStarViewTypeFee;
    CGFloat feeViewX = self.replyTextView.jx_x;
    CGFloat feeViewY = CGRectGetMaxY(self.replyTextView.frame) + margin;
    CGFloat feeViewW = self.replyTextView.jx_width;
    CGFloat feeViewH = 44;
    feeStarView.frame = CGRectMake(feeViewX, feeViewY, feeViewW, feeViewH);
    [self.view addSubview:feeStarView];
    self.feeStarView = feeStarView;
    
    JXStarView *introductView = [JXStarView starView];
    introductView.title = @"个人介绍";
    introductView.type = JXStarViewTypeIntro;
    CGFloat introViewX = feeStarView.jx_x;
    CGFloat introViewY = CGRectGetMaxY(feeStarView.frame) + margin * 0.5;
    CGFloat introViewW = feeStarView.jx_width;
    CGFloat introViewH = feeStarView.jx_height;
    introductView.frame = CGRectMake(introViewX, introViewY, introViewW, introViewH);
    [self.view addSubview:introductView];
    self.introductView = introductView;
}

- (void)setupRedBagView {
    JXChooseNumberView *redBagView = [JXChooseNumberView numberView];
    CGFloat redBagViewX = self.introductView.jx_x;
    CGFloat redBagViewY = CGRectGetMaxY(self.introductView.frame) + margin * 0.5;
    CGFloat redBagViewW = self.introductView.jx_width;
    CGFloat redBagViewH = self.introductView.jx_height;
    redBagView.frame = CGRectMake(redBagViewX, redBagViewY, redBagViewW, redBagViewH);
    [self.view addSubview:redBagView];
    self.redBagView = redBagView;
}

- (void)setupConfirmButton {
    UIButton *confirmButton = [[UIButton alloc] init];
    confirmButton.backgroundColor = JXColor(246, 130, 43);
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    CGFloat confirmW = JXScreenW * 0.8;
    CGFloat confirmH = confirmW * 0.14;
    CGFloat confirmX = (JXScreenW - confirmW) * 0.5;
    CGFloat confirmY = CGRectGetMaxY(self.redBagView.frame) + margin;
    confirmButton.frame = CGRectMake(confirmX, confirmY, confirmW, confirmH);
    confirmButton.layer.cornerRadius = confirmH * 0.2;
    [confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
}

/**
 *  确认按钮被点击
 */
- (void)confirmButtonClicked {
    if (self.replyTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"评论不能为空"];
        return;
    }
    else if (self.feeStarView.score == 0 || self.introductView.score == 0) {
        [SVProgressHUD showErrorWithStatus:@"评分不能为空"];
    }
    
    // 发送请求
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"direction"] = @0;
    paras[@"starsA"] = @(self.feeStarView.score);
    paras[@"starsB"] = @(self.introductView.score);
    paras[@"des"] = self.replyTextView.text;
    paras[@"date"] = self.commentedDate;
    paras[@"toId"] = @(account.teacherCID);
    paras[@"tip"] = @(self.redBagView.money);
    
    // 发送评论
    [self sendCommentWithParas:paras];
}

/**
 *  发送评论
 *
 *  @param paras url请求参数
 */
- (void)sendCommentWithParas:(NSDictionary *)paras {
    [JXHttpTool post:[NSString stringWithFormat:@"%@/Tucao", JXServerName] params:paras success:^(id json) {
        JXLog(@"评论成功 - %@", json);
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:json[@"msg"]];
            });
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:json[@"msg"]];
            });
        }
        
        
    } failure:^(NSError *error) {
        JXLog(@"评论失败 - %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"网络请求失败，请稍后重试!"];
        });
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
