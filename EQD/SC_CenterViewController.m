//
//  SC_CenterViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_CenterViewController.h"
#import "FBImage_textFullTableViewCell.h"
#import "SC_centerAddViewController.h"
@interface SC_CenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
}

@end

@implementation SC_CenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest ComSpace_ComSpaceCoreValues_Get_ComSpaceCoreValuesWithcompanyId:self.comId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for(int i=0;i<tarr.count;i++)
            {
                Image_textModel  *model = [Image_textModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"核心价值观";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    if (self.temp ==1) {
        
    }else
    {
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaImgFromcenter)];
    [self.navigationItem setRightBarButtonItem:right];
    }

}
-(void)tianjiaImgFromcenter
{
    SC_centerAddViewController  *Avc = [[SC_centerAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Image_textModel *model = arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBImage_textFullTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBImage_textFullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    Image_textModel  *model = arr_model[indexPath.row];
    [cell setModel_center:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Image_textModel  *model = arr_model[indexPath.row];
    SC_centerAddViewController *Avc = [[SC_centerAddViewController alloc]init];
    Avc.tmodel = model;
    [self.navigationController pushViewController:Avc animated:NO];
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
        //拒绝邀请
        Image_textModel *model = arr_model[indexPath.row];
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"您确定删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [WebRequest ComSpace_ComSpaceCoreValues_Delete_ComSpaceCoreValuesWithuserGuid:user.Guid companyId:user.companyId coreValuesId:model.Id And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else
                {
                    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                    [alert showAlertWith:@"删除失败，请重试"];
                }
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController: alert animated:NO completion:nil];
       
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}




@end
