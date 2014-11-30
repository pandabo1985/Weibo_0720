//
//  CommentCell.m
//  Weibo_0720
//
//  Created by pan dabo on 14-9-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "CommentCell.h"
#import "RTLabel.h"
#import "UIImageView+WebCache.h"
#import "CommentModel.h"
#import "UIUtils.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _userImage = (UIImageView *)[self viewWithTag:100];
    _nickLable = (UILabel *)[self viewWithTag:101];
    _timeLable = (UILabel *)[self viewWithTag:102];
    _commentLable = [[RTLabel alloc] initWithFrame:CGRectZero];
    _commentLable.font = [UIFont systemFontOfSize:14.0f];
    _commentLable.delegate = self;
    _commentLable.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _commentLable.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    [self.contentView addSubview:_commentLable];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *ulrString = self.commentModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:ulrString]];
    _nickLable.text =self.commentModel.user.screen_name;
    _timeLable.text = [UIUtils fomateString:self.commentModel.created_at];
    _commentLable.frame =  CGRectMake(_userImage.right+10, _nickLable.bottom + 5, 240, 21);
    NSString *commentText =self.commentModel.text;
    commentText = [UIUtils parseLink:commentText];
    _commentLable.text = commentText;
    _commentLable.height = _commentLable.optimumSize.height;
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)getCommentHeight:(CommentModel *)commentModel{
    RTLabel *rt = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.font = [UIFont systemFontOfSize:14.0f];
    rt.text = commentModel.text;
    return rt.optimumSize.height;
}

@end
