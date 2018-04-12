//
//  GongGao_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongGao_AddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "Bumen_ChooseViewController.h"
@interface GongGao_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,Bumen_ChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contens;
    ZuZhiModel *bumen_model;
    UserModel *user;
}

@end

@implementation GongGao_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"发布公告";
    arr_names =[NSMutableArray arrayWithArray:@[@"公告名称",@"发布对象",@"公告主题",@"公告内容",@"处理时限",@"时限内未审批的责任"]];
    arr_contens =[NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请输入",@"请输入",@"请选择",@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)tijiaoClick{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    [WebRequest Notices_Add_NoticeWithcompanyId:user.companyId noticeName:arr_contens[0] objectType:bumen_model.type objectDepartId:bumen_model.departId noticeTheme:arr_contens[2] noticeContent:arr_contens[3] userGuid:user.Guid duty:arr_contens[5] noticeCycle:arr_contens[4] And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contens.count;
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
    cell.detailTextLabel.text =arr_contens[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==2) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content =arr_contens[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==3 || indexPath.row==5)
    {
        //公告内容 责任
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content=arr_contens[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if ( indexPath.row==1)
    {
        //发布对象
        Bumen_ChooseViewController *Cvc =[[Bumen_ChooseViewController alloc]init];
        Cvc.delegate =self;
        Cvc.indexPath =indexPath;
        [self.navigationController pushViewController:Cvc animated:NO];
    }else
    {
        //处理时限
        UIAlertController *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"1小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"2小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"4小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"8小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"24小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"两个工作日内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"三个工作日内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
       
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getBumenModel:(ZuZhiModel *)model indexPath:(NSIndexPath *)indexPath
{
    bumen_model = model;
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:model.departName];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
