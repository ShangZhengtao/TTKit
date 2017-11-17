//
//  ViewController.m
//  TTKitDemo
//
//  Created by apple on 2017/11/15.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ViewController.h"
#import "QRCScannerViewController.h"
#import "BDImagePicker.h"
#import "WSDatePickerView.h"
@interface ViewController ()<QRCodeScannerViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)scannerButtonTapped:(UIButton *)sender {
    QRCScannerViewController *scannerVC = [[QRCScannerViewController alloc]init];
    scannerVC.delegate = self;
    [self presentViewController:scannerVC animated:YES completion:nil];
}

- (IBAction)ImagePickerTapped:(UIButton *)sender {
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        [sender setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
}



#pragma mark - QRCodeScannerViewControllerDelegate
-(void)scannerViewControllerDidFinshedScanning:(NSString *)result {
    NSLog(@"扫描结果：%@",result);
}

- (IBAction)pickerDateTapped:(UIButton *)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"选择的日期：%@",date);
        [sender setTitle:date forState:UIControlStateNormal];
        
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
}


@end
