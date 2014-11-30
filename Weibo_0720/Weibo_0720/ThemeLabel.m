//
//  ThemeLabel.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-27.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

-(id)init{
    self = [super init];
    if (self !=nil) {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidchangedNotification object:nil];
    }
    return self;
}

-(void)setColorName:(NSString *)colorName
{
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName copy];
    }
    [self setColor];
}
-(void)themeNotification:(NSNotification *)notification{
    [self setColor];
}

-(id)initWithColorName:(NSString *)colorName{
    self = [self init];
    if (self != nil) {
        self.colorName  =colorName;
    }
    return self;
}

-(void)setColor{
    UIColor *textColor = [[ThemeManager shareInstance] getColorWithName:_colorName];
    self.textColor = textColor;
}
-(void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidchangedNotification object:nil];
    
}
@end
