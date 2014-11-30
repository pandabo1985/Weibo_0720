//
//  UserViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "WeiboTableView.h"
#import "UserModel.h"
#import "UIFactory.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    _userInfo = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
 
    UIButton *homeBtn = [UIFactory createBackgroudButton:@"tabbar_home.png" backgroudHighlighted:@"tabbar_home_highlighted.png"];
    homeBtn.frame = CGRectMake(0, 0, 34, 27);
    [homeBtn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = [homeItem autorelease];
    
    [self loadUserData];
}

-(void)goHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadUserData{
    if (self.userName.length==0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.userName forKey:@"screen_name"];
    [self.sinaweibo requestWithURL:@"users/show.json" params:params httpMethod:@"GET" block:^(id result){
        [self loadUserDataFinish:result];
    }];
}

-(void)loadUserDataFinish:(NSDictionary *)result{
    UserModel *userModel = [[UserModel alloc] initWithDataDic:result];
    self.userInfo.user = userModel;
    self.tableView.tableHeaderView = _userInfo;
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
