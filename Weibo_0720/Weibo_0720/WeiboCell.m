//
//  WeiboCell.m
//  Weibo_0720
//
//  Created by pan dabo on 14-8-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboView.h"
#import "WeiBoModel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "UserViewController.h"

@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}


-(void)_initView{
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImage.backgroundColor = [UIColor clearColor];
    _userImage.layer.cornerRadius = 5;
    _userImage.layer.borderWidth=.5;
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    _userImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickUserImage)];
    [_userImage addGestureRecognizer:singleTap];
    [singleTap release];
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel.backgroundColor = [UIColor clearColor];
    _nickLabel.font =[UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    
    _repostCountLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    
    _commentLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];
    
    _createLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    _createLabel.backgroundColor = [UIColor clearColor];
    _createLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    _sourceLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];

    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    
    UIView *selectedBackgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
    self.selectedBackgroundView=selectedBackgroundView;
    [selectedBackgroundView release];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *userImageUrl =  _weiboModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _weiboModel.user.screen_name;

    
    _weiboView.weiboModel = _weiboModel;
    float h =[WeiboView getWeiboHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nickLabel.bottom+10, KWeibo_with_List, h);
    
    
    NSString *createDate = _weiboModel.createDate;
    if (createDate!=nil) {
             _createLabel.hidden = NO;
    NSString *datestring=[UIUtils fomateString:createDate];
    _createLabel.text= datestring;
    _createLabel.frame = CGRectMake(50, self.height-20, 100, 20);
    [_createLabel sizeToFit];
    }else{
        _createLabel.hidden = YES;
    }
    
    NSString *source = _weiboModel.source;
    NSString *ret = [self parseSource:source];
    if (ret!=nil) {
        _sourceLabel.hidden = NO;
        _sourceLabel.text = [NSString stringWithFormat:@"来自%@",ret];
        _sourceLabel.frame = CGRectMake(_createLabel.right+8, _createLabel.top, 100, 20);
        [_sourceLabel sizeToFit];
    }else{
        _sourceLabel.hidden = YES;
    }
    
}

-(void)onClickUserImage{
    UserViewController *userCtrl = [[UserViewController alloc] init];
    userCtrl.userName = _weiboModel.user.screen_name;

    [self.viewController.navigationController pushViewController:userCtrl animated:YES];
}

-(NSString *)parseSource:(NSString *)source{
    NSString *regex = @">\\w+<";
        NSArray *array = [source componentsMatchedByRegex:regex];
    if (array.count>0) {
        NSString *ret =[array objectAtIndex:0];
        NSRange range;
        range.location=1;
        range.length = ret.length-2;
        NSString *resultstring = [ret substringWithRange:range];
        return resultstring;
    }
    return nil;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
