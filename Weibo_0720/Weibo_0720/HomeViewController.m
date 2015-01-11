//
//  HomeViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiBoModel.h"
#import "UIFactory.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"微博";
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //绑定
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账户" style:UIBarButtonItemStyleBordered target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = [bindItem autorelease];
    //注销
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
    self.navigationItem.leftBarButtonItem = [logoutItem autorelease];
    
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-55) style:UITableViewStylePlain];
    _tableView.eventDelegate = self;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    if (self.sinaweibo.isAuthValid) {
        //加载微博列表
        [self loadWeiboData];
    }else{
        [self.sinaweibo logIn];
    }


}

#pragma mark -load data
-(void)loadWeiboData{
    [super showHud];
    [super showLoading:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" delegate:self];
}
//下拉加载微博
-(void)pullDownData{
    if (self.topWeiId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"20",@"count",self.topWeiId,@"since_id",nil];
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" block:^(id result){
        [self pullDownDataFinish:result];
    }];
}

//上拉加载微博
-(void)pullUpData{
    if (self.lastWeiId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"20",@"count",self.lastWeiId,@"max_id",nil];
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" block:^(id result){
        [self pullUpDataFinish:result];
    }];
}

-(void)pullDownDataFinish:(id)result{
    NSArray *statues =  [result objectForKey:@"statuses"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDis in statues) {
        WeiboModel *weibo =[[WeiboModel alloc] initWithDataDic:statuesDis];
        [array addObject:weibo];
        [weibo release];
    }
    if (array.count>0) {
            WeiboModel *weibo =[array objectAtIndex:0];
        self.topWeiId = [weibo.weiboId stringValue];
    }
    if (statues.count>=20) {
        self.tableView.isMore = YES;
    }else {
        self.tableView.isMore = NO;
    }
    [array addObjectsFromArray:self.weibos];
    self.weibos = array;
    self.tableView.data = array;
    
    //刷新
    [self.tableView reloadData];
    [self.tableView doneLoadingTableViewData];
    int updataCount = [statues count];
    [self showNewWeiboCount:updataCount];
    NSLog(@"更新微博条数%d",updataCount);
}

-(void)pullUpDataFinish:(id)result{
    NSArray *statues =  [result objectForKey:@"statuses"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDis in statues) {
        WeiboModel *weibo =[[WeiboModel alloc] initWithDataDic:statuesDis];
        [array addObject:weibo];
        [weibo release];
    }
    if (array.count>0) {
        WeiboModel *weibo =[array lastObject];
        self.lastWeiId = [weibo.weiboId stringValue];
    }
    [self.weibos addObjectsFromArray:array];
    if (statues.count>=20) {
        self.tableView.isMore = YES;
    }else {
        self.tableView.isMore = NO;
    }
    self.tableView.data = self.weibos;
    //刷新
    [self.tableView reloadData];
    
}
#pragma mark 新微博数量
-(void)showNewWeiboCount:(int)count{
    if (barView ==nil) {
        barView = [[UIFactory createImageView:@"timeline_new_status_background.png"] retain];
        UIImage *image = [barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        barView.image = image;
        barView.LeftCapWidth = 5;
        barView.topCapHeight = 5;
        barView.frame = CGRectMake(5, -40, ScreenWidth-10, 40);
        [self.view addSubview:barView];
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 2104;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [barView addSubview:label];
        [label release];
    }
    if (count>0) {
         barView.frame = CGRectMake(5, 40, ScreenWidth-10, 40);
        UILabel *label = (UILabel *)[barView viewWithTag:2104];
        label.text = [NSString stringWithFormat:@"%d条新微博",count];
        [label sizeToFit];
        label.origin = CGPointMake((barView.width-label.width)/2, (barView.height-label.height)/2);
        [UIView animateWithDuration:0.6 animations:^{
            barView.top = 5;
        }completion:^(BOOL finished){
            if (finished) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelay:1];
                [UIView setAnimationDuration:0.6];
                barView.top = -40;
                [UIView commitAnimations];
            }
        }];
        //播放提示声音
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        SystemSoundID soundId;
        
        AudioServicesCreateSystemSoundID((CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
        
    }
    MainViewController *maintCtrl = (MainViewController *)self.tabBarController;
    [maintCtrl showBadge:NO];
}
#pragma mark
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"网络加载失败：%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{   [super hideHud];
    [super showLoading:NO];
    _tableView.hidden =NO;
    NSLog(@"网加载完成：%@",result);
   NSArray *statues =  [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDis in statues) {
        WeiboModel *weibo =[[WeiboModel alloc] initWithDataDic:statuesDis];
        [weibos addObject:weibo];
        [weibo release];
    }
    self.tableView.data = weibos;
    self.weibos = weibos;
    if (weibos.count > 0) {
        WeiboModel *topWeibo = [weibos objectAtIndex:0];
        self.topWeiId = [topWeibo.weiboId stringValue];
        WeiboModel *lastWeibo = [weibos lastObject];
        self.lastWeiId = [lastWeibo.weiboId stringValue];
    }
    if (statues.count>=20) {
        self.tableView.isMore = YES;
    }else {
        self.tableView.isMore = NO;
    }
   
    [self.tableView reloadData];
    NSLog(@"-----%@",weibos);
    
}

#pragma mark
-(void)pullDown:(BaseTableView *)tabelView{
    [self pullDownData];
}
-(void)pullUp:(BaseTableView *)tabelView{
    [self pullUpData];
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboModel *weibo = [self.weibos objectAtIndex:indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.weiboModel = weibo;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark -action
-(void)bindAction:(UIBarButtonItem *)buttonItem{
    [self.sinaweibo logIn];

}

-(void)logoutAction:(UIBarButtonItem *)buttonItem{
    [self.sinaweibo logOut];
   
}

-(void)refreshWeibo{
    [self.tableView refreshData];
    self.tableView.hidden = NO;
    [self pullDownData];
}
#pragma mark -memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.appDelegate.menuCtrl setEnableGesture:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.appDelegate.menuCtrl setEnableGesture:NO];
}

- (void)dealloc {
   
    [super dealloc];
}
@end
