//
//  BaseViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "AppDelegate.h"


@class MBProgressHUD;
@interface BaseViewController : UIViewController{
    UIView *_loadView;
    UIWindow *_tipWindow;
}
@property(nonatomic,assign) BOOL isbackButton;
@property(nonatomic, assign) BOOL isCancelButton;
@property(nonatomic,retain)MBProgressHUD *hub;

-(SinaWeibo *)sinaweibo;

-(void)showLoading:(BOOL)show;
-(void)showHud;
-(void)hideHud;
-(AppDelegate *)appDelegate;

//状态栏提示
-(void)showStatusTip:(BOOL)show title:(NSString *)title;

@end
