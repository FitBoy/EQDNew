//
//  ZZDAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZZDAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBOptionViewController.h"
@interface ZZDAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_gangwei;
    NSMutableArray *arr_gangwei_content;
    NSMutableArray *arr_yaoqiu;
    NSMutableArray *arr_yaoqiu_content;
}

@end

@implementation ZZDAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"岗位职责描述";
    arr_gangwei = [NSMutableArray arrayWithArray:@[@"岗位名称",@"所属部门",@"工作性质",@"薪资范围",@"工作描述"]];
//    arr_gangwei_content = [NSMutableArray arrayWithArray:@[self.model.careename,_model.postname,@"请选择",@"请选择",@"请输入"]];
  
    arr_yaoqiu = [NSMutableArray arrayWithArray:@[@"学历",@"工作经验",@"年龄",@"性别",@"专业技能",@"岗位类别"]];
    arr_yaoqiu_content = [NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请输入",@"请选择",@"请输入",@"请选择"]];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, DEVICE_HEIGHT-20) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(editCancelClick)];
    [self.navigationItem setLeftBarButtonItem:left];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==0? @"岗位信息":@"岗位要求";
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_gangwei.count;
    }
    return arr_yaoqiu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0) {
        if (indexPath.row<2) {
             cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text =arr_gangwei[indexPath.row];
        cell.detailTextLabel.text =arr_gangwei_content[indexPath.row];
    }
    else
    {
        cell.textLabel.text =arr_yaoqiu[indexPath.row];
        cell.detailTextLabel.text = arr_yaoqiu_content[indexPath.row];
        
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 2:
            {
               //工作性质
                UIAlertController  *alert = [[UIAlertController alloc]init];
                [alert addAction:[UIAlertAction actionWithTitle:@"全职" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"兼职" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];

                [alert addAction:[UIAlertAction actionWithTitle:@"临时工" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];

                [alert addAction:[UIAlertAction actionWithTitle:@"实习生" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];

                [alert addAction:[UIAlertAction actionWithTitle:@"不限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];

                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];

                
                [self presentViewController:alert animated:NO completion:nil];
                
            }
                break;
            case 3:
            {
              //薪资范围
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.indexPath =indexPath;
                TFvc.delegate =self;
                TFvc.content = arr_gangwei_content[indexPath.row];
                TFvc.contentTitle =arr_gangwei[indexPath.row];
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
                break;
            case 4:
            {
               //工作描述
                FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
                TVvc.indexpath =indexPath;
                TVvc.delegate =self;
                TVvc.content =arr_gangwei_content[indexPath.row];
                TVvc.contentTitle =arr_gangwei[indexPath.row];
                [self.navigationController pushViewController:TVvc animated:NO];
                
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {//学历
                FBOptionViewController *Ovc=[[FBOptionViewController alloc]init];
                Ovc.delegate =self;
                Ovc.indexPath =indexPath;
                Ovc.option=5;
                Ovc.contentTitle =arr_yaoqiu[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
                
            }
                break;
            case 1:
            {
                //工作经验
                
                
            }
                break;
            case 2:
            {
                //年龄
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.delegate =self;
                TFvc.indexPath =indexPath;
                TFvc.content =arr_yaoqiu_content[indexPath.row];
                TFvc.contentTitle = arr_yaoqiu[indexPath.row];
                
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
                break;
            case 3:
            {
                //性别
                UIAlertController  *alert = [[UIAlertController alloc]init];
                [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_yaoqiu_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_yaoqiu_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"不限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_yaoqiu_content replaceObjectAtIndex:indexPath.row withObject:action.title];
                    [tableV reloadData];
                }]];
                [self presentViewController:alert animated:NO completion:nil];
                
                
            }
                break;
            case 4:
            {
                //专业技能
                FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
                TVvc.indexpath =indexPath;
                TVvc.delegate =self;
                TVvc.contentTitle =arr_yaoqiu[indexPath.row];
                TVvc.content =arr_yaoqiu_content[indexPath.row];
                [self.navigationController pushViewController:TVvc animated:NO];
                
            }
                break;
            case 5:
            {
                //岗位类别
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:content];
    }
    else
    {
        [arr_yaoqiu_content replaceObjectAtIndex:indexPath.row withObject:content];
    }
     [tableV reloadData];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:text];
    }
    else
    {
        [arr_yaoqiu_content replaceObjectAtIndex:indexPath.row withObject:text];
    }
    [tableV reloadData];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_gangwei_content replaceObjectAtIndex:indexPath.row withObject:option];
    }
    else
    {
        [arr_yaoqiu_content replaceObjectAtIndex:indexPath.row withObject:option];
    }
    [tableV reloadData];
}

@end
