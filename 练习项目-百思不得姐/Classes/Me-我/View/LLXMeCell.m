//
//  LLXMeCell.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/26.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXMeCell.h"

@implementation LLXMeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    };
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    self.imageView.width=30;
    self.imageView.height=self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x=self.imageView.frame.origin.x+self.imageView.width+LLXTopicCellMargin;
}
@end
