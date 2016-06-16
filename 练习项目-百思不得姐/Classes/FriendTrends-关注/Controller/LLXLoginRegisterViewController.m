//
//  LLXLoginRegisterViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/17.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXLoginRegisterViewController.h"

@interface LLXLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *LoginView;
- (IBAction)MoveRegisterView:(UIButton *)sender;
- (IBAction)Finish:(id)sender;
- (IBAction)BackBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@property (weak, nonatomic) IBOutlet UIView *LoginFirst;

@end

@implementation LLXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.BackgroundImageView atIndex:0];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)MoveRegisterView:(UIButton *)sender {
    self.loginViewLeftMargin.constant=self.view.width;
                
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)Finish:(id)sender {
    
        self.loginViewLeftMargin.constant=0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)BackBtn {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
