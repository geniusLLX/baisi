//
//  UIImageView+LLXExtention.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/25.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "UIImageView+LLXExtention.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LLXExtension.h"
@implementation UIImageView (LLXExtention)
-(void)setHeader:(NSString *)url
{
    UIImage *placeHolderImage=[[UIImage imageNamed:@"defaultUserIcon"] circleimage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image =image  ? [image circleimage] :placeHolderImage;
    }];
}
@end
