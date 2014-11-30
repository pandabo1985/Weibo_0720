//
//  ThemeButton.h
//  Weibo_0720
//
//  Created by pan dabo on 14-7-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *highligtImageName;

@property(nonatomic,copy)NSString *backgroudImageName;
@property(nonatomic,copy)NSString *backgroudHighlightImageName;

-(id)initWithImage:(NSString *)imageName highlightImage:(NSString *)highlightImageName;

-(id)initWithBackgroud:(NSString *)backgroudImageName backgroudHighlightbImage:(NSString *)backgroudHighlightImageName;
@end
