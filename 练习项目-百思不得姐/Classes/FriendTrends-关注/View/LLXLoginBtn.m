//
//  LLXLoginBtn.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/17.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXLoginBtn.h"

@implementation LLXLoginBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x=0;
    self.imageView.y=0;
    self.imageView.width=self.imageView.image.size.width;
    self.imageView.height=self.imageView.image.size.height;
    self.titleLabel.x=0;
    self.titleLabel.y=self.imageView.image.size.height;
    self.titleLabel.width=self.imageView.image.size.width;
    self.titleLabel.height=self.frame.size.height-self.imageView.image.size.height;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}

@end
