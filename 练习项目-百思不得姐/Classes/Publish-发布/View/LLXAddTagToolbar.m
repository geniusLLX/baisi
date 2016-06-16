//
//  LLXAddTagToolbar.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/28.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXAddTagToolbar.h"
#import "LLXAddTagViewController.h"
@interface LLXAddTagToolbar()
@property (weak, nonatomic) IBOutlet UIView *TopView;

/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;
@end
@implementation LLXAddTagToolbar
-(NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels=[NSMutableArray array];
    }
    return _tagLabels;
}
-(void)awakeFromNib
{
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.x=LLXTopicCellMargin;
    addButton.size=addButton.currentImage.size;
    self.addButton=addButton;
    [self createTagLabels:@[@"吐槽",@"糗事"]];
    [self addSubview:addButton];
}
-(void)addButtonClick
{
    LLXAddTagViewController *AddTagVC=[[LLXAddTagViewController alloc]init];
    UIViewController *rootVC=[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav=(UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:AddTagVC animated:YES];
    __weak typeof(self) weakSelf = self;
    AddTagVC.tagsBlock=^(NSArray *tags){
        [weakSelf createTagLabels:tags];
    };
    AddTagVC.tags=[self.tagLabels valueForKeyPath:@"text"];
}
- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = LLXRGBColor(74, 139, 209);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * LLXTagMargin;
        tagLabel.height = 35;
        tagLabel.textColor = [UIColor whiteColor];
        [self.TopView addSubview:tagLabel];
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
    // 设置位置
    if (i == 0) { // 最前面的标签
        tagLabel.x = 0;
        tagLabel.y = 0;
    } else { // 其他标签
        UILabel *lastTagLabel = self.tagLabels[i - 1];
        // 计算当前行左边的宽度
        CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LLXTagMargin;
        // 计算当前行右边的宽度
        CGFloat rightWidth = self.TopView.width - leftWidth;
        if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
            tagLabel.y = lastTagLabel.frame.origin.y;
            tagLabel.x = leftWidth;
        } else { // 按钮显示在下一行
            tagLabel.x = 0;
            tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + LLXTagMargin;
        }
    }
    }
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LLXTagMargin;
    
    // 更新textField的frame
    if (self.TopView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.frame.origin.y + LLXTagMargin;
        self.addButton.x = leftWidth+LLXTagMargin;
    } else {
        self.addButton.x = LLXTagMargin;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + LLXTagMargin;
    }
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y =self.frame.origin.y - self.height + oldH;
}
@end
