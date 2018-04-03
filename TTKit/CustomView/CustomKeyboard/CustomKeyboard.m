//
//  CustomKeyboard.m
//  CustomKeyBoardDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import "CustomKeyboard.h"
#import "UITextField+ExtentRange.h"
@interface CustomKeyboard()

@property (nonatomic, weak) UITextField* textField;

@end

@implementation CustomKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addButton];
    }
    return self;
}

- (instancetype)initWithTargetView:(UITextField *)view {
    if (self = [self initWithFrame:CGRectZero]) {
        self.textField = view;
        self.textField.inputView = self;
    }
    return self;
}
//UI
- (void)addButton {
    CGFloat margin = 10;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (4 * margin)) / 3.0;
    CGFloat height = width * 0.5;
    NSArray *nums = [self shuffle:@[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9)]];
    for (NSInteger i = 0; i < 12; i++) {
        NSInteger row =     i / 3;
        NSInteger column =  i % 3;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((column+1)*margin + column*width, (margin+height)*row+margin, width, height);
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if (i<9) {
            [btn setTitle:[NSString stringWithFormat:@"%@",nums[i]] forState:UIControlStateNormal];
        }
        if (i == 9) {
            [btn setTitle:@"完成" forState:UIControlStateNormal];
        }
        if (i == 10) {
            [btn setTitle:[NSString stringWithFormat:@"%@",nums[9]] forState:UIControlStateNormal];
        }
        if (i == 11) {
            [btn setTitle:@"删除" forState:UIControlStateNormal];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    //键盘高度
    CGFloat viewHeight = 5*margin + 4*height;
    self.frame = CGRectMake(0, 0, 0, viewHeight);
}

//打乱
- (NSArray *)shuffle:(NSArray<NSNumber *> *)array
{
    if(array == nil || array.count < 1)
        return nil;
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:array];
    NSInteger value;
    NSNumber *median;
    
    for(NSInteger index = 0; index < array.count; index ++){
        value = arc4random() % resultArray.count;
        median = resultArray[index];
        
        resultArray[index] = resultArray[value];
        resultArray[value] = median;
    }
    return resultArray;
}

- (void)buttonTapped:(UIButton *)sender{
    
    if (sender.tag == 9) { //完成
        [self.textField resignFirstResponder];
        return ;
    }
    if (sender.tag == 11) {//删除
        if (self.textField.text.length) {
            UITextRange* range = self.textField.selectedTextRange;
            if (range.isEmpty) {//删除光标前面一个字符
                NSRange ran = [self.textField selectedRange];
                if (ran.location != 0) {
                    [self.textField setSelectedRange:NSMakeRange(ran.location-1, 1)];
                    [self.textField replaceRange:self.textField.selectedTextRange withText:@""];
                }
            }else{
                [self.textField replaceRange:range withText:@""];
            }
        }
        return;
    }
    //输入
    UITextRange* range = self.textField.selectedTextRange;
    NSString *str = [sender titleForState:UIControlStateNormal];
    [self.textField replaceRange:range withText:str];
}

@end
