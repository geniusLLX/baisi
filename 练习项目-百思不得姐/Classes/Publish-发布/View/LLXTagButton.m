//
//  LLXTagButton.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/29.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTagButton.h"

@implementation LLXTagButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = LLXRGBColor(74, 139, 209);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3*LLXTagMargin;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x=LLXTagMargin;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+LLXTagMargin;
}
@end
