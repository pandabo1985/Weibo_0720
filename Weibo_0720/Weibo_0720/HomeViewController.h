//
//  HomeViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"
#import "WeiboTableView.h"
#import "ThemeImageView.h"


@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDelegate>
{
    ThemeImageView *barView;
}
@property(retain, nonatomic)WeiboTableView *tableView;
@property(nonatomic,copy) NSString *topWeiId;
@property(nonatomic,copy) NSString *lastWeiId;
@property(nonatomic,retain)NSMutableArray *weibos;
-(void)refreshWeibo;
-(void)loadWeiboData;
@end
