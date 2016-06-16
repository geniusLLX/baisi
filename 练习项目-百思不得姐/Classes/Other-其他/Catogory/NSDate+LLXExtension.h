//
//  NSDate+LLXExtension.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/19.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LLXExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
@end

