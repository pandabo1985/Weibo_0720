//
//  ThemeImageView.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-24.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic, assign)int LeftCapWidth;
@property(nonatomic, assign)int topCapHeight;

@property(nonatomic,copy)NSString *imageName;

-(id)initWithImageName:(NSString *)imageName;

@end
