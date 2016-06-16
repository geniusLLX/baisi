//
//  LLXTabBar.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTabBar.h"
#import "LLXPublishViewController.h"
@interface LLXTabBar()
@property(weak,nonatomic)UIButton *publishButton;
@end
@implementation LLXTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
            [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publish=[UIButton buttonWithType:UIButtonTypeCustom];
        [publish setBackgroundImage:
         [UIImage imageNamed:@"tabBar_publish_icon"]
                           forState:UIControlStateNormal];
        [publish setBackgroundImage:
                [UIImage imageNamed:@"tabBar_publish_click_icon"]
                           forState:UIControlStateHighlighted];
        self.publishButton=publish;
        [self addSubview:self.publishButton];
    }
    return self; 
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.publishButton.width=self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height=self.publishButton.currentBackgroundImage.size.height;
    [self.publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    self.publishButton.center=CGPointMake(self.width/2, self.height/2);
    CGFloat Y=0;
    CGFloat W=self.width/5;
    CGFloat H=self.height;
    NSInteger index=0;
    
    for (UIView *btn in self.subviews)
    {
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        if (index==2) index++;
        CGFloat X=W*index;
        btn.frame=CGRectMake(X, Y, W, H);
        index++;        
    }
}
-(void)publishClick{
    LLXPublishViewController *PublishV=[[LLXPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PublishV animated:NO completion:^{
        
    }];
}
@end
