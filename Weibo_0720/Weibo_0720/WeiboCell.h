//
//  WeiboCell.h
//  Weibo_0720
//
//  Created by pan dabo on 14-8-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;
@class WeiboView;
@class WXImageView;

@interface WeiboCell : UITableViewCell{
//    UIImageView *_userImage;
    WXImageView *_userImage;
    UILabel *_nickLabel;
    UILabel *_repostCountLabel;
    UILabel *_commentLabel;
    UILabel *_sourceLabel;
    UILabel *_createLabel;
}

@property(nonatomic, retain) WeiboModel *weiboModel;
@property(nonatomic, retain) WeiboView *weiboView;

@end
