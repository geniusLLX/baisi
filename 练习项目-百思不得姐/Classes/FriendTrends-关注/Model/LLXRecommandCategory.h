//
//  LLXRecommandCategory.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/13.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLXRecommandCategory : NSObject/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
