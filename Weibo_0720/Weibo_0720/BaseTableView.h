//
//  BaseTableView.h
//  Weibo_0720
//
//  Created by pan dabo on 14-9-11.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
@class BaseTableView;

@protocol UITableViewEventDelegate <NSObject>
@optional
-(void)pullDown:(BaseTableView *)tabelView;
-(void)pullUp:(BaseTableView *)tabelView;
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    UIButton *_moreButton;
}

@property(nonatomic, assign)BOOL refreshHeader;//是否需要下拉
@property(nonatomic, retain)NSArray *data;//提供数据
@property(nonatomic, assign)id<UITableViewEventDelegate> eventDelegate;
@property(nonatomic,assign) BOOL isMore;

- (void)doneLoadingTableViewData;

-(void)refreshData;
@end
