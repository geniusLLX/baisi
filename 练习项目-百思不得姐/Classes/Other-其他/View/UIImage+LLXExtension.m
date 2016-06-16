//
//  UIImage+LLXExtension.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/26.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "UIImage+LLXExtension.h"

@implementation UIImage (LLXExtension)
-(UIImage *)circleimage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef currentContext=UIGraphicsGetCurrentContext();
    CGRect rect=CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(currentContext, rect);
    CGContextClip(currentContext);
    [self drawInRect:rect];
    UIImage *new= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new;
}
@end
