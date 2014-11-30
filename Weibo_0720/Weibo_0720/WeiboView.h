//
//  WeiboView.h
//  Weibo_0720
//
//  Created by pan dabo on 14-8-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "ThemeImageView.h"
#import "RegexKitLite.h"

#define KWeibo_with_List (320-60)
#define KWeibo_with_Detail 300

@class WeiboModel;
@interface WeiboView : UIView<RTLabelDelegate>{
    @private
    RTLabel *_textLabel;
    UIImageView *_image;
    ThemeImageView *_repostBackgroudView;
    WeiboView *_repostView;
    NSMutableString *_parseText;
}

@property(nonatomic, retain)WeiboModel *weiboModel;

@property(nonatomic, assign) BOOL isRepost;//是否是转发的微博
@property(nonatomic, assign) BOOL isDetail;//是否显示在详情里面


+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;
//计算微博视图高度
+(CGFloat)getWeiboHeight:(WeiboModel *)weiboModel isRepost:(BOOL) isRepost isDetail:(BOOL) isDetail;

@end
