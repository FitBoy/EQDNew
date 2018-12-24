//
//  YaoQingRegisterViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/30.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "YaoQingRegisterViewController.h"
#import "EQD_HtmlTool.h"
#import "FBTwoButtonView.h"
#import "FB_ShareEQDViewController.h"
#import "LookPersonViewController.h"

@interface YaoQingRegisterViewController ()
{
    UIWebView *webView;
}
@end

@implementation YaoQingRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"邀请注册";
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-50-kBottomSafeHeight-DEVICE_TABBAR_Height)];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[EQD_HtmlTool getEQDM_ArticleDetailWithId:@"357"]]]];
    FBTwoButtonView  *twoBtn  =[[FBTwoButtonView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-50-kBottomSafeHeight, DEVICE_WIDTH, 50)];
    [twoBtn setleftname:@"已邀请的人" rightname:@"邀请好友注册"];
    
    [twoBtn.B_left setTitle:@"已邀请的人" titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:21]];
    [twoBtn.B_right  setTitle:@"邀请好友注册" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:49/255.0 green:72/255.0 blue:196/255.0 alpha:1] font:[UIFont systemFontOfSize:21]];
    
    [self.view addSubview:twoBtn];
    
    [twoBtn.B_right  addTarget:self action:@selector(yaoQingClick) forControlEvents:UIControlEventTouchUpInside];
    [twoBtn.B_left addTarget:self action:@selector(PersonYaoQing) forControlEvents:UIControlEventTouchUpInside];
    twoBtn.B_left.layer.borderWidth=1;
    twoBtn.B_left.layer.borderColor = [UIColor grayColor].CGColor;
}
///查看已邀请的人
-(void)PersonYaoQing
{
    LookPersonViewController  *LPvc = [[LookPersonViewController alloc]init];
    LPvc.temp = 0;
    [self.navigationController pushViewController:LPvc animated:NO];
}
-(void)yaoQingClick
{
    FB_ShareEQDViewController  *Svc = [[FB_ShareEQDViewController alloc]init];
    Svc.providesPresentationContextTransitionStyle = YES;
    Svc.definesPresentationContext = YES;
    Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    Svc.EQD_ShareType = EQD_ShareTypeLink;
    Svc.text = [EQD_HtmlTool getAppDownload];
    Svc.sourceOwner = @"邀请注册";
    [self presentViewController:Svc animated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
