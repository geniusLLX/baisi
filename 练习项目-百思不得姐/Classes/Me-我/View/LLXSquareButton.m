//
//  LLXSquareButton.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/26.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXSquareButton.h"
#import "LLXSquare.h"
#import "UIButton+WebCache.h"
@implementation LLXSquareButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 调整图片
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame)+LLXTopicCellMargin;
    self.titleLabel.width = self.width ;
    self.titleLabel.font=[UIFont systemFontOfSize:15];
    
    self.titleLabel.textColor=[UIColor grayColor];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
        self.titleLabel.contentMode=UIViewContentModeCenter;
}
-(void)setSquare:(LLXSquare *)square
{
    _square=square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}
@end
