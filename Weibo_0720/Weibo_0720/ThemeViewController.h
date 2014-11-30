//
//  ThemeViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *themes;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
