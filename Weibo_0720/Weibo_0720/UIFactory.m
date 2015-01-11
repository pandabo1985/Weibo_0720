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

+(UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL) action{
    ThemeButton *button = [self createBackgroudButton:@"navigationbar_button_background.png" backgroudHighlighted:@"navigationbar_button_delete_background.png"];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    button.LeftCapWidth = 5;
    
    return button;
}
@end
