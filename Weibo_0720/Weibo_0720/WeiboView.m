//
//  WeiboView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-8-21.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "WeiBoModel.h"
#import "UIImageView+WebCache.h"
#import "RTLabel.h"
#import "NSString+URLEncoding.h"
#import "UIUtils.h"
#import "UserViewController.h"
#import "UserModel.h"

#define LIST_FONT 14.0f //列表中字体
#define LIST_REPOST_FONT 13.0f//列表中转发的文本字体
#define DETAIL_FONT 18.0f//详情的文本字体
#define DETAIL_REPOST_FONT 17.0f//详情转发的文本字体


@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)_initView{
    _textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _textLabel.delegate = self;
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    [self addSubview:_textLabel];
    
    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    [self addSubview:_image];
    _repostBackgroudView = [UIFactory createImageView:@"timeline_retweet_background.png"];
    UIImage *image = [_repostBackgroudView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackgroudView.image = image;
    _repostBackgroudView.LeftCapWidth = 25;
    _repostBackgroudView.topCapHeight=10;
    _repostBackgroudView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackgroudView atIndex:0];
    
    _parseText = [[NSMutableString alloc] init];
}
-(void)setWeiboModel:(WeiboModel *)weiboModel
{
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    if (_repostView == nil) {//创建转发微博
        _repostView = [[WeiboView alloc] initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        _repostView.isDetail = self.isDetail;
        [self addSubview:_repostView];
    }
    [self parseLink];
}

-(void)parseLink{
    [_parseText setString:@""];
    if (_isRepost) {
        NSString *nickName = _weiboModel.user.screen_name;
        NSString *encodeName = [nickName URLEncodedString];
        [_parseText appendFormat:@"<a href='user'://%@>%@</a>:",encodeName,nickName];
    }
    NSString *text =_weiboModel.text;
    text =[UIUtils parseLink:text];
    [_parseText appendString:text];
}

//展示数据，设置布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self _renderLabel];
    [self _renderSourceWeiboView];
    
    [self _renderImage];
    
    
    //转发微博背景
    if (self.isRepost) {
        _repostBackgroudView.frame = self.bounds;
        _repostBackgroudView.hidden = NO;
    }else{
        _repostBackgroudView.hidden = YES;
    }
    
}

-(void)_renderLabel{
    float fontSize =[WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLabel.font = [UIFont systemFontOfSize:fontSize];
    _textLabel.frame = CGRectMake(0, 0, self.width, 20);
    //判断是否是转发
    if (self.isRepost) {
        _textLabel.frame = CGRectMake(10, 10, self.width - 10, 0);
    }
    
    //    _textLabel.text = _weiboModel.text;
    _textLabel.text = _parseText;
    CGSize textSize = _textLabel.optimumSize;
    _textLabel.height = textSize.height;
}

-(void)_renderSourceWeiboView{
    WeiboModel *respostWeibo = _weiboModel.relWeibo;
    if (respostWeibo != nil) {
        _repostView.hidden = NO;
        _repostView.weiboModel = respostWeibo;
        float height = [WeiboView getWeiboHeight:respostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame = CGRectMake(0, _textLabel.bottom, self.width, height);
        
    }else{
        _repostView.hidden = YES;
    }
}

-(void)_renderImage{
    //微博图片
    if (self.isDetail) {
        NSString *bmiddleImage =_weiboModel.bmiddleImage;
        if (bmiddleImage!=nil&&![@"" isEqualToString:bmiddleImage]) {
            _image.hidden = NO;
            _image.frame = CGRectMake(10, _textLabel.bottom, 280, 200);
            
            [_image setImageWithURL:[NSURL URLWithString:bmiddleImage]];
        }else{
            _image.hidden = YES;
        }
    }else{
        int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kBrowMode];
        if (mode ==0) {
            mode = SmallBrowMode;
        }
        if (mode == SmallBrowMode) {
            NSString *thumbnailImage =_weiboModel.thumbnailImage;
            if (thumbnailImage!=nil&&![@"" isEqualToString:thumbnailImage]) {
                _image.hidden = NO;
                _image.frame = CGRectMake(10, _textLabel.bottom, 70, 80);
                
                [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
            }else{
                _image.hidden = YES;
            }
        }else if (mode == LargBrowMode){
            NSString *bmiddleImage =_weiboModel.bmiddleImage;
            if (bmiddleImage!=nil&&![@"" isEqualToString:bmiddleImage]) {
                _image.hidden = NO;
                _image.frame = CGRectMake(10, _textLabel.bottom, self.width -20 , 180);
                
                [_image setImageWithURL:[NSURL URLWithString:bmiddleImage]];
            }else{
                _image.hidden = YES;
            }
        }
        
    }
}

//计算微博视图高度
+(CGFloat)getWeiboHeight:(WeiboModel *)weiboModel isRepost:(BOOL) isRepost isDetail:(BOOL) isDetail{
    /**
     * 实现思路，计算每个在试图的高度，然后相加
     **/
    float height = 0;
    //    ----------------计算微博内容text的高度
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    float fontsize = [WeiboView getFontSize:isDetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontsize];
    if (isDetail) {
        textLabel.width = KWeibo_with_Detail;
    }else{
        textLabel.width = KWeibo_with_List;
    }
    
    if (isRepost) {
        textLabel.width-=20;
    }
    
    textLabel.text = weiboModel.text;
    height+=textLabel.optimumSize.height;
    //    ----------------计算微博图片高度
    //微博图片
    if (isDetail) {
        NSString *bmiddleImage =weiboModel.bmiddleImage;
        if (bmiddleImage!=nil&&![@"" isEqualToString:bmiddleImage]) {
            height+=(200+10);
        }else{
            height+=10;
        }
    }else{
          int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kBrowMode];
        if (mode ==0) {
            mode = SmallBrowMode;
        }
        if (mode == SmallBrowMode) {
            NSString *thumbnailImage =weiboModel.thumbnailImage;
            if (thumbnailImage!=nil&&![@"" isEqualToString:thumbnailImage]) {
                height+=(80+10);
            }else{
                height+=10;
            }
        }else if(mode == LargBrowMode){
            NSString *bmiddleImage =weiboModel.bmiddleImage;
            if (bmiddleImage!=nil&&![@"" isEqualToString:bmiddleImage]) {
                height+=(180+10);
            }else{
                height+=10;
            }
        }
       
    }
    //   ----------------------计算转发微博的高度
    WeiboModel *relWeibo = weiboModel.relWeibo;
    if (relWeibo!=nil) {
        float repostHeight =[WeiboView getWeiboHeight:relWeibo isRepost:YES isDetail:isDetail];
        height +=repostHeight;
    }
    
    if (isRepost) {
        height+=30;
    }
    return height;
}

+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost
{
    float fontSize = 14.0f;
    if (!isDetail&&!isRepost) {
        return LIST_FONT;
    }
    else if(!isDetail && isRepost){
        return LIST_REPOST_FONT;
    }else if(isDetail && !isRepost){
        return DETAIL_FONT;
    }else if(isDetail && isRepost){
        return DETAIL_REPOST_FONT;
    }else{
        return fontSize;
    }
    
}
#pragma mark --RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    NSString *absoluteString = [url absoluteString];
    if ([absoluteString hasPrefix:@"user"]) {
        NSString *urlstring = [url host];
        urlstring = [urlstring URLDecodedString];
        UserViewController *userCtrl = [[UserViewController alloc] init];
        userCtrl.userName = [urlstring substringFromIndex:1];
        NSLog(@"panda==%@", userCtrl.userName);
        [self.viewController.navigationController pushViewController:userCtrl animated:YES];
        NSLog(@"用户：%@",urlstring);
    }else if ([absoluteString hasPrefix:@"http"]){
        NSLog(@"链接：%@",[absoluteString URLDecodedString]);
        
    }else if([absoluteString hasPrefix:@"topic"]){
        NSString *urlstring = [url host];
        urlstring = [urlstring URLDecodedString];
        NSLog(@"话题：%@",urlstring);
    }
    
}

@end
