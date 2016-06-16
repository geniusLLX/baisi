//
//  LLXGuideView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/17.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXGuideView.h"

@implementation LLXGuideView
- (IBAction)Close:(id)sender {
    [self removeFromSuperview];
}


+(void)show{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        LLXGuideView *guideView = [LLXGuideView viewFromXib];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
