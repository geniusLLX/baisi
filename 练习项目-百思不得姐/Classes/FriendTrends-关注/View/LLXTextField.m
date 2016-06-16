//
//  LLXTextField.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/17.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTextField.h"

@implementation LLXTextField

-(void)awakeFromNib{
    self.tintColor=self.textColor;
    [self resignFirstResponder];
}
-(BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
