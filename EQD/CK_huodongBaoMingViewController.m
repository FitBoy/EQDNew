//
//  CK_huodongBaoMingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_huodongBaoMingViewController.h"

@interface CK_huodongBaoMingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
}

@end

@implementation CK_huodongBaoMingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Activity_Get_BaoMingActiveWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    page=@"0";
}



@end
