//
//  LLXPlaceholderTextView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/28.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXPlaceholderTextView.h"
@interface LLXPlaceholderTextView()
@property(weak,nonatomic)UILabel *placeholderLabel;
@end
//初始化占位文字的位置
static CGFloat placeholderLabelX=5;
static CGFloat placeholderLabelY=7;
@implementation LLXPlaceholderTextView
-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = placeholderLabelX;
        placeholderLabel.y = placeholderLabelY;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];

        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

/**
 * 更新占位文字的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.width=self.width-2*placeholderLabelX;
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}
@end
