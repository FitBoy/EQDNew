//
//  SC_ComDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_ComDetailViewController.h"
#import <YYText.h>
@interface SC_ComDetailViewController ()
{
    UIScrollView  *ScrollV;
    YYLabel *YL_contents;
    UserModel *user;
}

@end

@implementation SC_ComDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScrollV = [[UIScrollView alloc]init];
    [self.view addSubview:ScrollV];
    self.navigationItem.title = @"企业基本信息";
    user = [WebRequest GetUserInfo];
    [WebRequest ComSpace_ComSpacePerfect_Get_ComSpacePerfectWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        
    }];

}



@end
