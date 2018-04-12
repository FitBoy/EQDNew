//
//  TB_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TB_AddViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "PBanBieModel.h"
#import "FBTextVViewController.h"
#import "BB_List_DetailViewController.h"
@interface TB_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,BB_List_DetailViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    BanbieModel *model_select;
    NSString *shenpi_ren;
    BOOL canTijiao;
}

@end

@implementation TB_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"所在班别",@"要调班别",@"调班原因"]];
    self.navigationItem.title =[NSString stringWithFormat:@"%@调班申请单",user.company];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    [WebRequest Get_User_ShiftWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            PBanBieModel   *Pmodel =[PBanBieModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            
            NSString *str =@"请输入";
            if ([USERDEFAULTS objectForKey:@"TB_Add"]) {
                str =[USERDEFAULTS objectForKey:@"TB_Add"];
            }
            arr_contents =[NSMutableArray arrayWithArray:@[Pmodel.ruleName,@"请选择",str]];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            
            NSString *tstr =dic[Y_ITEMS];
            if (tstr.length!=0) {
                canTijiao =YES;
                shenpi_ren =dic[Y_ITEMS];
        }else
        {
            canTijiao =NO;
            shenpi_ren =@"您是最高领导人";
        }
         [tableV reloadData];
        }
    }];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)TijiaoClick
{
   
    if ([arr_contents[2] isEqualToString:@"请输入"] || canTijiao ==NO ) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"调班原因必须有";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
    [WebRequest Add_ChangeShiftWithcompanyId:user.companyId userGuid:user.Guid changeShiftId:model_select.Id changeShiftReason:arr_contents[2] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [USERDEFAULTS removeObjectForKey:@"TB_Add"];
            [USERDEFAULTS synchronize];
             hud.label.text =@"提交成功，等待审核";
        }
       else
       {
           hud.label.text =@"服务器错误";
       }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return shenpi_ren==nil?2:3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return arr_contents.count;
    }else
    {
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left.text =user.username;
        cell.L_right0.text =[NSString stringWithFormat:@"%@-%@",user.department,user.post];
        cell.L_right1.text =[NSString stringWithFormat:@"工号:%@",user.jobNumber];
        return cell;
    } else if (indexPath.section==2)
    {
        static NSString *cellId=@"cellID1";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
        cell.L_left0.text =@"审批人";
        cell.L_right0.text =shenpi_ren;
       
        
        return cell;
    }
    
    else {
        static NSString *cellId=@"cellID1";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
        if (indexPath.row==0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            //班别
            BB_List_DetailViewController *Dvc =[[BB_List_DetailViewController alloc]init];
            Dvc.indexPath =indexPath;
            Dvc.delegate =self;
            
            [self.navigationController pushViewController:Dvc animated:NO];
          
        }else if(indexPath.row==2)
        {
           //调班原因
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.indexpath =indexPath;
            TVvc.contentTitle =arr_names[indexPath.row];
            TVvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }
        else
        {
            
        }
    }
}

#pragma  mark - 自定义的协议代理

-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)model:(BanbieModel *)model indexPath:(NSIndexPath *)indexPath
{
    model_select =model;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model.ruleName];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULTS setObject:arr_contents[2] forKey:@"TB_Add"];
    [USERDEFAULTS synchronize];
}

@end
