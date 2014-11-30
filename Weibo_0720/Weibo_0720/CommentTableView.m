//
//  CommentTableView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "CommentModel.h"

@implementation CommentTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
    }
    return self;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *identify = @"CommentCell";
     CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
     if (cell == nil) {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
       
         
     }
     CommentModel *commentModel = [self.data objectAtIndex:indexPath.row];
     cell.commentModel = commentModel;
     
     return cell;
 }

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *commentModel = [self.data objectAtIndex:indexPath.row];
    float h = [CommentCell getCommentHeight:commentModel];
    return h + 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *commentCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    commentCount.backgroundColor = [UIColor clearColor];
    commentCount.font = [UIFont boldSystemFontOfSize:16.0f];
    commentCount.textColor = [UIColor blueColor];
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    commentCount.text = [NSString stringWithFormat:@"评论：%@",total];
    [view addSubview:commentCount];
    [commentCount release];
    UIImageView *separeView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, tableView.width, 1)];
    separeView.image = [UIImage imageNamed:@"userinfo_header_separator.png"];
    [view addSubview:separeView];
    [separeView release];
    return [view autorelease];
}


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
@end
