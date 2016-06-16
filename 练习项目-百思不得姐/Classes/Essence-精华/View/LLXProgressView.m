//
//  LLXProgressView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/20.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXProgressView.h"

@implementation LLXProgressView
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    NSString *text=[NSString stringWithFormat:@"%.0f%%",progress*100];
    text=[text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text=text;
}
@end
