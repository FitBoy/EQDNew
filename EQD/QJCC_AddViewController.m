//
//  QJCC_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QJCC_AddViewController.h"
#import "FBTextFieldViewController.h"
@interface QJCC_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSString *str_name;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
}

@end

@implementation QJCC_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    str_name =[self.type integerValue]==1?@"请假":@"出差";
    arr_names =[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@最小天数",str_name],[NSString stringWithFormat:@"%@最多天数",str_name],[NSString stringWithFormat:@"%@审批等级",str_name]]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请输入"]];
    self.navigationItem.title =[NSString stringWithFormat:@"添加%@设置",str_name ];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(tainjiaClcik)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)tainjiaClcik
{
    NSInteger temp=0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"]) {
            temp=1;
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        [WebRequest  SetUp_Add_LeaveCheckTimeWithuserGuid:user.Guid minTime:arr_contents[0] maxTime:arr_contents[1] companyId:user.companyId approval:arr_contents[2] type:self.type And:^(NSDictionary *dic) {
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
        hud.label.text =@"参数不全";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
    TFvc.indexPath =indexPath;
    TFvc.delegate =self;
    TFvc.content=arr_contents[indexPath.row];
    TFvc.contentTitle =arr_names[indexPath.row];
    if (indexPath.row==2) {
      TFvc.contentTishi =@"一.审批等级最少2级。例：员工请假1天是2级审批，先部门负责人签字同意，再交于人事同意存档。\n 二.3级以上按组织框架来走审批流程";
    }else
    {
     TFvc.contentTishi = @"1. 请假天数范围包括边界。 例：请假范围1~7天，包括1天与7天\n2.请假天数范围设置多少天以上，请将最多天数设置成200以上  例：设置10天以上，设置成最少10天，最多200\n3.设置的天数范围不要交叉，例如，我设置了0~3天，就不能设置0~？，2~？，3~？，这样与0~3的天数出现交叉的情况，可以设置4~？等等。 正常设置实例：0~3，4~7，7~200";
    }
   
    
    [self.navigationController pushViewController:TFvc animated:NO];
}
#pragma  mark - 自定义协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        if ([content intValue]>1) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"必须输入大于等于2的整数";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }else
    {
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
