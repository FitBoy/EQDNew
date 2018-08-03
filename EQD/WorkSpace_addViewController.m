//
//  WorkSpace_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "WorkSpace_addViewController.h"
#import "FB_twoTongShi2ViewController.h"
@interface WorkSpace_addViewController ()<UITableViewDelegate,UITableViewDataSource,FB_twoTongShi2ViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    NSString *otherGuid;
    UserModel *user;
}

@end

@implementation WorkSpace_addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_names = @[@"管理模块",@"管理人"];
    user = [WebRequest GetUserInfo];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

   
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tijiaoClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    [WebRequest Admin_ComSpaceModularPower_Add_ComSpaceModularPowerWithuserGuid:user.Guid companyId:user.companyId objectGuid:otherGuid ModularName:arr_contents[0] And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
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
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        UIAlertController *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"日志",@"小喇叭",@"设备管理"];
        for(int i=0;i<tarr.count;i++)
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
        
    }else if (indexPath.row ==1)
    {
        FB_twoTongShi2ViewController *TSvc = [[FB_twoTongShi2ViewController alloc]init];
        TSvc.delegate_tongshiDan =self;
        TSvc.indexPath = indexPath;
        [self.navigationController pushViewController:TSvc animated:NO];
    }
    else
    {
        
    }
}
#pragma  mark - 同事的选择
-(void)getComUserModel:(Com_UserModel*)model_com indexpath:(NSIndexPath*)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    otherGuid = model_com.userGuid;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
