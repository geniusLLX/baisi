//
//  UIView+LLXExtension.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LLXExtension)

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGSize size;
+ (instancetype)viewFromXib;
@end
