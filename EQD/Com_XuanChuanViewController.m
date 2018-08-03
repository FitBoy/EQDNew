//
//  Com_XuanChuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Com_XuanChuanViewController.h"
#import "Com_imgAdd_DetailViewController.h"
#import <UIImageView+WebCache.h>
#import "FBImgeOnlyTableViewCell.h"
#import "FBButton.h"
#import "FBindexpathLongPressGestureRecognizer.h"
@interface Com_XuanChuanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *number_big;
}

@end

@implementation Com_XuanChuanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest ComImage_Get_ComImageWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            Com_ImgModel *model =[Com_ImgModel mj_objectWithKeyValues:tarr[i]];
            if (model.companyId==nil) {
                
            }else
            {
                [arr_model addObject:model];
                number_big = model.sort;
            }
            }
        [tableV.mj_header endRefreshing];
        [tableV reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"企业滚动图";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=DEVICE_WIDTH/2.0;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(tiajiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tiajiaClick
{
    //添加滚动图
    if (arr_model.count>7) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"最多8张滚动图";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    Com_imgAdd_DetailViewController *Dvc =[[Com_imgAdd_DetailViewController alloc]init];
    Dvc.number_big =number_big;
    [self.navigationController pushViewController:Dvc animated:NO];
    }
}
#pragma  mark - 表的数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBImgeOnlyTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBImgeOnlyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    Com_ImgModel *model =arr_model[indexPath.row];
    [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"imageerro"]];
    
    //添加长按操作
    FBindexpathLongPressGestureRecognizer *longpress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick)];
//    longpress.indexPath =indexPath;
    [cell addGestureRecognizer:longpress];
    return cell;
}
-(void)longPressClick
{
    [tableV setEditing:YES];
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_ImgModel *model =arr_model[indexPath.row];
    Com_imgAdd_DetailViewController  *Dvc =[[Com_imgAdd_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在调换";
    Com_ImgModel *model1 = arr_model[sourceIndexPath.row];
    Com_ImgModel *model2 =arr_model[destinationIndexPath.row];
    NSString *para =[NSString stringWithFormat:@"%@:%@;%@:%@",model1.Id,model2.sort,model2.Id,model1.sort];
    [WebRequest ComImage_Update_ImageSortWithuserGuid:user.Guid companyId:user.companyId para:para And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
            [tableV reloadData];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
   
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"您确定删除吗" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            Com_ImgModel *model=arr_model[indexPath.row];
            [WebRequest ComImage_Delete_ComImageWithuserGuid:user.Guid imageId:model.Id companyId:user.companyId And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else
                {
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }else
    {
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
