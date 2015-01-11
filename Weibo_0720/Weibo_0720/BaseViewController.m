//
//  BaseViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "UIFactory.h"
#import "MBProgressHUD.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isbackButton = YES;
        self.isCancelButton = NO;
    }
    return self;
}

-(SinaWeibo *)sinaweibo{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    return sinaweibo;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count>1&&self.isbackButton) {
        UIButton *button = [UIFactory createButton:@"navigationbar_back.png" highlighted:@"navigationbar_back_highlighted.png"];
        button.showsTouchWhenHighlighted = YES;
        button.frame = CGRectMake(0, 0, 24, 24);
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    if (self.isCancelButton) {
        UIButton *button = [UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(cancleAction)];
        UIBarButtonItem *cancleButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = [cancleButton autorelease];
    }
}

-(void)cancleAction{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//override
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    titleLabel.textColor = [UIColor blackColor];
    UILabel *titleLabel = [UIFactory createLabel:kNavigationBarTitleLabel];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLoading:(BOOL)show{
    if (_loadView==nil) {
        _loadView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight/2-80, ScreenWidth, 20)];
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        UILabel *loadLabel =[[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.text = @"正在加载...";
        loadLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        loadLabel.textColor = [UIColor blackColor];
        [loadLabel sizeToFit];
        loadLabel.left = (320 -loadLabel.width)/2;
        activityView.right = loadLabel.left -5;
        [_loadView addSubview:loadLabel];
        [_loadView addSubview:activityView];
        [activityView release];
    }
    if (show) {
        if (![_loadView superview]) {
            [self.view addSubview:_loadView];
        }    }else{
            [_loadView removeFromSuperview];
        }

}

-(void)showHud{
    self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hub.dimBackground = YES;
}

-(void)showStatusTip:(BOOL)show title:(NSString *)title{
    if (_tipWindow==nil) {
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        tipLabel.textAlignment = UITextAlignmentCenter
        ;
        tipLabel.font = [UIFont systemFontOfSize:13];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor =[UIColor whiteColor];
        tipLabel.tag = 2015;
        [_tipWindow addSubview:tipLabel];
        
    }
    UILabel *tiplabel =(UILabel *)[_tipWindow viewWithTag:2015];
    if (show) {
        _tipWindow.hidden = NO;
        tiplabel.text = title;
    }else{
        _tipWindow.hidden = YES;
        tiplabel.text = title;
        [self performSelector:@selector(removeWindow) withObject:nil afterDelay:1.5];
    }
}

-(void)removeWindow{
    _tipWindow.hidden = YES;
    [_tipWindow release];
    _tipWindow = nil;
}
-(void)hideHud{
    [self.hub hide:YES];
}
-(AppDelegate *)appDelegate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

@end
