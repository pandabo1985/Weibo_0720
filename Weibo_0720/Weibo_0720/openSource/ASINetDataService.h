//
//  ASINetDataService.h
//  Weibo_0720
//
//  Created by pan dabo on 15/1/4.
//  Copyright (c) 2015年 afayear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef void (^RequestFinishedBlock)(id result);

@interface ASINetDataService : NSObject

+(ASIHTTPRequest *)requestWithUrl:(NSString *)urlstring
                           params:(NSMutableDictionary *)params
                       httpMethod:(NSString *)httpMethod
                    completeBlock:(RequestFinishedBlock) block;

@end
