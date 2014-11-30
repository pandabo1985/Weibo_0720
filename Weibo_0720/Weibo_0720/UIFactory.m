//
//  UIFactory.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-24.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory

+(ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc] initWithImage:imageName highlightImage:highlightedName];
    return [button autorelease];
}

+(ThemeButton *)createBackgroudButton:(NSString *)imageName backgroudHighlighted:(NSString *)hlightedName
{
    ThemeButton *button = [[ThemeButton alloc] initWithBackgroud:imageName backgroudHighlightbImage:hlightedName];
    return [button autorelease];
}

+(ThemeImageView *)createImageView:(NSString *)imageName{
    ThemeImageView *themeImage = [[ThemeImageView alloc] initWithImageName:imageName];
    return [themeImage autorelease];
}

+(ThemeLabel *)createLabel:(NSString *)colorName{
    ThemeLabel *themeLabel = [[ThemeLabel alloc] initWithColorName: colorName];
    return [themeLabel autorelease];
}
@end
