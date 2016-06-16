//
//  LLXUser.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/22.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLXUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
