//
//  AppDelegate.h
//  Weibo_0720
//
//  Created by one afayear on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MainViewController.h"


@class SinaWeibo;
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)SinaWeibo *sinaweibo;
@property(nonatomic,retain) MainViewController  *mainCtrl;
@property(nonatomic,retain) DDMenuController *menuCtrl;

@end
