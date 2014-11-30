//
//  BaseTableView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-11.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];//代码创建
    }
    return self;
}
-(void)awakeFromNib{//nib创建
    [self _initView];
}

-(void)_initView{
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    self.dataSource = self;
    self.delegate = self;
    
    self.refreshHeader = YES;
    
    _moreButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _moreButton.backgroundColor  = [UIColor clearColor];
    _moreButton.frame = CGRectMake(0, 0, ScreenWidth, 40);
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.tag = 100;
    activityView.frame = CGRectMake(100, 10, 20, 20);
    [activityView stopAnimating];
    [_moreButton addSubview:activityView];
    self.tableFooterView = _moreButton;
    
}

-(void)_starLoadMore{
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_moreButton viewWithTag:100];
    [activityView startAnimating];
}

-(void)_stopLoadMore{
    if (self.data.count > 0) {
        _moreButton.hidden = NO;
    [_moreButton setTitle:@"上拉加载更多" forState:UIControlStateNormal];
    _moreButton.enabled = YES;
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_moreButton viewWithTag:100];
    [activityView stopAnimating];
        if(!self.isMore){
            _moreButton.enabled = NO;
             [_moreButton setTitle:@"加载完成" forState:UIControlStateNormal];
        }
    
    }else{
        _moreButton.hidden = YES;
    }

}

-(void)reloadData{
    [super reloadData];
    [self _stopLoadMore];
}
#pragma mark loadmore action
-(void)loadMoreAction{
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
        [self _starLoadMore];
    }
}
-(void)setRefreshHeader:(BOOL)refreshHeader{
    _refreshHeader = refreshHeader;
    if (_refreshHeader) {
          [self addSubview:_refreshHeaderView];
    }else {
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self ];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if (!self.isMore) {
        return;
    }
    float offset =scrollView.contentOffset.y;
    float contentHeight = scrollView.contentSize.height;
    NSLog(@"offset = %f",offset);
    NSLog(@"contentHeight = %f",contentHeight);
    float sub = contentHeight - offset;
    if (sub - scrollView.height > 30) {
        [self _starLoadMore];
        if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
            [self.eventDelegate pullUp:self];
        }
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
//    //停止加载，弹回下拉
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
         [self.eventDelegate pullDown:self];
    }

	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]autorelease];
    return cell;
}


- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

-(void)refreshData{
    [_refreshHeaderView refreshLastUpdatedDate];
}


@end
