//
//  FBWebUrlViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBWebUrlViewController.h"

@interface FBWebUrlViewController ()<UIWebViewDelegate>
{
    UIWebView *webV;
    MBProgressHUD *hud ;
}

@end

@implementation FBWebUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.contentTitle==nil? @"扫描结果":self.contentTitle;
    webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    
    if ([self.url containsString:@"http"] || [self.url containsString:@"https"]) {
        
    }else
    {
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
    
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    webV.delegate = self;
    
    [self.view addSubview:webV];
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self cleanCacheAndCookie];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"请稍等……";
    }

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (hud) {
       [hud hideAnimated:NO];
    }
    
}



@end
