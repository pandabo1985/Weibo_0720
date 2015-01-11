//
//  WebViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-12-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>{
    NSString *_url;
}

-(id)initWithUrl:(NSString *)url;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;


- (IBAction)reLoad:(id)sender;

@end
