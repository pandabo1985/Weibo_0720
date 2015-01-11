//
//  RightViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "RightViewController.h"
#import "SendViewController.h"
#import "BaseNavigationViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

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
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAction:(UIButton *)sender {
    if (sender.tag==100) {
        SendViewController *sendCtrl = [[SendViewController alloc] init];
        BaseNavigationViewController *sendNav = [[BaseNavigationViewController alloc] initWithRootViewController:sendCtrl];
        [self.appDelegate.menuCtrl presentViewController:sendNav animated:YES completion:NULL];
//        [self presentViewController:sendNav animated:YES completion:NULL];
        [sendCtrl release];
        [sendNav release];
        
    }
}
@end
