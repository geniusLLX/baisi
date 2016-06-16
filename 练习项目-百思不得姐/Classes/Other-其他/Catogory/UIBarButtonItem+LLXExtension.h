//
//  UIBarButtonItem+LLXExtension.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/11.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LLXExtension)
+(instancetype)ItemWithImage:(NSString *)Image HighlightedImage:(NSString *)HighlightedImage  target:(id)target   action:(SEL)action;
@end
