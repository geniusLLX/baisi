//
//  LLXRecommandUserViewCell.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/14.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXRecommandUserViewCell.h"
#import "LLXRecommandUserCategory.h"
#import "UIImageView+WebCache.h"
@interface LLXRecommandUserViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end
@implementation LLXRecommandUserViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=LLXGlobelColor;
}
-(void)setUser:(LLXRecommandUserCategory *)user{
    _user=user;
    self.screenNameLabel.text =user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

@end
