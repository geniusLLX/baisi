//
//  LLXTagTextField.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/29.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTagTextField.h"

@implementation LLXTagTextField

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame])
    {
        self.width = LLXScreenW;
        self.height = 25;
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}
-(void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}
@end
