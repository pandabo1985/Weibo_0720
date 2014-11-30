//
//  CommentModel.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    NSDictionary *statusDic = [dataDic objectForKey:@"status"];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statusDic];
    self.user = [user autorelease];
    self.weibo = [weibo autorelease];
}

@end
