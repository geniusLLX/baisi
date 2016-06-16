//
//  LLXRecommandCategory.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/13.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXRecommandCategory.h"

@implementation LLXRecommandCategory
-(NSMutableArray *)users{
    if (_users==nil) {
        _users=[NSMutableArray array];
    }
    return _users;
}
@end
