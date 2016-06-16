//
//  LLXComments.h
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/22.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLXUser;
@interface LLXComments : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LLXUser *user;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
