//
//  ImageModeControl.h
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageModeControl : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageModes;
}
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@end
