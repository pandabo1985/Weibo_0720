//
//  ASINetDataService.m
//  Weibo_0720
//
//  Created by pan dabo on 15/1/4.
//  Copyright (c) 2015年 afayear. All rights reserved.
//

#import "ASINetDataService.h"
#import "JSONKit.h"
#define BASE_URL @"https://open.weibo.cn/2/"

@implementation ASINetDataService

+(ASIHTTPRequest *)requestWithUrl:(NSString *)urlstring
                           params:(NSMutableDictionary *)params
                       httpMethod:(NSString *)httpMethod
                    completeBlock:(RequestFinishedBlock) block{
    //token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
   urlstring = [BASE_URL stringByAppendingFormat:@"%@?access_token=%@",urlstring,accessToken];
    //GET
    NSComparisonResult comparRetGet =[httpMethod caseInsensitiveCompare:@"get"];
    if (comparRetGet == NSOrderedSame) {
        NSMutableString *paramsString = [NSMutableString string];
        NSArray *allKeys = [params allKeys];
        for (int i =0 ; i<params.count; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            id value = [params objectForKey:key];
            [paramsString appendFormat:@"%@=%@",key,value];
            if (i<params.count-1) {
                [paramsString appendFormat:@"&"];
            }
            
        }
        if (paramsString.length>0) {
            urlstring = [urlstring stringByAppendingFormat:@"&%@",paramsString];
        }
    }
    NSURL *url = [NSURL URLWithString:urlstring];
   __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:httpMethod];
    NSComparisonResult comparRetPost =[httpMethod caseInsensitiveCompare:@"post"];
    if (comparRetPost == NSOrderedSame) {
        NSArray *allKeys = [params allKeys];
        for (int i = 0; i < params.count; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            id value = [params objectForKey:key];
            if ([value isKindOfClass:[NSData class]]) {
                [request addData:value forKey:key];
            }else{
                [request addPostValue:value forKey:key];
            }
        }
    }
    
    //循环引用
    [request setCompletionBlock:^{
        NSData *data = request.responseData;
        float version = WXHLOSVersion();
        id result = nil;
        if (version>=5.0) {
           result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }else{
            result = [data objectFromJSONData];
        }
        if (block!=nil) {
            block(result);
        }
        
    }];
    [request startAsynchronous];
    return request;
}

@end
