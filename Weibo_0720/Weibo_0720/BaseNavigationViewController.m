//
//  BaseNavViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "ThemeManager.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidchangedNotification  object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadThemeImage];
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    swipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGesture];
    [swipGesture release];
//    float version = WXHLOSVersion();
//    if (version>=5.0) {
//        UIImage *image = [UIImage imageNamed:@"navigationbar_background.png"];
//        [self.navigationBar setBackgroundImage:(UIImage *)image forBarMetrics:UIBarMetricsDefault];
//    }
//    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [self.navigationBar setBackgroundImage:<#(UIImage *)#> forBarMetrics:<#(UIBarMetrics)#>]
//    };
}

-(void)swipAction:(UISwipeGestureRecognizer *)gesture{
    if (self.viewControllers.count>1) {
        if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
            [self popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidchangedNotification object:nil];
}

-(void)themeNotification:(NSNotification *)notification{
    [self loadThemeImage];
    
}

-(void)loadThemeImage{
    
    float version = WXHLOSVersion();
    if (version>=5.0) {
         UIImage *image = [[ThemeManager shareInstance] getThemeImage:@"navigationbar_background.png"];
        [self.navigationBar setBackgroundImage:(UIImage *)image forBarMetrics:UIBarMetricsDefault];
    }else{
        //调用渲染引擎
        [self.navigationBar setNeedsDisplay];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
