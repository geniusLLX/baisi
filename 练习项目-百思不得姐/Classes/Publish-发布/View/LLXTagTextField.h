//
//  LLXTagTextField.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/29.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLXTagTextField : UITextField
@property (nonatomic, copy) void (^deleteBlock)();
@end
