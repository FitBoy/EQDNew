//
//  TongZhi_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TongZhi_addViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "Bumen_ChooseViewController.h"
@interface TongZhi_addViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,Bumen_ChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    ZuZhiModel *model_zuzhi;
}


@end

@implementation TongZhi_addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_names =[NSMutableArray arrayWithArray:@[@"通知名称",@"通知对象",@"通知主题",@"通知内容",@"处理时限",@"时限内未审批的责任"]];
    
    arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",[user.isAdmin integerValue]==0?user.department:@"请选择",@"请输入",@"请输入",@"请选择",@"请输入"]];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(fabuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    model_zuzhi =[[ZuZhiModel alloc]init];
    model_zuzhi.type =@"1";
    model_zuzhi.departId =user.departId;
    model_zuzhi.departName =user.department;
    
}
-(void)fabuClick
{
    //提交
    NSInteger  temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    
    if (temp==0) {
       
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Newss_Add_NewsWithcompanyId:user.companyId newsName:arr_contents[0] objectType:model_zuzhi.type objectDepartId:model_zuzhi.departId newsTheme:arr_contents[2] newsContent:arr_contents[3] userGuid:user.Guid createDepartId:user.departId duty:arr_contents[5] newsCycle:arr_contents[4] isAdmin:user.isAdmin And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
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
    if (indexPath.row==1) {
        cell.accessoryType =[user.isAdmin integerValue]==0?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //通知名称
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.indexPath =indexPath;
            TFvc.delegate =self;
            TFvc.content =arr_contents[indexPath.row];
            TFvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
            break;
        case 1:
        {
            //通知对象
            if ([user.isAdmin integerValue]==0) {
                
            }else
            {
                Bumen_ChooseViewController *Bvc =[[Bumen_ChooseViewController alloc]init];
                Bvc.delegate =self;
                Bvc.indexPath =indexPath;
                [self.navigationController pushViewController:Bvc animated:NO];
            }
        }
            break;
            
        case 2:
        {
            //通知主题
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.indexPath =indexPath;
            TFvc.delegate =self;
            TFvc.content =arr_contents[indexPath.row];
            TFvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }
            break;
        case 3:
        {
//            通知内容
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.content =arr_contents[indexPath.row];
            TVvc.contentTitle=arr_names[indexPath.row];
            TVvc.indexpath =indexPath;
            [self.navigationController pushViewController:TVvc animated:NO];
        }
            break;
        case 4:
        {
//          处理时限
            
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
            
            
        }
            break;
        case 5:
        {
//            责任
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.content =arr_contents[indexPath.row];
            TVvc.contentTitle=arr_names[indexPath.row];
            TVvc.indexpath =indexPath;
            [self.navigationController pushViewController:TVvc animated:NO];

        }
            break;
        default:
            break;
    }
}

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
-(void)getBumenModel:(ZuZhiModel *)model indexPath:(NSIndexPath *)indexPath
{
    
    model_zuzhi =model;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model.departName];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
