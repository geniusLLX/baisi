//
//  LLXComments.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/22.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXComments.h"
@interface LLXComments(){
    CGFloat _cellHeight;
}
@end
@implementation LLXComments
-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 105,MAXFLOAT);
        CGFloat ContentH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
        _cellHeight=ContentH+LLXTopicCellTextY;
    }
    return _cellHeight;
}
@end
