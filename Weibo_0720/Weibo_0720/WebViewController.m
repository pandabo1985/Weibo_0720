//
//  WebViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-12-22.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(id)initWithUrl:(NSString *)url{
    self=[super init];
    if (self) {
        _url = [url copy];
        NSLog(@"load=url==%@",_url);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    self.title = @"载入中...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
#pragma mark -actions
- (IBAction)goBack:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (IBAction)goForward:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}
- (IBAction)reLoad:(id)sender {
    [_webView reload];
}
@end
