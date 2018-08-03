//
//  LianLuoBook_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LianLuoBook_DetailViewController.h"
#import "FBTwoButtonView.h"
@interface LianLuoBook_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    LianLuoBook_ListModel  *model_detail;
    UserModel *user;
}

@end

@implementation LianLuoBook_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title= @"联络书详情";
    arr_names =[NSMutableArray arrayWithArray:@[@"联络书单编码",@"联络书单名称名称",@"联络书主题",@"联络书内容",@"处理时限",@"是否需要回复",@"创建时间",@"审批时间",@"备注",@"审批人"]];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    // 联络人  被联络人  公司 部门职位
    [WebRequest LiaisonBooks_Get_LiaisonBook_ByIdWithId:self.model.ID And:^(NSDictionary *dic) {
        model_detail =[LianLuoBook_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        arr_contents =[NSMutableArray arrayWithArray:@[model_detail.liaisonBookCode,model_detail.liaisonBookName,model_detail.liaisonBookTheme,model_detail.liaisonBookContent,model_detail.timeLimit,[model_detail.isReply integerValue]==0?@"不需要":@"需要",model_detail.createTime,model_detail.checkTime,model_detail.checkMessage,model_detail.checkerName]];
        [tableV reloadData];
    }];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isShenPi==1 && section==1) {
        return 50;
    
    }
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isShenPi==1 && section==1) {
        FBTwoButtonView *Tview =[[FBTwoButtonView alloc]init];
        [Tview setleftname:@"拒绝" rightname:@"同意"];
        [Tview.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [Tview.B_right addTarget:self action:@selector(tongyiCLick) forControlEvents:UIControlEventTouchUpInside];
        return Tview;
    }
    return nil;
}
-(void)jujueClick
{
    //拒绝
    UIAlertController  *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"拒绝理由";
    }];
    
    [alert  addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert  addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (alert.textFields[0].text.length==0) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"输入内容不能为空";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在拒绝";
            [WebRequest LiaisonBooks_Set_LiaisonBook_CheckWithliaisonBookId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
            
        }
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];

    });
    
}
-(void)tongyiCLick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    [WebRequest LiaisonBooks_Set_LiaisonBook_CheckWithliaisonBookId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
            
        });
    }];
    
    //同意
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section==0?arr_contents.count:arr_contents.count==0?0:2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
        }
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        return cell;
    }else
    {
    static NSString *cellId=@"cellID1";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font=[UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:13];
    }
        if (indexPath.row==0) {
            cell.textLabel.text = [NSString stringWithFormat:@"联络人:%@【%@】",model_detail.createrName,model_detail.createrDepartment];
            cell.detailTextLabel.text =model_detail.createrCompany;
            
        }else
        {
            
            cell.textLabel.text = [NSString stringWithFormat:@"被联络人:%@【%@】",model_detail.objecterName,model_detail.objecDepartName];
            cell.detailTextLabel.text =model_detail.objectCompany;
        }
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
