//
//  JXProfileInfoController.m
//  JMXMiJia
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileInfoController.h"
#import "JXProfileInfoIconCell.h"
#import "JXAccount.h"
#import "JXAccountTool.h"
#import "JXHttpTool.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "JXChangeRealnameController.h"
#import "JXChangePwdController.h"
#import "VPImageCropperViewController.h"

@interface JXProfileInfoController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, JXChangeRealnameControllerDelegate, VPImageCropperDelegate>

@end

@implementation JXProfileInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的资料";
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
