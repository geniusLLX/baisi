//
//  LLXRecommandTagsCell.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/15.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXRecommandTagsCell.h"
#import "LLXRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface LLXRecommandTagsCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end
@implementation LLXRecommandTagsCell

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}
-(void)setRecommandTag:(LLXRecommendTag *)recommandTag{
    _recommandTag=recommandTag;
    [self.imageListImageView setHeader:recommandTag.image_list];
     self.themeNameLabel.text=recommandTag.theme_name;
     self.subNumberLabel.text=[NSString stringWithFormat:@"%zd人关注",recommandTag.sub_number];
}

@end
