//
//  EQDR_MyViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_MyViewController.h"
#import "MyFirstTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "FBMyErWeiMaViewController.h"
#import "EQDR_MyWenJiViewController.h"
#import "EQDR_myAttentionViewController.h"
#import "EQDR_FenSiViewController.h"
#import "EQDR_MyArticleTwoViewController.h"
#import "EQDR_MyShoucangViewController.h"
#import "EQDR_LoveViewController.h"
#import "FanKui_ListViewController.h"
@interface EQDR_MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_big;
    NSArray *arr_bigimgs;
    UserModel *user;
}

@end

@implementation EQDR_MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"我的";
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, CGRectGetMinY(self.tabBarController.tabBar.frame)-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_big =@[@[@"个人信息"],@[@"我的文集",@"我的文章",@"我的关注",@"我的粉丝"],@[@"收藏的文章",@"喜欢的文章"],@[@"帮助与反馈",@"设置"]];
    arr_bigimgs=@[@[],@[@"EQDR_wenjianjia",@"EQDR_wenzhang",@"EQDR_guanzhu",@"EQDR_fensi"],@[@"EQDR_shoucang",@"EQDR_zan"],@[@"EQDR_fankui",@"EQDR_shezhi"]];
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray  *tarr = arr_big[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        MyFirstTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[MyFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell.IV_headimg sd_setImageWithURL:[NSURL URLWithString:user.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head.png"]];
        [cell.B_erWeima addTarget:self action:@selector(erWeimaclick) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick)];
        [cell.IV_headimg addGestureRecognizer:tap];
        cell.L_name.text = user.upname;
        cell.L_zhanghao.text = nil;
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        NSArray *tarr = arr_bigimgs[indexPath.section];
        NSArray *tarr2 =arr_big[indexPath.section];
        cell.imageView.image =[UIImage imageNamed:tarr[indexPath.row]];
        cell.textLabel.text =tarr2[indexPath.row];
        return cell;
    }
    
}
-(void)headClick
{
    //创客空间
}
-(void)erWeimaclick{
    NSLog(@"二维码");
    FBMyErWeiMaViewController  *EWMvc =[[FBMyErWeiMaViewController alloc]init];
    EWMvc.hidesBottomBarWhenPushed=YES;
    [self .navigationController pushViewController:EWMvc animated:NO];
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
    if(indexPath.row==0)
    {
        //我的文集
        EQDR_MyWenJiViewController   *WJvc =[[EQDR_MyWenJiViewController alloc]init];
        WJvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:WJvc animated:NO];
    }else if (indexPath.row==1)
    {
        //我的文章
        EQDR_MyArticleTwoViewController  *ATvc =[[EQDR_MyArticleTwoViewController alloc]init];
        ATvc.hidesBottomBarWhenPushed =YES;
        ATvc.userGuid = user.Guid;
        ATvc.articleName = @"我的文章";
        [self.navigationController pushViewController:ATvc animated:NO];
    }else if (indexPath.row==2)
    {
    //我的关注
        EQDR_myAttentionViewController  *Avc =[[EQDR_myAttentionViewController alloc]init];
        Avc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Avc animated:NO];
        
    }else if (indexPath.row==3)
    {
        //我的粉丝
        EQDR_FenSiViewController *Fvc = [[EQDR_FenSiViewController alloc]init];
        Fvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Fvc animated:NO];
        
    }else
    {
        
    }
    }else if (indexPath.section==2)
    {
        if(indexPath.row==0)
        {
            //收藏的文章
            EQDR_MyShoucangViewController  *SCvc =[[EQDR_MyShoucangViewController alloc]init];
            SCvc.type = @"10";
            SCvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:SCvc animated:NO];
        }else if(indexPath.row==1)
        {
            //喜欢的文章
            EQDR_LoveViewController *Lvc =[[EQDR_LoveViewController alloc]init];
            Lvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:Lvc animated:NO];
        }else
        {
            
        }
        
    }else if (indexPath.section==3)
    {
        if(indexPath.row==0)
        {
            //帮助与反馈
            FanKui_ListViewController *Fvc =[[FanKui_ListViewController alloc]init];
            [self.navigationController pushViewController:Fvc animated:NO];
        }else if (indexPath.row==1)
        {
            //设置
        }else
        {
            
        }
    }else
    {
        
    }
}

-(void)leftClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
