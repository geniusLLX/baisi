//
//  LLXFriendTrendsViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXFriendTrendsViewController.h"
#import "LLXRecommandViewController.h"
#import "LLXLoginRegisterViewController.h"
@interface LLXFriendTrendsViewController ()
- (IBAction)loginRegister;

@end

@implementation LLXFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的关注";
    self.view.backgroundColor=LLXGlobelColor;
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem ItemWithImage:@"friendsRecommentIcon"
                                                        HighlightedImage:@"friendsRecommentIcon-click"
                                                                  target:self
                                                                  action:@selector(FriendButtonClick)];

}
-(void)FriendButtonClick{
    LLXRecommandViewController *RVC=[[LLXRecommandViewController alloc]init];
    [self.navigationController pushViewController:RVC animated:YES];
}


- (IBAction)loginRegister {
    [self presentViewController:[[LLXLoginRegisterViewController alloc]init] animated:YES completion:^{
        
    }];
}
@end
