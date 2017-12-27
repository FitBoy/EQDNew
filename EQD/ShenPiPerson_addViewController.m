//
//  ShenPiPerson_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ShenPiPerson_addViewController.h"
#import "FBOneChoose_TongShiViewController.h"
#import "Bumen_MutableViewController.h"
#import "FBPeople.h"
@interface ShenPiPerson_addViewController ()<UITableViewDataSource,UITableViewDelegate,FBOneChoose_TongShiViewControllerDelegate,Bumen_MutableViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    Com_UserModel *model_com;
    NSMutableString *departId;
    NSString *checker;
}

@end

@implementation ShenPiPerson_addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"设置部门离职审批人";
    arr_names = [NSMutableArray arrayWithArray:@[@"离职审批人",@"部门"]];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(QuedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)QuedingClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在添加";
    [WebRequest  SetUp_Add_QuitCheckerWithcompanyId:user.companyId userGUid:user.Guid cheker:checker departmentIds:departId And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [self.navigationController popViewControllerAnimated:NO];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
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
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        //审批人
        FBOneChoose_TongShiViewController  *TSvc =[[FBOneChoose_TongShiViewController alloc]init];
        TSvc.delegate =self;
        TSvc.indexpath =indexPath;
        [self.navigationController pushViewController:TSvc animated:NO];
    }else
    {
        //部门
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"请稍等……";
        [WebRequest SetUp_Get_Department_ByPowerWithcompanyId:user.companyId And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                NSMutableArray *arr_P =[NSMutableArray arrayWithCapacity:0];
                for (int i=0; i<tarr.count; i++) {
                    FBPeople  *peo = [FBPeople mj_objectWithKeyValues:tarr[i]];
                    [arr_P addObject:peo];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    Bumen_MutableViewController  *BMvc =[[Bumen_MutableViewController alloc]init];
                    BMvc.delegate =self;
                    BMvc.arr_bumen = arr_P;
                    [self.navigationController pushViewController:BMvc animated:NO];
                });
            }
            
        }];
       
    }
}
-(void)chooseModel:(Com_UserModel *)model indexpath:(NSIndexPath *)indepPath
{
    model_com =model;
    checker = model.userGuid;
    [arr_contents replaceObjectAtIndex:indepPath.row withObject:model.username];
    [tableV reloadRowsAtIndexPaths:@[indepPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)bumenArr:(NSArray *)arr
{
    NSMutableString *bumen = [NSMutableString string];
    departId =[NSMutableString string];
    for(int i=0;i<arr.count;i++)
    {
        ZuZhiModel *model =arr[i];
        [bumen appendFormat:@"%@ ",model.departName];
        if (i==arr.count-1) {
            [departId appendString:model.departId];
        }else
        {
        [departId appendFormat:@"%@,",model.departId];
        }
    }
    
    [arr_contents replaceObjectAtIndex:1 withObject:bumen];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
