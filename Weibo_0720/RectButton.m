//
//  RectButton.m
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "RectButton.h"

@implementation RectButton

-(void)layoutSubviews{
    [super layoutSubviews];
    UILabel *title = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)] autorelease];
    title.text = self.title;
    UILabel *subTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 30, 60, 30)] autorelease];
    [self addSubview:title];
    [self addSubview:subTitle];
}

@end
