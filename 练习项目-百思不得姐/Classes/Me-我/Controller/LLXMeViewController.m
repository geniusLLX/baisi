//
//  LLXMeViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXMeViewController.h"
#import "LLXMeCell.h"
#include "LLXMeFootView.h"
@interface LLXMeViewController ()

@end
@implementation LLXMeViewController
static NSString *me=@"me";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    [self setupFootView];
}
-(void)setupNav{
    self.navigationItem.title=@"我";
    self.view.backgroundColor=LLXGlobelColor; 
    self.navigationItem.rightBarButtonItems=@[[UIBarButtonItem ItemWithImage:@"mine-setting-icon"
                                                            HighlightedImage:@"mine-setting-icon-click"
                                                                      target:self
                                                                      action:@selector(SettingButtonClick)]
                                              ,
                                              [UIBarButtonItem ItemWithImage:@"mine-moon-icon"
                                                            HighlightedImage:@"mine-moon-icon-click"
                                                                      target:self
                                                                      action:@selector(NightModeButtonClick)]
                                              ];
    [self.tableView registerClass:[LLXMeCell class] forCellReuseIdentifier:me];
    
}
-(void)setupTableView
{
    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionFooterHeight=LLXTopicCellMargin;
    self.tableView.contentInset=UIEdgeInsetsMake(10-LLXTitilesViewH, 0, 0, 0);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)setupFootView
{
    self.tableView.tableFooterView=[[LLXMeFootView alloc]init];
}
-(void)SettingButtonClick{
    
}
-(void)NightModeButtonClick{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:me];
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:@"mine-icon-nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
        return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    self.tableView.contentSize =CGSizeMake(self.tableView.tableFooterView.size.width, self.tableView.tableFooterView.frame.size.height+self.tableView.tableFooterView.frame.origin.y);
}
@end
