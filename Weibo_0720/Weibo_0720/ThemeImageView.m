//
//  ThemeImageView.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-24.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

-(void)awakeFromNib{//xib创建
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidchangedNotification object:nil];
}

-(id)initWithImageName:(NSString *)imageName{
    self = [self init];
    if (self != nil) {
        self.imageName = imageName;
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self!=nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidchangedNotification object:nil];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidchangedNotification object:nil];
    [super dealloc];
}

-(void)themeNotification:(NSNotification *)notification{
    [self loadThemeImage];
}

-(void)loadThemeImage{
    if (self.imageName == nil) {
        return ;
    }else{
        UIImage *image =[[ThemeManager shareInstance] getThemeImage:_imageName];
        image = [image stretchableImageWithLeftCapWidth:self.LeftCapWidth topCapHeight:self.topCapHeight];
        self.image = image;
    }
}
@end
