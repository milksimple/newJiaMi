//
//  JXRegisterViewController.m
//  JMXMiJia
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXRegisterViewController.h"
#import <Masonry.h>
#import "JXIconTextField.h"
#import <SVProgressHUD.h>
#import "JXAccount.h"
#import "JXAccountTool.h"
#import "JXHttpTool.h"

@interface JXRegisterViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
/** 用户名 */
@property (nonatomic, weak) JXIconTextField *usernameField;
/** 密码 */
@property (nonatomic, weak) JXIconTextField *pwdField;
/** 确认密码 */
@property (nonatomic, weak) JXIconTextField *pwdConfirmField;
/** 真实姓名 */
@property (nonatomic, weak) JXIconTextField *realNameField;
/** 推荐码 */
@property (nonatomic, weak) JXIconTextField *rMobileField;
/** 性别 */
@property (nonatomic, weak) JXIconTextField *sexField;
/** 注册按钮 */
@property (nonatomic, weak) UIButton *registerButton;
@end

@implementation JXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat margin = 20; // field之间的间距
    CGFloat fieldH = 40; // field的高度
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    
    self.usernameField = [self setupTextFieldWithEditingImage:@"login_name_high" endEditImage:@"login_name" placeholder:@"请输入登录名(手机号)"];
    
    self.pwdField = [self setupTextFieldWithEditingImage:@"login_pwd_high" endEditImage:@"login_pwd" placeholder:@"请输入密码"];
    [self.pwdField setSecureTextEntry:YES];
    
    self.pwdConfirmField = [self setupTextFieldWithEditingImage:@"register_confirm_pwd_high" endEditImage:@"register_confirm_pwd" placeholder:@"请再次输入密码"];
    [self.pwdConfirmField setSecureTextEntry:YES];
    
    self.realNameField = [self setupTextFieldWithEditingImage:@"register_name_high" endEditImage:@"register_name" placeholder:@"请输入真实姓名"];
    
    self.sexField = [self setupTextFieldWithEditingImage:@"register_sex_high" endEditImage:@"register_sex" placeholder:@"性别"];
    UIPickerView *sexPicker = [[UIPickerView alloc] init];
    sexPicker.backgroundColor = [UIColor whiteColor];
    sexPicker.dataSource = self;
    sexPicker.delegate = self;
    self.sexField.inputView = sexPicker;
    [sexPicker selectedRowInComponent:0];
    
    self.rMobileField = [self setupTextFieldWithEditingImage:@"register_recommend_high" endEditImage:@"register_recommend" placeholder:@"请输入推荐码(选填)"];
    
    UIButton *registerButton = [[UIButton alloc] init];
    registerButton.layer.cornerRadius = fieldH * 0.5;
    [registerButton setTitle:@"注  册" forState:UIControlStateNormal];
    registerButton.backgroundColor = JXColor(254, 125, 0);
    // 监听按钮点击
    [registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    self.registerButton = registerButton;
    
    [@[self.usernameField, self.pwdField, self.pwdConfirmField, self.realNameField, self.sexField, self.rMobileField, self.registerButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.width.equalTo(self.view.width).multipliedBy(0.8);
        make.height.offset(fieldH);
    }];
    
    [self.usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(margin * 4);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameField.bottom).offset(margin);
    }];
    
    [self.pwdConfirmField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdField.bottom).offset(margin);
    }];
    
    [self.realNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdConfirmField.bottom).offset(margin);
    }];
    
    [self.sexField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.realNameField.bottom).offset(margin);
    }];
    
    [self.rMobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexField.bottom).offset(margin);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rMobileField.bottom).offset(margin * 2);
    }];
}

- (JXIconTextField *)setupTextFieldWithEditingImage:(NSString *)editingImage endEditImage:(NSString *)endEditImage placeholder:(NSString *)placeholder {
    JXIconTextField *textField = [[JXIconTextField alloc] init];
    [textField setEditingImage:[UIImage imageNamed:editingImage] endEditImage:[UIImage imageNamed:endEditImage]];
    textField.placeholder = placeholder;
    [self.view addSubview:textField];
    
    return textField;
}

/**
 *  注册按钮被点击了
 */
- (void)registerButtonClicked {
    JXAccount *account = [JXAccountTool account];
    if (!self.usernameField.text.length || !self.pwdField.text.length || !self.pwdConfirmField || !self.realNameField || !self.sexField || !self.rMobileField) {
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
    }
    
    else if (![self.pwdField.text isEqualToString:self.pwdConfirmField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不匹配"];
    }
    else {
        [SVProgressHUD showWithStatus:@"正在注册" maskType:SVProgressHUDMaskTypeBlack];
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"mobile"] = self.usernameField.text;
        paras[@"password"] = self.pwdConfirmField.text;
        paras[@"realName"] = self.realNameField.text;
        paras[@"rMobile"] = self.rMobileField.text;
        if ([self.sexField.text isEqualToString:@"男"]) {
            paras[@"sex"] = @1;
        }
        else {
            paras[@"sex"] = @0;
        }
        
        paras[@"pushToken"] = [JXAccountTool account].pushToken;
        [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/TraineeReg" params:paras success:^(id json) {
            
            BOOL success = [json[@"success"] boolValue];
            if (success == 0) { // 注册失败
                
                [SVProgressHUD showErrorWithStatus:json[@"msg"]];
            }
            else { // 注册成功
                [SVProgressHUD showSuccessWithStatus:json[@"msg"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接失败,请重试!"];
            JXLog(@"请求失败 - %@", error);
        }];
    }
}

/**
 *  点击了导航栏上的取消按钮
 */
- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) return @"男";
    else return @"女";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        self.sexField.text = @"男";
    }
    else if (row == 1) {
        self.sexField.text = @"女";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
