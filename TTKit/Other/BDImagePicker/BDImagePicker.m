//
//  ImagePicker.m
//  BDKit
//
//  Created by Liu Jinyong on 16/1/20.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDImagePicker.h"

@interface BDImagePicker()
<UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) BDImagePickerFinishAction finishAction;
@property (nonatomic, assign) BOOL allowsEditing;

@end

static BDImagePicker *bdImagePickerInstance = nil;

@implementation BDImagePicker

+ (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(BDImagePickerFinishAction)finishAction {
    if (bdImagePickerInstance == nil) {
        bdImagePickerInstance = [[BDImagePicker alloc] init];
    }
    
    [bdImagePickerInstance showImagePickerFromViewController:viewController
                                               allowsEditing:allowsEditing
                                                finishAction:finishAction];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(BDImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheet:action];
    }];
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheet:action];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheet:action];
    }];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertVC addAction:camera];
        [alertVC addAction:photoLibrary];
        [alertVC addAction:cancel];
    }else {
        [alertVC addAction:photoLibrary];
        [alertVC addAction:cancel];
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)actionSheet:(UIAlertAction *)actionSheet {
    NSString *title = [actionSheet title];
    if ([title isEqualToString:@"拍照"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = _allowsEditing;
        [_viewController presentViewController:picker animated:YES completion:nil];
        
    }else if ([title isEqualToString:@"从相册选择"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = _allowsEditing;
        [_viewController presentViewController:picker animated:YES completion:nil];
    }else {
        bdImagePickerInstance = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (_finishAction) {
        _finishAction(image);
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
    bdImagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_finishAction) {
        _finishAction(nil);
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
    bdImagePickerInstance = nil;
}

@end
