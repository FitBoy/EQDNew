//
//  SC_TeamPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_TeamPersonViewController.h"
#import "SC_TeamModel.h"
#import "SC_teamMiaoshuTableViewCell.h"
#import "SC_teamAddViewController.h"
@interface SC_TeamPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
}

@end

@implementation SC_TeamPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}

-(void)loadRequestData{
    if(self.temp == 1 || self.temp ==2)
    {
        
        [WebRequest ComSpace_ComSpaceGoodStaff_Get_ComSpaceGoodStaffWithcompanyId:self.comId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    SC_TeamModel  *model = [SC_TeamModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height = 60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }else
    {
    
    [WebRequest ComSpace_ComSpaceTeam_Get_ComSpaceTeamWithcompanyId:self.comId And:^(NSDictionary *dic) {
      
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_TeamModel  *model = [SC_TeamModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    
    if (self.temp ==1) {
        self.navigationItem.title = @"荣誉墙";
    }else
    {
    self.navigationItem.title =@"团队成员列表";
    }
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    if(self.temp ==2)
    {
        
    }else
    {
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiapersonFronZuzhi)];
    [self.navigationItem setRightBarButtonItem:right];
    }

}
-(void)tianjiapersonFronZuzhi
{
    SC_teamAddViewController *Avc = [[SC_teamAddViewController alloc]init];
    Avc.temp =self.temp;
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SC_TeamModel *model =arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    SC_teamMiaoshuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SC_teamMiaoshuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    SC_TeamModel *model =arr_model[indexPath.row];
    [cell setModel_team:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SC_TeamModel *model = arr_model[indexPath.row];
    SC_teamAddViewController *Avc = [[SC_teamAddViewController alloc]init];
    Avc.temp =self.temp;
    Avc.model_list = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:Avc animated:NO];
    
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
        //删除
        SC_TeamModel *model =arr_model[indexPath.row];
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"确认删除该团队成员？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            if (self.temp ==1) {
                [WebRequest ComSpace_ComSpaceGoodStaff_Delete_ComSpaceGoodStaffWithuserGuid:user.Guid companyId:user.companyId staffId:model.Id And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        if ([dic[Y_STATUS] integerValue]==200) {
                            [arr_model removeObject:model];
                            [tableV reloadData];
                        }
                    });
                }];
            }else
            {
            [WebRequest ComSpace_ComSpaceTeam_Delete_ComSpaceTeamWithuserGuid:user.Guid companyId:user.companyId teamId:model.Id And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model removeObject:model];
                        [tableV reloadData];
                    }
                });
            }];
            }
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}




@end
