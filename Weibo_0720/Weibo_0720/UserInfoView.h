//
//  UserInfoView.h
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@class RectButton;

@interface UserInfoView : UIView

@property(retain,nonatomic) UserModel *user;
@property (retain, nonatomic) IBOutlet UIImageView *userImage;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *userAddress;
@property (retain, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (retain, nonatomic) IBOutlet UILabel *userWeiboCount;
@property (retain, nonatomic) IBOutlet RectButton *atButton;
@property (retain, nonatomic) IBOutlet RectButton *fansButton;

@end
