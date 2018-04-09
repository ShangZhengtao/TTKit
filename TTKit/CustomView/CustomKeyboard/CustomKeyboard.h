//
//  CustomKeyboard.h
//  CustomKeyBoardDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CustomKeyboard : UIView <UIInputViewAudioFeedback>

- (instancetype)initWithTargetView:(UITextField * _Nonnull )view;

@end
NS_ASSUME_NONNULL_END
