//
//  LLXCommentHeaderView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/24.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXCommentHeaderView.h"
@interface LLXCommentHeaderView()
@end
@implementation LLXCommentHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LLXCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[LLXCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
            self.contentView.backgroundColor=LLXGlobelColor;
            UILabel *label=[[UILabel alloc]init];
            label.textColor=LLXRGBColor(67, 67, 67);
            [self.contentView addSubview:label];
            label.width=100;
            label.x=LLXTopicCellMargin;
            label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        self.label=label;
        }
    return self;
}
@end
