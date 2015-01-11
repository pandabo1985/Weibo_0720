//
//  WXImageView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-12-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "WXImageView.h"

@implementation WXImageView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];
    }
    return self;
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.touchBlock) {
        _touchBlock();
    }
}

-(void)dealloc{
    [super dealloc];
    Block_release(_touchBlock);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
