//
//  DetailViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-9-20.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"
#import "CommentTableView.h"
@class WeiboModel;
@class WeiboView;



@interface DetailViewController : BaseViewController<UITableViewEventDelegate>{
    WeiboView *_weiboView;
}
@property (retain, nonatomic) IBOutlet CommentTableView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *userImageView;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;

@property (retain, nonatomic) IBOutlet UIView *userBarView;
@property(nonatomic,retain)WeiboModel *weiboModel;
@end
