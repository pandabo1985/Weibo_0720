
//
//  MainViewController.h
//  Weibo_0720
//
//  Created by one afayear on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@class HomeViewController;
@interface MainViewController : UITabBarController<SinaWeiboDelegate,UINavigationControllerDelegate>{
    UIView *_tabbarView;
    UIImageView *_sliderView;
    UIImageView *_badgeView;
    HomeViewController *_homeCtrl;
}

-(void)showBadge:(BOOL)show;
-(void)showTabbr:(BOOL)show;
@end
