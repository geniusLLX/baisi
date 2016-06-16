//
//  LLXPostWordViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/28.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXPostWordViewController.h"
#import "LLXPlaceholderTextView.h"
#import "LLXAddTagToolbar.h"
@interface LLXPostWordViewController ()<UITextViewDelegate>
@property (nonatomic, strong) LLXPlaceholderTextView *textView;
@property(nonatomic,weak)LLXAddTagToolbar *toolbar;
@end

@implementation LLXPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
    //设置textview的代理
    self.textView.delegate=self;
    
}
//初始化navigation的属性并添加item的点击事件
-(void)setupNav
{
    self.title=@"发段子";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    //强制刷新在控制器出现前调self.navigationItem.rightBarButtonItem.enabled=NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}

/**
 *设置textview的占位文字和字体颜色
 */
-(void)setupTextView
{
    LLXPlaceholderTextView *placeHolderTextView=[[LLXPlaceholderTextView alloc]init]; placeHolderTextView.placeholder=@"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    placeHolderTextView.frame=self.view.bounds;
    
    [self.view addSubview:placeHolderTextView];
    self.textView=placeHolderTextView;
}
//设置toolbar
-(void)setupToolbar
{
    LLXAddTagToolbar *toolbar=[LLXAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    //通过调用对键盘通知改变toolbar位置
//    keyboardWillChangeFrame
//    keyboardRect.origin.y-LLXScreenH
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**
 *进入控制器后显示键盘
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}
-(void)post
{
    LLXLogFunc;
}
/**
 *监听键盘的出现于消失设置toolbar的位置
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect keyboardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardMoveTime=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:keyboardMoveTime animations:^{
        self.toolbar.transform=CGAffineTransformMakeTranslation(0, keyboardRect.origin.y-LLXScreenH);
    }];
}
/**
 *textview的两个代理方法
 */
-(void)textViewDidChange:(UITextView *)textView
{
    //若textview一旦有文字输入navigationItem的右侧按键恢复使用
    self.navigationItem.rightBarButtonItem.enabled=self.textView.hasText;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
