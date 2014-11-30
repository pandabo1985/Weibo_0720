//
//  MainViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeButton.h"
#import "UIFactory.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initViewController];
    [self _initTabbarView];
    [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化子控制器
-(void)_initViewController{
    _homeCtrl = [[HomeViewController alloc] init];
    MessageViewController *message = [[[MessageViewController alloc] init] autorelease];
    ProfileViewController *profile =[[[ProfileViewController alloc] init] autorelease];
    DiscoverViewController *discover = [[[DiscoverViewController alloc] init] autorelease];
    MoreViewController *more = [[[MoreViewController alloc] init] autorelease];
    
    NSArray *views = @[_homeCtrl,message,profile,discover,more];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:nav];
        [nav release];
        nav.delegate = self;
    }
    self.viewControllers = viewControllers;
}
#pragma mark navigation delegat
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    int count = navigationController.viewControllers.count;
    if (count == 2) {
        [self showTabbr:NO];
    }else if (count ==1){
        [self showTabbr:YES];
    }
}
-(void)_initTabbarView{
    _tabbarView =  [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
//    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    UIImageView *tabbarGroudImage = [UIFactory createImageView:@"tabbar_background.png"];
    tabbarGroudImage.frame = _tabbarView.bounds;
    [_tabbarView addSubview:tabbarGroudImage];
    
    [self.view addSubview:_tabbarView];
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
     NSArray *heightBackgroud = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    for (int i= 0;i<backgroud.count;i++) {
        NSString  *backImage = backgroud[i];
        NSString *heightImage = heightBackgroud[i];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        ThemeButton *button = [[ThemeButton alloc] initWithImage:backImage highlightImage:heightImage];
        UIButton *button = [UIFactory createButton:backImage highlighted:heightImage];
        button.showsTouchWhenHighlighted = YES;
        button.frame = CGRectMake((64-30)/2+(i*64),(49-30)/2, 30, 30);
        button.tag = i;
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    
    _sliderView =[[UIFactory createImageView:@"tabbar_slider.png"] retain];
    _sliderView.backgroundColor = [UIColor clearColor];
    _sliderView.frame = CGRectMake((64-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_sliderView];
}
//事件监听
-(void)selectedTab:(UIButton *)button{
    float x = button.left +(button.width -_sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = x;
    }];
    
    if (button.tag == self.selectedIndex && button.tag ==0) {
//        UINavigationController *homeNav = [self.viewControllers objectAtIndex:0];
//        HomeViewController *homeCtrl = [homeNav.viewControllers objectAtIndex:0];
        [_homeCtrl refreshWeibo];
    }
    
     self.selectedIndex = button.tag;
}

-(void)timerAction:(NSTimer *)timer{
    [self loadUnReadData];
}

#pragma mark -delegate SinaWeiboDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn");
    //保存认证的数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [_homeCtrl loadWeiboData];
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"sinaweiboDidLogOut");
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
        NSLog(@"sinaweiboLogInDidCancel");
}
-(void)refreshUnreadView:(NSDictionary *)result{
        NSNumber *status = [result objectForKey:@"status"];
    if (_badgeView ==nil) {
        _badgeView = [UIFactory createImageView:@"main_badge.png"];
        _badgeView.frame = CGRectMake(64-25, 5, 20, 20);
        [_tabbarView addSubview:_badgeView];
        UILabel *badgeLabel = [[UILabel alloc] initWithFrame:_badgeView.bounds];
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.font = [UIFont systemFontOfSize:13.0f];
        badgeLabel.textColor = [UIColor purpleColor];
        badgeLabel.tag = 120;
        [_badgeView addSubview:badgeLabel];
    }
    int num = [status intValue];
    if (num>0) {
        UILabel *badgeLabel = (UILabel *)[_badgeView viewWithTag:120];
        if (num>99) {
            num = 99;
        }
        badgeLabel.text = [NSString stringWithFormat:@"%d",num];
        _badgeView.hidden = NO;
    }else {
        _badgeView.hidden = YES;
    }
}

-(void)showBadge:(BOOL)show{
    _badgeView.hidden = !show;
}
-(void)showTabbr:(BOOL)show{
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            _tabbarView.left = 0;
        }else{
            _tabbarView.left = -ScreenWidth;
        }
    }];
    
    [self _resizeView:show];
}

-(void)_resizeView:(BOOL)showBarbar{
    for (UIView *subView in self.view.subviews) {
        NSLog(@"view height=  %@",subView);
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (showBarbar) {
                    subView.height = ScreenHeight - 49 -20;
            }else{
                subView.height = ScreenHeight - 20;
            }
        
        }
    }
}
#pragma mark -data
-(void)loadUnReadData{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    [sinaweibo requestWithURL:@"remind/unread_count.json" params:nil httpMethod:@"GET" block:^(id result){
        [self refreshUnreadView:result];
    }];
}

@end
