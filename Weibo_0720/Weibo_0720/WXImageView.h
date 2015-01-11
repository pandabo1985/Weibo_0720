//
//  WXImageView.h
//  Weibo_0720
//
//  Created by pan dabo on 14-12-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(void);

@interface WXImageView : UIImageView

@property(nonatomic, copy)ImageBlock touchBlock;

@end
