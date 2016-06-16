//
//  LLXAddTagViewController.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/29.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLXAddTagViewController : UIViewController
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);
@property (nonatomic, strong) NSArray *tags;
@end
