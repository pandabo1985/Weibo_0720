//
//  DetailViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "WeiboView.h"
#import "WeiBoModel.h"
#import "CommentTableView.h"
#import "CommentModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initView];
    [self loadData];
}

-(void)_initView{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    self.userImageView.layer.cornerRadius = 5;
    self.userImageView.layer.masksToBounds = YES;
    NSString *userImageUrl = _weiboModel.user.profile_image_url;
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    self.nickLabel.text = _weiboModel.user.screen_name;
    
    [tableHeaderView addSubview:self.userBarView];
    tableHeaderView.height +=60;

    float h = [WeiboView getWeiboHeight:self.weiboModel isRepost:NO isDetail:YES];
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(10, _userBarView.bottom+10, ScreenWidth - 20, h)];
    _weiboView.isDetail = YES;
    _weiboView.weiboModel = _weiboModel;
    self.tableView.eventDelegate = self;
    [tableHeaderView addSubview:_weiboView];
    tableHeaderView.height += (h+10);
    
    self.tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView release];
}


-(void)loadData{
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    if (weiboId.length==0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:weiboId forKey:@"id"];
    [self.sinaweibo requestWithURL:@"comments/show.json" params:params httpMethod:@"GET" block:^(NSDictionary *ret){
        [self loadDataFinished:ret];
    }];
}
-(void)loadDataFinished:(NSDictionary *)ret{
    NSArray *array = [ret objectForKey:@"comments"];
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:dic];
        [comments addObject:commentModel];
        [commentModel release];
    }
    if (array.count>=20) {
        self.tableView.isMore = YES;
    }else {
        self.tableView.isMore = NO;
    }
    self.tableView.data = comments;
    self.tableView.commentDic = ret;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark delegat
-(void)pullDown:(BaseTableView *)tabelView{
    [tabelView performSelector:@selector(doneLoadTableViewData) withObject:nil afterDelay:2];
}
-(void)pullUp:(BaseTableView *)tabelView{
    [tabelView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_userImageView release];
    [_nickLabel release];
    [_userBarView release];
    [super dealloc];
}
@end
