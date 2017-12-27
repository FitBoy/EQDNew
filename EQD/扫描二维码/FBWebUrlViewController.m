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

@interface FBWebUrlViewController ()
{
    UIWebView *webV;
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
    [self.view addSubview:webV];
}



@end
