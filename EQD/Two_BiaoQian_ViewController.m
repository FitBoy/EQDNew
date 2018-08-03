//
//  Two_BiaoQian_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Two_BiaoQian_ViewController.h"
#import "BQ_New_ViewController.h"
#import "BQ_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBindexpathLongPressGestureRecognizer.h"
@interface Two_BiaoQian_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_biaoqian;
    UserModel *user;
}

@end

@implementation Two_BiaoQian_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Get_labellistWithowner:user.Guid And:^(NSDictionary *dic) {
        [arr_biaoqian removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                BiaoQianModel *model =[BiaoQianModel mj_objectWithKeyValues:tarr[i]];
                [arr_biaoqian addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_biaoqian =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title=@"标签列表";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(xinjianClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
#pragma  mark - 新建标签
-(void)xinjianClick
{
    BQ_New_ViewController  *Nvc =[[BQ_New_ViewController alloc]init];
    [self.navigationController pushViewController:Nvc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_biaoqian.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    BiaoQianModel *model =arr_biaoqian[indexPath.row];
    cell.L_left0.text =[NSString stringWithFormat:@"%@(%@)",model.name,model.membernumber];
    FBindexpathLongPressGestureRecognizer *longPress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath =indexPath;
    [cell addGestureRecognizer:longPress];
    return cell;
}
#pragma  mark -长按操作
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longPress
{
    BiaoQianModel *model =arr_biaoqian[longPress.indexPath.row];
    UIAlertController  *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改名称" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@",model.name] preferredStyle:UIAlertControllerStyleAlert];
        [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输入新名称";
        }];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //修改名称
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert2 animated:NO completion:nil];
        });
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest Del_labelWithowner:user.Guid labelid:model.ID And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self loadRequestData];
            });
            
        }];

        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除标签
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        BiaoQianModel *model =arr_biaoqian[indexPath.row];
        [WebRequest Del_labelWithowner:user.Guid labelid:model.ID And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self loadRequestData];
            });
           
        }];
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BiaoQianModel *model =arr_biaoqian[indexPath.row];
    
    if ([self.delegate_baioqian respondsToSelector:@selector(getBiaoQianModel:)]) {
        [self.delegate_baioqian getBiaoQianModel:model];
        [self.navigationController popViewControllerAnimated:NO];
    }else
    {
    BQ_DetailViewController *Dvc =[[BQ_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
    }
}



@end
