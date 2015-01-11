//
//  NearByViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-12-29.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SelectDownBlock)(NSDictionary *);

@interface NearByViewController : BaseViewController<UITabBarDelegate,UITableViewDataSource,CLLocationManagerDelegate,UITableViewDelegate>
@property(nonatomic, retain)NSArray *data;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (copy,nonatomic) SelectDownBlock selectBlock;

@end
