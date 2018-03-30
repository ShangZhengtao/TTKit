//
//  ViewController.m
//  TTKitDemo
//
//  Created by apple on 2017/11/15.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ViewController.h"
//#import "QRCScannerViewController.h"
#import "PresentViewController.h"
#import "BDImagePicker.h"
#import "LrdOutputView.h"
#import "WSDatePickerView.h"
#import "STPickerArea.h"
#import "SlideViewController.h"
#import "CoreJPush.h"
#import "TTMacros.h"
#import "PPNetworkHelper.h"
#import "WRNavigationBar.h"
#import "ZTProgressHUD.h"
#import "UIButton+Event.h"
#import "UIViewController+TTModalTransition.h"
#import "ZHNTopHud.h"


@interface ViewController ()
<
//QRCodeScannerViewControllerDelegate,
STPickerAreaDelegate,
UINavigationControllerDelegate
>
@property (weak, nonatomic) IBOutlet UIButton *areaPickerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
//    self.areaPickerButton.eventTimeInterval = 3;
//    self.modalPresentationStyle =  UIModalPresentationPopover;
 
}

- (IBAction)scannerButtonTapped:(UIButton *)sender {
//    QRCScannerViewController *scannerVC = [[QRCScannerViewController alloc]init];
//    scannerVC.delegate = self;
//    [self presentViewController:scannerVC animated:YES completion:nil];
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
        [ZTProgressHUD showInfo:[NSString stringWithFormat:@"%@",date]];
        
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
    [ZTProgressHUD showInfo:[NSString stringWithFormat:@"扫描结果：%@",result]];
}

#pragma mark - STPickerAreaDelegate

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area {
    [ZTProgressHUD showInfo:[NSString stringWithFormat:@"%@ %@ %@",province,city,area]];
}

- (IBAction)PagedControllerButtonTapped:(UIButton *)sender {
    SlideViewController *slideVC = [[SlideViewController alloc]init];
    [self.navigationController pushViewController:slideVC animated:YES];
}

- (IBAction)requestButtonTapped:(UIButton *)sender {
    [PPNetworkHelper openLog];
    [PPNetworkHelper POST:@"http://zgqz.zhiguyg.com/APP/GetVersion" parameters:nil responseCache:^(id responseCache) {
    } success:^(id responseObject) {
        [ZTProgressHUD showInfo:[NSString stringWithFormat:@"%@",responseObject]];
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)popoverButtonTapped:(UIButton *)sender {
    LrdCellModel *model1 = [[LrdCellModel alloc]initWithTitle:@"扫一扫" imageName:@"tabbar_icon_shop"];
    LrdCellModel *model2 = [[LrdCellModel alloc]initWithTitle:@"添加好友" imageName:@"tabbar_icon_shop"];
    NSArray *items = @[model1, model2];
   
    CGRect frame = [sender.superview convertRect:sender.frame toView:nil];
    CGPoint point = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));
    LrdOutputView *view = [[LrdOutputView alloc]initWithDataArray:items origin:point width:120 rowHeight:44 direction:kLrdOutputViewDirectionRight];
    [view pop];
}

- (IBAction)hudButtonTapped:(UIButton *)sender {
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"样式一" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ZTProgressHUD showInfo:@"在iOS当中，所有的视图都从一个叫做UIView的基类派生而来，UIView可以处理触摸事件，可以支持基于Core Graphics绘图，可以做仿射变换（例如旋转或者缩放），或者简单的类似于滑动或者渐变的动画"];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"样式二" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ZHNTopHud showSuccess: @"hello world!"];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"样式三" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ZTProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ZTProgressHUD dismiss];
        });
    }];
    
    [alertvc addAction:action];
    [alertvc addAction:action2];
    [alertvc addAction:action3];
    [self presentViewController:alertvc animated:YES completion:nil];
        
}


- (IBAction)presentButtonTapped:(UIButton *)sender {
    PresentViewController *vc = [[PresentViewController alloc]init];
//    TestViewController *vc = [[TestViewController alloc]init];
    vc.tt_modalTransitionStyle = TTModalTransitionStyleCircleZoom;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)pushButtonTapped:(UIButton *)sender {
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.title = @"标题";
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
