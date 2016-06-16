//
//  LLXNewViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/10.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXNewViewController.h"

@interface LLXNewViewController ()

@end

@implementation LLXNewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"新帖";
    self.view.backgroundColor=LLXGlobelColor;
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem ItemWithImage:@"MainTagSubIcon"
                                                         HighlightedImage:@"MainTagSubIconClick"
                                                                   target:self
                                                                   action:@selector(NewButtonClick)];
    
}

-(void)NewButtonClick{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
