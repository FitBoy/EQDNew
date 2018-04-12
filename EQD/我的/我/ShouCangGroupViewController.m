//
//  ShouCangGroupViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ShouCangGroupViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "FBTextFieldViewController.h"
@interface ShouCangGroupViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
}

@end

@implementation ShouCangGroupViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Collection_Get_collectionGroupsWithowner:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                ShouCang_GroupModel *model =[ShouCang_GroupModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            
        }
        [tableV reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title= @"分组管理";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加分组" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   


}
-(void)tianjiaClick
{
    FBTextFieldViewController  *TFvc =[[FBTextFieldViewController alloc]init];
    TFvc.delegate =self;
    TFvc.contentTitle = @"新的分组名称";
    [self.navigationController pushViewController:TFvc animated:NO];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath==nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        [WebRequest Collection_Add_collectionGroupWithowner:user.Guid name:content And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self loadRequestData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }else
    {
        ShouCang_GroupModel  *model =arr_model[indexPath.row];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        [WebRequest Collection_Update_collectionGroupWithowner:user.Guid groupid:model.Id name:content And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                UITableViewCell  *cell =[tableV cellForRowAtIndexPath:indexPath];
                cell.textLabel.text = content;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }
    
    
  
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    }
    ShouCang_GroupModel  *model =arr_model[indexPath.row];
    cell.textLabel.text =model.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@条收藏",model.count];
    FBindexpathLongPressGestureRecognizer  *longpress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressClick:)];
    longpress.indexPath =indexPath;
    [cell addGestureRecognizer:longpress];
    
    return cell;
}
-(void)longpressClick:(FBindexpathLongPressGestureRecognizer*)longPress
{
    ShouCang_GroupModel  *model =arr_model[longPress.indexPath.row];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"修改名称",@"删除分组"];
    for(int i=0;i<tarr.count;i++)
    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (i==0) {
            FBTextFieldViewController  *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.contentTitle =@"修改分组名称";
            TFvc.content =model.name;
            TFvc.indexPath =longPress.indexPath;
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }else if (i==1)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Collection_Del_collectionGroupWithowner:user.Guid groupid:model.Id And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
        }else
        {
            
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(shoucangGroupWithmodel:shoucang:)]) {
        ShouCang_GroupModel  *model =arr_model[indexPath.row];
        [self.delegate shoucangGroupWithmodel:model shoucang:self.model];
        [self.navigationController popViewControllerAnimated:NO];
    }
}



@end
