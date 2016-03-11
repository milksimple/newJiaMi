//
//  JXChangePwdController.m
//  JMXMiJia
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChangePwdController.h"
#import <SVProgressHUD.h>
#import "NSString+MD5.h"
#import "JXHttpTool.h"
#import "JXAccount.h"
#import "JXAccountTool.h"

@interface JXChangePwdController ()
@property (weak, nonatomic) IBOutlet UITextField *originPwdField;
@property (weak, nonatomic) IBOutlet UITextField *aNewPwdField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;

@end

@implementation JXChangePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)confirmChangePwd {
    if (!self.originPwdField.text.length || !self.aNewPwdField.text.length || !self.confirmPwdTextField) {
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
    }
    
    else if (![self.aNewPwdField.text isEqualToString:self.confirmPwdTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不匹配"];
    }
    
    else {
        [SVProgressHUD showWithStatus:@"正在修改" maskType:SVProgressHUDMaskTypeGradient];
        
        // 发送请求
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        JXAccount *account = [JXAccountTool account];
        paras[@"mobile"] = account.mobile;
        paras[@"password"] = account.password;
        paras[@"key"] = @"password";
        paras[@"value"] = [NSString md5:self.aNewPwdField.text];
        [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/ChangeInfoT" params:paras success:^(id json) {
            BOOL result = [json[@"success"] boolValue];
            if (result) { // 修改成功
                account.password = paras[@"value"];
                [JXAccountTool saveAccount:account];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [SVProgressHUD showErrorWithStatus:json[@"msg"]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误，请重试!"];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
