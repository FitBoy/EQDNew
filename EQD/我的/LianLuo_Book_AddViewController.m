//
//  LianLuo_Book_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LianLuo_Book_AddViewController.h"
#import "FBone_SwitchTableViewCell.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "LianLuoBook_SearchViewController.h"
@interface LianLuo_Book_AddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,LianLuoBook_SearchViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    NSString *isHuiFu;
    Com_UserModel *model_com;
    BOOL canTijiao;
}

@end

@implementation LianLuo_Book_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联络书";
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    arr_names =[NSMutableArray arrayWithArray:@[@"联络人",@"联络书名称",@"主题",@"内容",@"处理时限"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请选择", [NSString stringWithFormat:@"%@联络书",user.company],@"请输入",@"请输入",@"请选择"]];
    
    
    
    
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    isHuiFu =@"0";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString *tstr = dic[Y_ITEMS];
            if(tstr.length!=0)
            {
                canTijiao =YES;
                [arr_contents addObject:dic[Y_ITEMS]];
            }else
            {
                canTijiao=NO;
                [arr_contents addObject:@"无审批人，请联系管理员"];
            }
            [tableV reloadData];
        }
    }];
}
-(void)tijiaoCLick
{
    NSInteger temp=0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"]||[arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    if (temp ==0 && canTijiao ==YES) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        //提交
        [WebRequest  LiaisonBooks_Add_LiaisonBookWithuserGuid:user.Guid companyId:user.companyId departId:user.departId objectCompanyId:model_com.companyId objectDepartId:model_com.departmentId objecter:model_com.guid liaisonBookName:arr_contents[1] liaisonBookTheme:arr_contents[2] liaisonBookContent:arr_contents[3] timeLimit:arr_contents[4] isReply:isHuiFu isLeader:user.isleader And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
 
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents.count:1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
            
        }
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        return cell;
    }
    else
    {
        FBone_SwitchTableViewCell *cell =[[FBone_SwitchTableViewCell alloc]init];
        cell.L_left0.text =@"是否需要回复";
        [cell.S_kaiguan addTarget:self action:@selector(huifuCLick:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    
}
-(void)huifuCLick:(UISwitch*)S_kaiguan
{
    //回复
    isHuiFu = S_kaiguan.isOn==NO?@"0":@"1";
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//@[@"联络人",@"联络书名称",@"主题",@"内容",@"处理时限"]
    if (indexPath.section==0) {
        if (indexPath.row==1 ||indexPath.row==2) {
            //名称
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.indexPath =indexPath;
            TFvc.delegate =self;
            TFvc.content=arr_contents[indexPath.row];
            TFvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }else if (indexPath.row==3)
        {
            //内容
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.contentTitle =arr_names[indexPath.row];
            TVvc.content=arr_contents[indexPath.row];
            TVvc.indexpath =indexPath;
            [self.navigationController pushViewController:TVvc animated:NO];
            
        }else if (indexPath.row==4)
        {
        //处理时限
            UIAlertController *alert =[[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"1小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"2小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"4小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"8小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"24小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"两个工作日内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"三个工作日内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:NO completion:nil];
        }else
        {
            //联络人
            LianLuoBook_SearchViewController *Svc =[[LianLuoBook_SearchViewController alloc]init];
            Svc.delegate =self;
            Svc.indexPath =indexPath;
            [self.navigationController pushViewController:Svc animated:NO];
        }
    }
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)lianluoModel:(Com_UserModel *)model indexpath:(NSIndexPath *)indexPath
{
    model_com =model;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model.name];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
