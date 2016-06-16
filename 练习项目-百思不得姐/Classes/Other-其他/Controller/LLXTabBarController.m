//
//  LLXTabBarController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTabBarController.h"
#import "LLXEssenceViewController.h"
#import "LLXFriendTrendsViewController.h"
#import "LLXMeViewController.h"
#import "LLXNewViewController.h"
#import "LLXTabBar.h"
#import "LLXNavigationController.h"
@interface LLXTabBarController ()
@end
@implementation LLXTabBarController
+(void)initialize{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs=[NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    
    //  通过appearance统一设置所有UITabBarItem的文字属性
    //  后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象统一设置
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LLXEssenceViewController *essence=[[LLXEssenceViewController alloc]init];
    [self SetupChildController:essence
                         image:@"tabBar_essence_icon"
                 Selectedimage:@"tabBar_essence_click_icon"
                         title:@"精华"];
    
    LLXNewViewController *new=[[LLXNewViewController alloc]init];
    [self SetupChildController:new
                         image:@"tabBar_new_icon"
                 Selectedimage:@"tabBar_new_click_icon"
                         title:@"新帖"];
    
    LLXFriendTrendsViewController *friendTrends=[[LLXFriendTrendsViewController alloc]init];
    [self SetupChildController:friendTrends
                         image:@"tabBar_friendTrends_icon"
                 Selectedimage:@"tabBar_friendTrends_click_icon"
                         title:@"关注"];
    
    LLXMeViewController *Me=[[LLXMeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self SetupChildController:Me
                         image:@"tabBar_me_icon"
                 Selectedimage:@"tabBar_me_click_icon"
                         title:@"我"];
    
    [self setValue:[[LLXTabBar alloc]init] forKeyPath:@"tabBar"];
    
}
-(void)SetupChildController:(UIViewController *)ChildController  image:(NSString *)image Selectedimage:(NSString *)Selectedimage title:(NSString *)title{

            ChildController.tabBarItem.title=title;
            ChildController.tabBarItem.image=[UIImage imageNamed:image];
    ChildController.tabBarItem.selectedImage=
    [[UIImage imageNamed:Selectedimage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LLXNavigationController *nav=[[LLXNavigationController alloc]initWithRootViewController:ChildController];
    [self addChildViewController:nav];
}
@end
