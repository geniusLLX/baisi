//
//  LLXTopWindow.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/24.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopWindow.h"
@interface LLXTopWindow()

@end
static UIWindow *window_;
@implementation LLXTopWindow
+(void)initialize{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, LLXScreenW, 20);
    window_.backgroundColor=[UIColor clearColor];
    window_.windowLevel=UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
}
+(void)show
{
    window_.hidden=NO;
}
+(void)windowClick{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+(void)searchScrollViewInView:(UIView *)lastview
{
    for (UIScrollView *subview in lastview.subviews)
    {
        CGRect newFrame=[subview.superview convertRect:subview.frame toView:nil];
        CGRect winBounds=[UIApplication sharedApplication].keyWindow.bounds;
        BOOL isShowingOnWindow = !subview.isHidden&&CGRectIntersectsRect(newFrame, winBounds);
        if ([subview isKindOfClass:[UIScrollView class]]&&isShowingOnWindow)
        {
            CGPoint offset= subview.contentOffset;
            offset.y= - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        [self searchScrollViewInView:subview];
    }
}
@end
