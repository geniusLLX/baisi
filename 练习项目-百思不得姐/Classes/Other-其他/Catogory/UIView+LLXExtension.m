//
//  UIView+LLXExtension.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "UIView+LLXExtension.h"

@implementation UIView (LLXExtension)
-(void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
    
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height; 
}
-(CGSize)size{
    return self.frame.size;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(CGFloat)centerY{
    return self.center.y;
}
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end

