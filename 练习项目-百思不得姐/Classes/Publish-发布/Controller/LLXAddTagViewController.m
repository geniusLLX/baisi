//
//  LLXAddTagViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/29.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXAddTagViewController.h"
#import "LLXTagButton.h"
#import "LLXTagTextField.h"
#import "SVProgressHUD.h"
@interface LLXAddTagViewController ()<UITextFieldDelegate>
/** 内容 */
@property(nonatomic,weak)UIView *contentView;
/**输入的文本框*/
@property(nonatomic,weak)UITextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation LLXAddTagViewController
/**
 *  预加载tagbutton
 */
-(NSMutableArray *)tagButtons{
    if (_tagButtons==nil) {
        NSMutableArray *tagButton=[NSMutableArray array];
        _tagButtons=tagButton;
    }
    return _tagButtons;
}
/**
 *  预加载addButton
 */
-(UIButton *)addButton{
    if (_addButton==nil) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        addButton.x=0;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, LLXTopicCellMargin, 0, LLXTopicCellMargin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = LLXRGBColor(74, 139, 209);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
        _addButton.hidden=YES;
        
    }
    return _addButton;
}
/**
 *  预加载contentView
 */
-(UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}
/**
 *  预加载textField
 */
-(UITextField *)textField
{
    if (!_textField) {
        __weak typeof (self) weakSelf=self;
        LLXTagTextField *textField = [[LLXTagTextField alloc] init];
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        textField.deleteBlock = ^{
            if (weakSelf.textField.hasText) return;
            
            [weakSelf deleteTagButton:[weakSelf.tagButtons lastObject]];
        };
        textField.delegate=self;
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return  _textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
-(void)setuptags
{
    if (self.tags) {
        for (NSString *tags in self.tags) {
            self.textField.text=tags;
            [self addButtonClick];
        }
    }
    self.tags=nil;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.x = LLXTopicCellMargin;
    self.contentView.width = self.view.width - 2 * LLXTopicCellMargin;
    self.contentView.y = 64 + LLXTopicCellMargin;
    self.contentView.height = LLXScreenH;
    
    self.textField.width=self.contentView.width;
    
    [self setuptags];
}
/**
 *  添加标签的点击事件
 */
-(void)addButtonClick
{
    if (self.tagButtons.count==5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return ;
    }
    LLXTagButton *tagButton=[LLXTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(deleteTagButton:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    self.textField.text=nil;
    self.addButton.hidden = YES;
}
/**
 * 更新标签的位置
 */

-(void)updateTagButtonFrame
{
    for (int i = 0; i<self.tagButtons.count; i++){
        LLXTagButton *tagButton=self.tagButtons[i];
    
        if (i==0) {
            tagButton.x=0;
            tagButton.y=0;
        }else{
            LLXTagButton *lastTagButton=self.tagButtons[i-1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LLXTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) { // 按钮显示在当前行
                tagButton.y = lastTagButton.frame.origin.y;
                tagButton.x = leftWidth;
            } else { // 按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) +LLXTagMargin;
            }
            }
        }
    
    // 最后一个标签按钮
    LLXTagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) +LLXTagMargin;
    
    // 更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.frame.origin.y;
        self.textField.x = leftWidth;
    }
    //换行
    else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + LLXTagMargin;
    }
}
/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}
/**
 * 删除标签按钮
 */
-(void)deleteTagButton:(LLXTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}
/**
 *  监听textfield
 */
-(void)textDidChange
{
    if (self.textField.hasText)
    {
        self.addButton.hidden=NO;
        self.addButton.y=CGRectGetMaxY(self.textField.frame)+LLXTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        //如果输入逗号，则添加标签按钮
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        if ([lastLetter isEqualToString:@","]
            || [lastLetter isEqualToString:@"，"]) {
            // 去除逗号
            self.textField.text = [text substringToIndex:len - 1];
            
            [self addButtonClick];
        }
    }
    else
    {
        self.addButton.hidden=YES;
    }
        [self updateTagButtonFrame];
}
/**
 * 监听键盘最右下角按钮的点击（return key， 比如“换行”、“完成”等等）
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}
/**
 *  将数据传给TopView
 */
-(void)done
{
    // 传递tags给这个block
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutSubviews];
}
@end
