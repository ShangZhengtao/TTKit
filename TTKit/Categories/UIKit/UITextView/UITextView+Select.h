//
//  UITextView+Select.h
//  IOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Select)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)setSelectedRange:(NSRange)range;



//https://github.com/pclion/TextViewCalculateLength
// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)getInputLengthWithText:(NSString *)text;
/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger textLength = [textView getInputLengthWithText:text];
    if (textLength > 20) {
        //超过20个字可以删除
        if ([text isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView getInputLengthWithText:nil] > 20) {
        textView.text = [textView.text substringToIndex:20];
    }
}
*/
#pragma mark - /////////////////////////////////
/**
 *  设置空格插入的位置 使用方式
 *  - textField:shouldChangeCharactersInRange:replacementString:
 *  执行如下代码 123456 2345 2345 345666
 *  NSArray *insertPosition = @[@(6), @(10), @(14), @(18)];
 *  [textField insertWhitSpaceInsertPosition:insertPosition replacementString:string textlength:20];
 *  return NO;
 *
 *  @param insertPosition 插入的位置
 *  @param string         插入的字符串
 *  @param length         文本长度
 */
- (void)insertWhitSpaceInsertPosition:(NSArray *)insertPosition replacementString:(NSString *)string textlength:(NSInteger)length;



@end
