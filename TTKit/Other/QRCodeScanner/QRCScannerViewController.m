//
//  QRCScannerViewController.m
//  QRScannerDemo
//  blog:www.zhangfei.tk
//  Created by zhangfei on 15/10/15.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import "QRCScannerViewController.h"
#import "QRCScanner.h"

@interface QRCScannerViewController ()
<QRCodeScanneDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@end

@implementation QRCScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QRCScanner *scanner = [[QRCScanner alloc]initQRCScannerWithView:self.view];
    scanner.delegate = self;
    [self.view addSubview:scanner];
    
    //从相册选取二维码
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 30, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"back_background_icon"] forState:UIControlStateNormal];
    [rightButton setTitle:@"返回" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:rightButton];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60 -16, 30, 60, 40)];
    [leftButton setTitle:@"相册" forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"pic_to_image_lab"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(readerImage:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:leftButton];
    
}

//back_background_icon
#pragma mark - 扫描二维码成功后结果的代理方法
- (void)didFinshedScanningQRCode:(NSString *)result{
    if (!result.length) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scannerViewControllerDidFinshedScanning:)]) {
        [self.delegate scannerViewControllerDidFinshedScanning:result];
    }
    [self backAction:nil];
}

- (void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 从相册获取二维码图片
- (void)readerImage:(UIButton *)sende{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPicker.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:photoPicker animated:YES completion:NULL];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *result = [QRCScanner scQRReaderForImage:srcImage];
    if (!result.length) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scannerViewControllerDidFinshedScanning:)]) {
        [self.delegate scannerViewControllerDidFinshedScanning:result];
    }
    [self backAction:nil];
}

@end
