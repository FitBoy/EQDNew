//
//  SQXZWuZiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQXZWuZiViewController.h"
#import "FBTextFieldViewController.h"
@interface SQXZWuZiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
}

@end

@implementation SQXZWuZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"行政物资申请";
    arr_names =[NSMutableArray arrayWithArray:@[@"物品名称",@"工用具类型",@"型号/规格",@"数量",@"所属部门",@"物品负责人"]];
    NSArray *arr = [USERDEFAULTS objectForKey:@"SQXZWuZi"];
    if(arr.count==0)
    {
        arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请选择",@"请输入",@"请选择",@"请输入"]];
    }
    else
    {
        arr_contents = [NSMutableArray arrayWithArray:arr];
    }
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"申请" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)tianjiaClick
{
    //申请
    [USERDEFAULTS removeObjectForKey:@"SQXZWuZi"];
    
}
-(void)backClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存填写过的信息" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [USERDEFAULTS setObject:arr_contents forKey:@"SQXZWuZi"];
        [USERDEFAULTS synchronize];
        
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //@[@"物品名称",@"工用具类型",@"型号/规格",@"数量",@"所属部门",@"物品负责人"]]
    if (indexPath.row==1) {
        //工用具类型
        UIAlertController  *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"办公文具类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"办公设备类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"劳保用品类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"生产工具类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"设备类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"模具、工装、夹具类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadData];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }
    else if(indexPath.row==4)
    {
       //所属部门
    }
    else if(indexPath.row==5)
    {
        //物品负责人
    }
    else
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }
    
}




@end
