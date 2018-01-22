//
//  UITextView+Select.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UITextView+Select.h"

@implementation UITextView (Select)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}
/**
 *  @brief  选中所有文字
 */
- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
//https://github.com/pclion/TextViewCalculateLength
// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题

- (NSInteger)getInputLengthWithText:(NSString *)text
{
    NSInteger textLength = 0;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    if (selectedRange) {
        NSString *newText = [self textInRange:selectedRange];
        textLength = (newText.length + 1) / 2 + [self offsetFromPosition:self.beginningOfDocument toPosition:selectedRange.start] + text.length;
    } else {
        textLength = self.text.length + text.length;
    }
    return textLength;
}

/**
 *  设置空格插入的位置
 *
 *  @param insertPosition <#insertPosition description#>
 */
- (void)insertWhitSpaceInsertPosition:(NSArray *)insertPosition replacementString:(NSString *)string textlength:(NSInteger)length {
    if ([string isEqualToString:@""]) {
        [self deleteBackward];
    }
    if (self.text.length > length) {
        return;
    }
    if (![string isEqualToString:@""]) {
        [self insertText:string];
    }
    
    // 判断光标位置
    NSRange range = [self selectedRange];
    NSUInteger targetCursorPosition = range.location;
    // 移除空格
    NSString *removeNonDigits = [self removeWhitespaceCharacter:self.text andPreserveCursorPosition:&targetCursorPosition];
    // 插入空格
    NSString *phoneNumberWithSpaces = [self insertWhitespaceCharacter:removeNonDigits andPreserveCursorPosition:&targetCursorPosition insertPosition:insertPosition];
    // 重新赋值
    self.text = phoneNumberWithSpaces;
    // 设置光标位置
    NSRange sRange = NSMakeRange(targetCursorPosition, range.length);
    [self setSelectedRange:sRange];
}

/**
 *  插入空格
 *
 *  @param string         <#string description#>
 *  @param cursorPosition <#cursorPosition description#>
 *  @param insertPosition 分隔位置，数组全部传递数字
 *
 *  @return <#return value description#>
 */
- (NSString *)insertWhitespaceCharacter:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition insertPosition:(NSArray *)insertPosition {
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i = 0; i < string.length; i++) {
        [insertPosition enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (i == [obj integerValue]) {
                [stringWithAddedSpaces appendString:@" "];
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }];
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

/**
 *  移除空格
 *
 *  @param string         <#string description#>
 *  @param cursorPosition <#cursorPosition description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)removeWhitespaceCharacter:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i = 0; i < string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        if(![[NSCharacterSet whitespaceCharacterSet] characterIsMember:characterToAdd]) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

@end
