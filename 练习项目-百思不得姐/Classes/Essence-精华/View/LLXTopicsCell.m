//
//  LLXTopicsCell.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/18.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopicsCell.h"
#import "LLXTopics.h"
#import "UIImageView+WebCache.h"
#import "LLXTopicPictureView.h"
#import "LLXTopicVideoView.h"
#import "LLXTopicVoiceView.h"
#import "LLXComments.h"
#import "LLXUser.h"
@interface LLXTopicsCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *SinaV;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UILabel *CmtLabel;
@property (weak, nonatomic) IBOutlet UIView *CmtView;
- (IBAction)More;

@property(nonatomic,weak) LLXTopicPictureView *pictureView;
@property(nonatomic,weak) LLXTopicVoiceView *VoiceView;
@property(nonatomic,weak) LLXTopicVideoView *VideoView;
@end
@implementation LLXTopicsCell
- (LLXTopicPictureView *)pictureView
{
    if (!_pictureView) {
        LLXTopicPictureView *pictureView = [LLXTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(LLXTopicVideoView *)VideoView
{
    if (!_VideoView) {
        LLXTopicVideoView *VideoView = [LLXTopicVideoView viewFromXib];
        [self.contentView addSubview:VideoView];
        _VideoView =VideoView;
    }
    return _VideoView;
}
-(LLXTopicVoiceView *)VoiceView{
    if (!_VoiceView) {
        LLXTopicVoiceView *VoiceView = [LLXTopicVoiceView viewFromXib];
        [self.contentView addSubview:VoiceView];
        _VoiceView =VoiceView;
    }
    return _VoiceView;
}
- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
}

-(void)setTopic:(LLXTopics *)topic{
    _topic=topic;
    // 设置其他控件
    [self.profileImageView setHeader:topic.profile_image];
    
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.SinaV.hidden=topic.isSina_v;
    self.text_label.text=topic.text;
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    if (topic.type==LLXTopicTypePicture) {
        self.pictureView.topic=topic;
        self.VoiceView.hidden = YES;
        self.VideoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.frame=topic.pictureF;
    }else if (topic.type == LLXTopicTypeVoice){
        self.pictureView.hidden = YES;
        self.VideoView.hidden = YES;
        self.VoiceView.hidden = NO;
        self.VoiceView.topic=topic;
        self.VoiceView.frame=topic.voiceF;
    }else if (topic.type==LLXTopicTypeVideo)
    {   self.VoiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.VideoView.hidden = NO;
        self.VideoView.topic=topic;
        self.VideoView.frame=topic.videoF;
    }else if(topic.type == LLXTopicTypeWord)
    {
        self.pictureView.hidden=YES;
        self.VoiceView.hidden=YES;
        self.VideoView.hidden=YES;
    }
    LLXComments *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.CmtView.hidden = NO;
        self.CmtLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username,cmt.content];
    } else {
        self.CmtView.hidden = YES;
    }
    
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    //    NSString *title = nil;
    //    if (count == 0) {
    //        title = placeholder;
    //    } else if (count > 10000) {
    //        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    //    } else {
    //        title = [NSString stringWithFormat:@"%zd", count];
    //    }
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height =self.topic.cellHeight-LLXTopicCellMargin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (IBAction)More {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];

 
}

@end
