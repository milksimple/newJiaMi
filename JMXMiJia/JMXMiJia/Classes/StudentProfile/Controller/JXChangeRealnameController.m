//
//  JXChangeRealnameController.m
//  JMXMiJia
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChangeRealnameController.h"
#import "JXHttpTool.h"
#import "JXAccount.h"
#import "JXAccountTool.h"
#import <SVProgressHUD.h>

@interface JXChangeRealnameController ()
@property (weak, nonatomic) IBOutlet UITextField *realnameField;

@end

@implementation JXChangeRealnameController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"修改姓名";
    self.realnameField.text = self.defaultName;

}
- (IBAction)changeRealName {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.realnameField resignFirstResponder];
    
    // 发送请求
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    paras[@"key"] = @"realName";
    paras[@"value"] = self.realnameField.text;
    [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/ChangeInfoT" params:paras success:^(id json) {
        BOOL result = [json[@"success"] boolValue];
        if (result) { // 修改成功
            account.name = self.realnameField.text;
            [JXAccountTool saveAccount:account];
            [SVProgressHUD showSuccessWithStatus:json[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
            
            // 通知代理，姓名修改成功
            if ([self.delegate respondsToSelector:@selector(changeRealnameControllerDidFinished)]) {
                [self.delegate changeRealnameControllerDidFinished];
            }
            
        }
        else {
            [SVProgressHUD showErrorWithStatus:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败,请重试!"];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.realnameField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
