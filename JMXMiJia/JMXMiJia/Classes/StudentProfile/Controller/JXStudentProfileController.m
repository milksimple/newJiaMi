//
//  JXStudentProfileController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXStudentProfileController.h"
#import "JXProfileHeaderView.h"
#import "JXProfileMoneyCell.h"
#import "JXProfileInfoController.h"
#import <UIImageView+WebCache.h>
#import "JXAccount.h"
#import "JXAccountTool.h"
#import "JXLoginViewController.h"
#import "AppDelegate.h"
#import "JXPayViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "JXChangeRealnameController.h"
#import "JXChangePwdController.h"
#import "VPImageCropperViewController.h"
#import "JXProfileInfoIconCell.h"
#import "JXHttpTool.h"
#import "JXPopBgView.h"
#import "JXPopView.h"
#import "JXRecommendPopView.h"
#import "JXHelpViewController.h"

@interface JXStudentProfileController () <UITableViewDataSource, UITableViewDelegate, JXProfileHeaderViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, JXChangeRealnameControllerDelegate, VPImageCropperDelegate, UINavigationControllerDelegate, JXProfileMoneyCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 弹窗 */
@property (nonatomic, weak) UIView *popView;

@end

@implementation JXStudentProfileController

static NSString * const ID = @"profileCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人";
    
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 3;
            break;
            
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JXProfileMoneyCell *moneyCell = [JXProfileMoneyCell moneyCell];
        JXAccount *account = [JXAccountTool account];
        moneyCell.account = account;
        moneyCell.delegate = self;
        return moneyCell;
    }
    
    else if (indexPath.section == 1) { // 个人资料设置
        if (indexPath.row == 0) {
            JXProfileInfoIconCell *iconInfoCell = [[JXProfileInfoIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            iconInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            iconInfoCell.textLabel.text = @"修改头像";
            return iconInfoCell;
        }
        else if (indexPath.row == 1) {
            UITableViewCell *nameCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            nameCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
            nameCell.textLabel.text = @"修改姓名";
            return nameCell;
        }
        else {
            UITableViewCell *changePwdCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            changePwdCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            changePwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
            changePwdCell.textLabel.text = @"修改密码";
            return changePwdCell;
        }
    }
    
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"profile_setting"];
            cell.textLabel.text = @"帮助";
        }
        else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"profile_setting"];
            cell.textLabel.text = @"注销";
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 个人资料设置
        if (indexPath.row == 0) { // 修改头像
            // 修改头像
            if (iOS8) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self openCamera];
                    
                }];
                
                UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self openPhotoLibrary];
                }];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertVC addAction:cameraAction];
                [alertVC addAction:photoAction];
                [alertVC addAction:cancelAction];
                
                [self presentViewController:alertVC animated:YES completion:nil];
            }
            else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:(self) cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册上传", nil];
                [actionSheet showFromTabBar:self.tabBarController.tabBar];
            }
        }
        
        else if (indexPath.row == 1) { // 修改姓名
            JXChangeRealnameController *changeRealnameVC = [[JXChangeRealnameController alloc] init];
            changeRealnameVC.delegate = self;
            changeRealnameVC.defaultName = [JXAccountTool account].name;
            [self.navigationController pushViewController:changeRealnameVC animated:YES];
        }
        
        else { // 修改密码
            JXChangePwdController *changePwdVC = [[JXChangePwdController alloc] init];
            [self.navigationController pushViewController:changePwdVC animated:YES];
        }
    }
    else if (indexPath.section == 2) { // 帮助、注销
        if (indexPath.row == 0) { // 帮助
            JXHelpViewController *helpVC = [[JXHelpViewController alloc] init];
            [self.navigationController pushViewController:helpVC animated:YES];
        }
        else { // 注销
            // 提示是否注销
            if (iOS8) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定注销?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertVC addAction:cancleAction];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 清空account登录状态
                    JXAccount *account = [JXAccountTool account];
                    account.hasLogin = NO;
                    [JXAccountTool saveAccount:account];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    window.rootViewController = [[JXLoginViewController alloc] init];
                }];
                [alertVC addAction:confirmAction];
                
                [self presentViewController:alertVC animated:YES completion:nil];
            }
            else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
                [actionSheet showFromTabBar:self.tabBarController.tabBar];
            }
        }
        
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        JXProfileHeaderView *header = [[JXProfileHeaderView alloc] init];
        header.account = [JXAccountTool account];
        header.delegate = self;
        return header;
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    else return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    else return 54;
}

#pragma mark - 抽取方法
/**
 *  从相机获得照片
 */
- (void)openCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.delegate = self;
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }
}

/**
 *  从相册获得照片
 */
- (void)openPhotoLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.delegate = self;
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet.title isEqualToString:@"上传头像"]) {
        switch (buttonIndex) {
            case 0: // 拍照
                [self openCamera];
                break;
                
            case 1: // 从相册选取
                [self openPhotoLibrary];
                break;
                
            default:
                break;
        }
    }
    
    else if ([actionSheet.title isEqualToString:@"注销"]) {
        if (buttonIndex == 1) { // 确定
            // 清空account登录状态
            JXAccount *account = [JXAccountTool account];
            account.hasLogin = NO;
            [JXAccountTool saveAccount:account];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[JXLoginViewController alloc] init];
        }
    }
    
}

#pragma mark - JXProfileHeaderViewDelegate
- (void)profileHeaderViewDidClickedProfileInfoButton {
    JXProfileInfoController *profileInfoVC = [[JXProfileInfoController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:profileInfoVC animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        // 1.获得相册中的图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        // 2.调出裁剪控制器
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
        
    }];
}

#pragma mark - JXChangeRealnameControllerDelegate
- (void)changeRealnameControllerDidFinished {
    [self.tableView reloadData];
}

#pragma mark - VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD showWithStatus:@"正在上传" maskType:SVProgressHUDMaskTypeBlack];
        // 发送请求上传头像
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        JXAccount *account = [JXAccountTool account];
        params[@"mobile"] = account.mobile;
        params[@"password"] = account.password;
        
        [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/ChangePhoto" params:params constructingWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:UIImagePNGRepresentation(editedImage) name:@"img" fileName:@"myicon" mimeType:@"image/png"];
        } success:^(id json) {
            BOOL success = [json[@"success"] boolValue];
            if (success) { // 上传成功
                [SVProgressHUD showSuccessWithStatus:json[@"msg"]];
                account.photo = [NSString stringWithFormat:@"http://10.255.1.25/dschoolAndroid/%@", json[@"photo"]];
                [JXAccountTool saveAccount:account];
                [self.tableView reloadData];
            }
            else { // 上传失败
                [SVProgressHUD showErrorWithStatus:@"修改失败，请重试!"];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误，请重试!"];
        }];
    }];
}

#pragma mark - VPImageCropperDelegate
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - JXProfileMoneyCellDelegate
- (void)profileMoneyCellDidClickedCommentButton {
    JXRecommendPopView *recommendPopView = [JXRecommendPopView recommendPopView];
    
    JXPopBgView *bgView = [JXPopBgView popBgViewWithContentView:recommendPopView contentSize:recommendPopView.jx_size];
    [bgView show];
}

- (void)profileMoneyCellDidClickedRedBagButton {
    JXPopView *redBagView = [JXPopView popView];
    
    JXPopBgView *bgView = [JXPopBgView popBgViewWithContentView:redBagView contentSize:CGSizeMake(JXScreenW * 0.7, JXScreenH * 0.7)];
    [bgView show];
}

@end
