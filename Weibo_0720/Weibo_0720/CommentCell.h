//
//  CommentCell.h
//  Weibo_0720
//
//  Created by pan dabo on 14-9-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@class CommentModel;


@interface CommentCell : UITableViewCell<RTLabelDelegate>{
    UIImageView *_userImage;
    UILabel *_nickLable;
    UILabel *_timeLable;
    RTLabel *_commentLable;
}
@property(nonatomic,retain) CommentModel *commentModel; 
+(float)getCommentHeight:(CommentModel *)commentModel;

@end
