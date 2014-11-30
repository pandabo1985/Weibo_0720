//
//  ThemeManager.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kThemeDidchangedNotification @"kThemeDidchangedNotification"

@interface ThemeManager : NSObject

@property(nonatomic,retain) NSString *themeName;//当前实用的的主题名称
@property(nonatomic,retain)NSDictionary *themesPlist;

@property(nonatomic,retain)NSDictionary *fontColorPlist;

+(ThemeManager *)shareInstance;
-(UIImage *)getThemeImage:(NSString *)imageName;
-(UIColor *)getColorWithName:(NSString *)name;

@end
