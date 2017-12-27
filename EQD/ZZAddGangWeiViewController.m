//
//  ZZAddGangWeiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZZAddGangWeiViewController.h"
#import "FBTextFieldViewController.h"
#import "FBJobViewController.h"
#import "FBone_SwitchTableViewCell.h"
@interface ZZAddGangWeiViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBJobViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_gangwei;
    NSMutableArray *arr_contents;
    NSString *shenpi;
    UserModel *user;
}

@end

@implementation ZZAddGangWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定添加" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    [self.navigationItem setRightBarButtonItem:right];

    arr_gangwei =[NSMutableArray arrayWithArray:@[@"所属部门",@"岗位",@"岗位类别"]];
    arr_contents=[NSMutableArray arrayWithArray:@[self.model.departName,@"请输入",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(editCancelClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    shenpi =@"false";
}
-(void)tianjiaCLick
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在创建";
    
    [WebRequest Com_CreatePostWithcompanyId:self.model.CompanyId departId:self.model.departId name:arr_contents[1] type:arr_contents[2] desc:@"职位ios" isleader:shenpi userGuid:user.Guid And:^(NSDictionary *dic) {
        NSString *msg =dic[Y_MSG];
        hud.label.text =msg;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
        
    }];
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_gangwei.count:1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        cell.textLabel.text =arr_gangwei[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        
        return cell;
    }
    else
    {
        FBone_SwitchTableViewCell *cell = [[FBone_SwitchTableViewCell alloc]init];
        cell.L_left0.text = @"是否具有审批功能";
        [cell.S_kaiguan addTarget:self action:@selector(kaiguanClick:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)kaiguanClick:(UISwitch*)S_switch
{
  shenpi= S_switch.on==NO?@"false":@"true";
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath=indexPath;
            TFvc.contentTitle =arr_gangwei[indexPath.row];
            TFvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
       else if (indexPath.row==2) {
            //岗位
            FBJobViewController *Jvc =[[FBJobViewController alloc]init];
            Jvc.indexPath=indexPath;
            Jvc.delegate=self;
            
            [self.navigationController pushViewController:Jvc animated:NO];
            
        }
        else
        {
            
        }

    }
    else
    {
        
    }
    }

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
}
-(void)model:(AllModel *)model indexPath:(NSIndexPath *)indexpath
{
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:model.child_name];
    [tableV reloadData];
}
@end
