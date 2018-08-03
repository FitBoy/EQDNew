//
//  ComWorkSpace_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "ComWorkSpace_ViewController.h"
#import "WorkSpaceModel.h"
#import "WorkSpace_addViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "FB_twoTongShi2ViewController.h"
@interface ComWorkSpace_ViewController ()<UITableViewDelegate,UITableViewDataSource,FB_twoTongShi2ViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
}

@end

@implementation ComWorkSpace_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Admin_ComSpaceModularPower_Get_ComSpaceModularPowerWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"还没有设置" message:@"请点击右上角进行设置" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:NO completion:nil];
            }else
            {
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    WorkSpaceModel *model = [WorkSpaceModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}

#pragma  mark -  同事的选择
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    WorkSpaceModel *model =arr_model[indexPath.row];
    [WebRequest Admin_ComSpaceModularPower_Update_ComSpaceModularPowerWithuserGuid:user.Guid companyId:user.companyId objectGuid:model_com.userGuid ModularId:model.Id And:^(NSDictionary *dic) {
        hud.label.text  =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                model.staffName = model_com.username;
                [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        });
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业空间功能管理员设置";
    user = [WebRequest GetUserInfo];
    arr_model  =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaWorkSpace)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)tianjiaWorkSpace
{
    WorkSpace_addViewController  *Avc = [[WorkSpace_addViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
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
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    WorkSpaceModel *model = arr_model[indexPath.row];
    cell.textLabel.text = model.ModularName;
    cell.detailTextLabel.text = model.staffName;
    
    FBindexpathLongPressGestureRecognizer *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath =indexPath;
    [cell addGestureRecognizer:longPress];
    return cell;
}

-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)lonpress{
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改管理员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        FB_twoTongShi2ViewController *TSvc =[[FB_twoTongShi2ViewController alloc]init];
        TSvc.delegate_tongshiDan =self;
        TSvc.indexPath =lonpress.indexPath;
        [self.navigationController pushViewController:TSvc animated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
