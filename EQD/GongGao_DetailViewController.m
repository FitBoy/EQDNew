//
//  GongGao_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongGao_DetailViewController.h"
#import "LoadWordViewController.h"
#import "FBTwoButtonView.h"
@interface GongGao_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    GongGao_ListModel *model_detail;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation GongGao_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"详情";
    arr_names =[NSMutableArray arrayWithArray:@[@"公告单编码",@"公告名称",@"发布对象",@"公告主题",@"公告内容",@"处理时限",@"责任",@"发布人",@"审核人",@"创建时间",@"审核时间",@"备注"]];
    [WebRequest Notices_Get_Notice_ByIdWithnoticeId:self.model.ID And:^(NSDictionary *dic) {
        model_detail =[GongGao_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        
        arr_contents =[NSMutableArray arrayWithArray:@[model_detail.noticeCode,model_detail.noticeName,[model_detail.objectType integerValue]==0?@"全体员工":model_detail.department,model_detail.noticeTheme,model_detail.noticeContent,model_detail.noticeCycle,model_detail.duty,model_detail.createrName,model_detail.checkerName,model_detail.checkTime,model_detail.checkMessage]];
        [tableV reloadData];
    }];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
   
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.isShenpi==1?50:1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isShenpi==1) {
        FBTwoButtonView *twoView =[[FBTwoButtonView alloc]init];
        [twoView setleftname:@"拒绝" rightname:@"同意"];
        [twoView.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [twoView.B_right addTarget:self action:@selector(tongyiCLick) forControlEvents:UIControlEventTouchUpInside];
        
        return twoView;
    }else
    {
        return nil;
    }
}
-(void)jujueClick
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由'" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"拒绝理由";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(alert.textFields[0].text.length==0)
        {
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
            [WebRequest Notices_Set_Notice_CheckWithnoticeId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
        }
    }]];
    
  
}
-(void)tongyiCLick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    [WebRequest Notices_Set_Notice_CheckWithnoticeId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    if (indexPath.row==4 || indexPath.row==6) {
        LoadWordViewController *LWvc =[[LoadWordViewController alloc]init];
        LWvc.content =arr_contents[indexPath.row];
        LWvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:LWvc animated:NO];
    }
}



@end
