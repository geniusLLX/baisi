//
//  LLXTopics.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/18.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopics.h"
#import "NSDate+LLXExtension.h"
#import "LLXComments.h"
#import "LLXUser.h"
@interface LLXTopics(){
    CGFloat _cellHeight;
}
@end
@implementation LLXTopics
-(NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
   
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps=[[NSDate date]deltaFrom:create];
        if (cmps.hour>=1)
            {
            return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }
        else if (cmps.minute>=1)
            {
            return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }
        else
            {
            return @"刚刚";
            }
            }
        else if(create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }
    else
    {
        return _create_time;
    }
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}
+ (NSDictionary *)objectClassInArray
{
    //    return @{@"top_cmt" : [LLXComments class]};
    return @{@"top_cmt" : @"LLXComments"};
}
-(CGFloat)cellHeight{
    if (!_cellHeight)
    {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 *LLXTopicCellMargin,MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight=textH+LLXTopicCellTextY+LLXTopicCellMargin;
        if (self.type==LLXTopicTypePicture) {
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= LLXTopicCellPictureMaxH) { // 图片高度过长
                pictureH = LLXTopicCellPictureBreakH;
            self.bigPicture = YES; // 大图
            }
                // 计算图片控件的frame
                CGFloat pictureX = LLXTopicCellMargin;
                CGFloat pictureY = LLXTopicCellTextY + textH + LLXTopicCellMargin;
                _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + LLXTopicCellMargin;
        }else if (self.type == LLXTopicTypeVoice) { // 声音帖子
            // 图片显示出来的宽度
            CGFloat voiceW = maxSize.width;
            // 显示显示出来的高度
            CGFloat voiceH = voiceW * self.height / self.width;
            // 计算图片控件的frame
            CGFloat voiceX = LLXTopicCellMargin;
            CGFloat voiceY = LLXTopicCellTextY + textH + LLXTopicCellMargin;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + LLXTopicCellMargin;
        }
        else if (self.type == LLXTopicTypeVideo) { // 声音帖子
            // 图片显示出来的宽度
            CGFloat videoW = maxSize.width;
            // 显示显示出来的高度
            CGFloat videoH = videoW * self.height / self.width;
            // 计算图片控件的frame
            CGFloat videoX = LLXTopicCellMargin;
            CGFloat videoY = LLXTopicCellTextY + textH + LLXTopicCellMargin;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + LLXTopicCellMargin;
        }
        LLXComments *cmt=[self.top_cmt firstObject];
        if (cmt) {
            NSString *cmtContent=[NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
            CGFloat ContentH=[cmtContent boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += LLXTopicCellTopCmtTitleH + ContentH + LLXTopicCellMargin;          
        }
                _cellHeight += LLXTopicCellBottomBarH + LLXTopicCellMargin;
        }
    
    return _cellHeight;
}
@end
