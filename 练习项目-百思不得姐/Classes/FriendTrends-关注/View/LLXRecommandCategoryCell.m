//
//  LLXRecommandCategoryCell.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/13.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXRecommandCategoryCell.h"
#import "LLXRecommandCategory.h"
@interface LLXRecommandCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation LLXRecommandCategoryCell

- (void)awakeFromNib {
    self.backgroundColor=LLXGlobelColor;
    self.selectedIndicator.backgroundColor = LLXRGBColor(219, 21, 26);
    
}

-(void)setCategory:(LLXRecommandCategory *)category{
    _category=category;
    self.textLabel.text=category.name;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y=3;
    self.textLabel.height=self.contentView.height-5;
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden=!selected;
    self.textLabel.textColor=selected ? self.selectedIndicator.backgroundColor:LLXRGBColor(78, 78, 78);
}
@end
