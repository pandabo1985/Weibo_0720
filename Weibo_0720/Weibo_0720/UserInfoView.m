//
//  UserInfoView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "UserInfoView.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"
#import "RectButton.h"

@implementation UserInfoView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *userInfoView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
        [self addSubview:userInfoView];
        self.size = userInfoView.size;
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *urlstring = self.user.avatar_large;
    [self.userImage setImageWithURL:[NSURL URLWithString:urlstring]];
    
    self.userName.text = self.user.screen_name;
    NSString *gender = self.user.gender;
    NSString *sexName= @"未知";
    if ([gender isEqualToString:@"f"]){
        sexName = @"女";
    }else if ([gender isEqualToString:@"m"]){
        sexName = @"男";
    }
    NSString *location = self.user.location;
    if (location==nil) {
        location = @"";
    }
    self.userAddress.text = [NSString stringWithFormat:@"%@ %@",sexName,location];
    self.userInfoLabel.text = (self.user.description==nil)?@"":self.user.description;
    NSString *count = [self.user.statuses_count stringValue];
    self.userWeiboCount.text = [NSString stringWithFormat:@"共%@条微博",count];
    //粉丝数
    long followers = [self.user.followers_count longValue];
    NSString *fans = [NSString stringWithFormat:@"%ld",followers];
    if (followers>=10000) {
        followers = followers/10000;
        fans = [NSString stringWithFormat:@"%ld万",followers];
    }
    self.fansButton.title = @"粉丝";
    self.fansButton.subTitle = fans;
    
    self.atButton.title = @"关注";
    long friends = [self.user.friends_count longValue];
    NSString *pen = [NSString stringWithFormat:@"%ld",friends];
    if (friends>=10000) {
        friends = friends/10000;
            pen= [NSString stringWithFormat:@"%ld万",friends];
    }
    self.atButton.subTitle =pen;
   
    
}

- (void)dealloc {
    [_userImage release];
    [_userName release];
    [_userAddress release];
    [_userInfoLabel release];
    [_userWeiboCount release];
    [_atButton release];
    [_fansButton release];
    [super dealloc];
}
@end
