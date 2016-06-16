//
//  LLXCommentCell.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/24.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXCommentCell.h"
#import "LLXComments.h"
#import "UIImageView+WebCache.h"
#import "LLXUser.h"
@interface LLXCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end
@implementation LLXCommentCell

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

-(void)setComment:(LLXComments *)comment
{
    _comment=comment;
    [self.profileImageView setHeader:self.comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    frame.origin.x = LLXTopicCellMargin;
    frame.size.width -= 2 * LLXTopicCellMargin;
}
@end
