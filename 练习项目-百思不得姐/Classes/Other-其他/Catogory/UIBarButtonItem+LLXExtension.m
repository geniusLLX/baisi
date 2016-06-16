//
//  UIBarButtonItem+LLXExtension.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/11.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "UIBarButtonItem+LLXExtension.h"

@implementation UIBarButtonItem (LLXExtension)
+(instancetype)ItemWithImage:(NSString *)Image HighlightedImage:(NSString *)HighlightedImage  target:(id)target   action:(SEL)action
{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:Image]
                                          forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:HighlightedImage]
                                          forState:UIControlStateHighlighted];
    
    button.size=button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
