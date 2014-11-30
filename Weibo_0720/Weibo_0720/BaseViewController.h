//
//  BaseViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"


@class AppDelegate;
@class MBProgressHUD;
@interface BaseViewController : UIViewController{
    UIView *_loadView;
}
@property(nonatomic,assign) BOOL isbackButton;
@property(nonatomic,retain)MBProgressHUD *hub;

-(SinaWeibo *)sinaweibo;

-(void)showLoading:(BOOL)show;
-(void)showHud;
-(void)hideHud;
-(AppDelegate *)appDelegate;

@end
