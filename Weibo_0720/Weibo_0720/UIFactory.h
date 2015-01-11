//
//  UIFactory.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-24.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@interface UIFactory : NSObject


+(ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;

+(ThemeButton *)createBackgroudButton:(NSString *)imageName backgroudHighlighted:(NSString *)hlightedName;

+(ThemeImageView *)createImageView:(NSString *)imageName;
+(ThemeLabel *)createLabel:(NSString *)colorName;

+(UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL) action;

@end
