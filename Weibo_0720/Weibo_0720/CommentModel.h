//
//  CommentModel.h
//  Weibo_0720
//
//  Created by pan dabo on 14-9-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "WXBaseModel.h"
#import "UserModel.h"
#import "WeiBoModel.h"

@interface CommentModel : WXBaseModel

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,retain)NSNumber *id;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,retain) UserModel *user;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,retain)WeiboModel *weibo;


@end
