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
#import "LrdOutputView.h"
#import "WSDatePickerView.h"
#import "STPickerArea.h"
#import "SlideViewController.h"
#import "CoreJPush.h"
#import "TTMacros.h"
#import "PPNetworkHelper.h"
#import "WRNavigationBar.h"
@interface ViewController ()
<
QRCodeScannerViewControllerDelegate,
STPickerAreaDelegate
>
@property (weak, nonatomic) IBOutlet UIButton *areaPickerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
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

- (IBAction)areaPickerTapped:(UIButton *)sender {
    STPickerArea *pickerArea = [[STPickerArea alloc]init];
    [pickerArea setDelegate:self];
    [pickerArea setSaveHistory:YES];
    [pickerArea setContentMode:STPickerContentModeBottom];
    [pickerArea show];
}

#pragma mark - QRCodeScannerViewControllerDelegate

-(void)scannerViewControllerDidFinshedScanning:(NSString *)result {
    NSLog(@"扫描结果：%@",result);
}

#pragma mark - STPickerAreaDelegate

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area {
    [self.areaPickerButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",province,city,area] forState:UIControlStateNormal];
}

- (IBAction)PagedControllerButtonTapped:(UIButton *)sender {
    SlideViewController *slideVC = [[SlideViewController alloc]init];
    [self.navigationController pushViewController:slideVC animated:YES];
}

- (IBAction)requestButtonTapped:(UIButton *)sender {
    [PPNetworkHelper openLog];
    [PPNetworkHelper POST:@"http://zgqz.zhiguyg.com/APP/GetVersion" parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)popoverButtonTapped:(UIButton *)sender {
    LrdCellModel *model1 = [[LrdCellModel alloc]initWithTitle:@"tittle1" imageName:@"tabbar_icon_shop"];
    LrdCellModel *model2 = [[LrdCellModel alloc]initWithTitle:@"tittle2" imageName:@"tabbar_icon_shop"];
    NSArray *items = @[model1, model2];
    CGPoint point = CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame));
    LrdOutputView *view = [[LrdOutputView alloc]initWithDataArray:items origin:point width:100 rowHeight:44 direction:kLrdOutputViewDirectionRight];
    [view pop];
}

@end
