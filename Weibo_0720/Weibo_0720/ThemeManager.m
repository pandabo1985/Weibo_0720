//
//  ThemeManager.m
//  Weibo_0720
//
//  Created by pan dabo on 14-7-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "ThemeManager.h"



static ThemeManager *sigleton = nil;

@implementation ThemeManager


+(ThemeManager *)shareInstance{
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[ThemeManager alloc] init];
        }
    }
    return sigleton;
}

-(id)init{
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themesPlist =[NSDictionary dictionaryWithContentsOfFile:themePath];
        self.themeName = nil;
    }
    return self;
}
//获得主题目录
-(NSString *)getThemePath{
    if (self.themeName==nil) {
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        return resourcePath;
    }else{
        NSString *themePath = [self.themesPlist objectForKey:self.themeName];
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        //完整的主题包目录
        NSString *path = [resourcePath stringByAppendingPathComponent:themePath];
        return path;
    }
}

-(UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    NSString *themePath = [self getThemePath];
    NSString *imagePath=[themePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}
-(void)setThemeName:(NSString *)themeName{
    if (_themeName !=themeName) {
        [_themeName release];
        _themeName = [themeName copy];
    }
    NSString *themeDir = [self getThemePath];
    NSString *filePath = [themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

-(UIColor *)getColorWithName:(NSString *)name{
    if (name.length == 0) {
        return nil;
    }
    NSString *rgb = [_fontColorPlist objectForKey:name];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    if (rgbs.count==3) {
        float r = [rgbs[0] floatValue];
          float g = [rgbs[1] floatValue];
          float  b= [rgbs[2] floatValue];
      UIColor *color =  Color(r, g, b, 1);
        return color;
    }
    
    return nil;
}

//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}


@end
