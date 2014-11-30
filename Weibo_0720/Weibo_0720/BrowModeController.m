//
//  BrowModeController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-23.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BrowModeController.h"

@interface BrowModeController ()

@end

@implementation BrowModeController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"图片浏览模式";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    if (indexPath.row ==0) {
        cell.textLabel.text =@"大图";
        cell.detailTextLabel.text=@"所有网络加载大图";
    }else if(indexPath.row==1){
        cell.textLabel.text =@"小图";
        cell.detailTextLabel.text=@"所有网络加载小图";
    }
    return cell;
}

#pragma mark UITableView UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int mode = -1;
    if (indexPath.row==0) {
        mode = SmallBrowMode;
    }else if(indexPath.row ==1){
        mode = LargBrowMode;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:mode forKey:kBrowMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadWeiboTableNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
