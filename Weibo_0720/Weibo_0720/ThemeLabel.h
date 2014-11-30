//
//  ThemeLabel.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-27.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy) NSString *colorName;

-(id)initWithColorName:(NSString *)colorName;

@end
