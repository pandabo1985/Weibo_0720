//
//  ThemeButton.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton



-(id)initWithImage:(NSString *)imageName highlightImage:(NSString *)highlightImageName{
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.highligtImageName = highlightImageName;
    }
    return self;
}

-(id)initWithBackgroud:(NSString *)backgroudImageName backgroudHighlightbImage:(NSString *)backgroudHighlightImageName{
    self = [self init];
    if (self) {
        self.backgroudImageName = backgroudImageName;
        self.backgroudHighlightImageName = backgroudHighlightImageName;
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidchangedNotification object:nil];
    }
    return self;
    
}
-(void)themeNotification:(NSNotification *)notification{
    [self loadImage];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidchangedNotification object:nil];
    [super dealloc];
}

-(void)setLeftCapWidth:(int)LeftCapWidth{//复写，为了拉伸
    _LeftCapWidth = LeftCapWidth;
    [self loadImage];
}
-(void)setTopCapHeight:(int)topCapHeight{
    _topCapHeight = topCapHeight;
    [self loadImage];
}
-(void)loadImage{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    UIImage *image = [themeManager getThemeImage:_imageName];
    image = [image stretchableImageWithLeftCapWidth:self.LeftCapWidth topCapHeight:self.topCapHeight];
    UIImage *highlight = [themeManager getThemeImage:_highligtImageName];
     highlight = [highlight stretchableImageWithLeftCapWidth:self.LeftCapWidth topCapHeight:self.topCapHeight];
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highlight forState:UIControlStateHighlighted];
    
    UIImage *backgroudImage = [themeManager getThemeImage:_backgroudImageName];
      backgroudImage = [backgroudImage stretchableImageWithLeftCapWidth:self.LeftCapWidth topCapHeight:self.topCapHeight];
    UIImage *backgroudHighlightImage = [themeManager getThemeImage:_backgroudHighlightImageName];
        backgroudHighlightImage = [backgroudHighlightImage stretchableImageWithLeftCapWidth:self.LeftCapWidth topCapHeight:self.topCapHeight];
    [self setBackgroundImage: backgroudImage forState:UIControlStateNormal];
    [self setBackgroundImage:backgroudHighlightImage forState:UIControlStateHighlighted];
}

#pragma mark -stter
-(void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadImage];
}
-(void)setHighligtImageName:(NSString *)highligtImageName
{
    if (_highligtImageName != highligtImageName) {
        [_highligtImageName release];
        _highligtImageName = highligtImageName;
    }
    [self loadImage];
}
-(void)setBackgroudImageName:(NSString *)backgroudImageName{
    if (_backgroudImageName != backgroudImageName) {
        [_backgroudImageName release];
        _backgroudImageName = backgroudImageName;
    }
    [self loadImage];
}

-(void)setBackgroudHighlightImageName:(NSString *)backgroudHighlightImageName{
    if (_backgroudHighlightImageName != backgroudHighlightImageName) {
        [_backgroudHighlightImageName release];
        _backgroudHighlightImageName = backgroudHighlightImageName;
    }
    [self loadImage];
}
@end
