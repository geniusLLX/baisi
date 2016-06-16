//
//  LLXEssenceViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXEssenceViewController.h"
#import "LLXRecommandTagsViewController.h"
#import "LLXTopicViewController.h"
#import "SVProgressHUD.h"
#import "AFHTTPSessionManager.h"
#import "LLXTopWindow.h"
@interface LLXEssenceViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIButton *selectedButton;
@property(nonatomic,weak)UIView *indicatorView;
@property(nonatomic,weak)UIScrollView *contentView;
@property(nonatomic,weak)UIView *titleView;

@end

@implementation LLXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化导航栏信息
    [self setupNavigation];
    
    //添加ScrollView
    [self setupScrollView];
    
    //添加标签栏信息
    [self setuptitleView];
    
    [self setupContentView];
    //显示控制View滚动的状态栏
    [LLXTopWindow show];
}
-(void)setupNavigation{
    self.view.backgroundColor=LLXGlobelColor;
    self.navigationItem.titleView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem ItemWithImage:@"MainTagSubIcon"
     HighlightedImage:@"MainTagSubIconClick"
               target:self
               action:@selector(leftButtonClick)];
}

-(void)setupScrollView{
    LLXTopicViewController *All=[[LLXTopicViewController alloc]init];
    All.type=LLXTopicTypeAll;
    All.title=@"全部";
    [self addChildViewController:All];
    
    LLXTopicViewController *Video=[[LLXTopicViewController alloc]init];
    Video.type=LLXTopicTypeVideo;
    Video.title=@"视频";
    [self addChildViewController:Video];
    
    LLXTopicViewController *Voice=[[LLXTopicViewController alloc]init];
    Voice.type=LLXTopicTypeVoice;
    Voice.title=@"声音";
    [self addChildViewController:Voice];
    
    LLXTopicViewController *Picture=[[LLXTopicViewController alloc]init];
    Picture.type=LLXTopicTypePicture;
    Picture.title=@"图片";
    [self addChildViewController:Picture];
    
    LLXTopicViewController *Word=[[LLXTopicViewController alloc]init];
    Word.type=LLXTopicTypeWord;
    Word.title=@"段子";
    [self addChildViewController:Word];
}

-(void)setuptitleView{
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 35)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    CGFloat y=0;
    CGFloat w=self.view.width/self.childViewControllers.count;
    CGFloat h=35;
    self.titleView=titleView;
    //标签栏的提示线
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        CGFloat x=w*i;
        UIButton *titleBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        titleBtn.tag=i;
        titleBtn.frame=CGRectMake(x,y, w, h);
        [titleBtn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
                    [titleBtn layoutIfNeeded];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleBtn];
        
        if (i==0) {
            titleBtn.enabled = NO;
            self.selectedButton = titleBtn;
            // 让按钮内部的label根据文字内容来计算尺寸
            [titleBtn.titleLabel sizeToFit];
            self.indicatorView.width = titleBtn.titleLabel.width;
            self.indicatorView.centerX = titleBtn.centerX;
        }
    }
    [self.view addSubview:titleView];
    [titleView addSubview:indicatorView];
    
}
-(void)setupContentView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *scView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        scView.delegate=self;
    scView.pagingEnabled=YES;
        [self.view insertSubview:scView atIndex:0];
    scView.contentSize=CGSizeMake(self.view.width*self.childViewControllers.count, 0);
    self.contentView=scView;
    [self scrollViewDidEndScrollingAnimation:scView];
}

-(void)titleClick:(UIButton *)sender{
    //
    self.selectedButton.enabled=YES;
    sender.enabled=NO;
    self.selectedButton=sender;
    //动画显示button下面的选择线
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = sender.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

-(void)leftButtonClick
{
    [self.navigationController pushViewController:[[LLXRecommandTagsViewController alloc]init] animated:YES];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    
    UITableViewController *VC=self.childViewControllers[index];
    VC.view.x = scrollView.contentOffset.x;
    VC.view.y=0;
    VC.view.height=scrollView.height;
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    VC.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);
    VC.tableView.scrollIndicatorInsets = VC.tableView.contentInset;
    [scrollView addSubview:VC.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titleView.subviews[index]];
}
@end
