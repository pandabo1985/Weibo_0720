//
//  UserViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"

@class UserInfoView;
@interface UserViewController : BaseViewController<UITableViewEventDelegate>

@property(nonatomic,copy)NSString *userName;
@property(nonatomic,retain)UserInfoView *userInfo;
@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;

@end
