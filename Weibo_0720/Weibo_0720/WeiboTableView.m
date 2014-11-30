//
//  weiboTableView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-11.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "weiboTableView.h"
#import "WeiboCell.h"
#import "WeiBoModel.h"
#import "WeiboView.h"

@implementation WeiboTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kReloadWeiboTableNotification object:nil];
    }
    return self;
}

#pragma mark -UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"self.data.count == %ld",self.data.count);
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"WeiboCell";
    WeiboCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    
    cell.weiboModel = weibo;
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    float height =[WeiboView getWeiboHeight:weibo isRepost:NO isDetail:NO];
    height +=60;
    return height;
}

@end
