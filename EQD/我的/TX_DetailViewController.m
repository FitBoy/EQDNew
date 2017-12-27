//
//  TX_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TX_DetailViewController.h"
#import "TiaoXiu_DetailModel.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTwoButtonView.h"
#import "FBFour_noimgTableViewCell.h"
#import "ShenPiListModel.h"
@interface TX_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    TiaoXiu_DetailModel *model_tiaoxiu;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSInteger section_number;
    
    NSArray *arr_names1;
    NSArray *arr_contents1;
    
    UserModel *user;
    
    NSMutableArray *arr_shenpiList;
}

@end

@implementation TX_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_shenpiList =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"调休详情";
    arr_names =[NSMutableArray arrayWithArray:@[@"申请人",@"调休单编码",@"调休天数",@"提交时间"]];
    arr_names1=@[@"时段1",@"时段2"];
    [WebRequest Get_Off_ByIdWithoffId:self.model.ID And:^(NSDictionary *dic) {
        model_tiaoxiu =[TiaoXiu_DetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        arr_contents=[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@【%@-%@】",model_tiaoxiu.createrName,model_tiaoxiu.department,model_tiaoxiu.post],model_tiaoxiu.offCode,model_tiaoxiu.offTimes,model_tiaoxiu.createTime]];
        arr_contents1=@[[NSString stringWithFormat:@"%@ ~ %@",model_tiaoxiu.planStartTime,model_tiaoxiu.planEndTime],[NSString stringWithFormat:@"%@ ~ %@",model_tiaoxiu.offStartTime,model_tiaoxiu.offEndTime]];
        [tableV reloadData];
    }];
    section_number=2;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
   [WebRequest Get_Off_CheckWithoffId:self.model.ID And:^(NSDictionary *dic) {
       if ([dic[Y_STATUS] integerValue]==200) {
           NSArray *tarr =dic[Y_ITEMS];
           if (tarr.count) {
               for (int i=0; i<tarr.count; i++) {
                   ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                   [arr_shenpiList addObject:model];
               }
               section_number=3;
               [tableV reloadData];
           }
       }
   }];
    

    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return section_number;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_contents.count;
    }else if(section==1)
    {
        return arr_contents1.count;
    }else
    {
        return arr_shenpiList.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
        return cell;

    }else if (indexPath.section==1)
    {
        static NSString *cellId=@"cellID1";
        FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left0.text =arr_names1[indexPath.row];
        cell.L_left1.text =arr_contents1[indexPath.row];
        return cell;
 
    }else
    {
        static NSString *cellId=@"cellID2";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ShenPiListModel *model =arr_shenpiList[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    }
#pragma  mark - 上边的标题
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 24;
    }
    return 10;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return @"从“时段1”调休到“时段2”";
    }
    return nil;
}
#pragma  mark - 底部的View 
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==section_number-1) {
        
        return self.isShenPi==1?50:1;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==section_number-1) {
        if (self.isShenPi==1) {
            FBTwoButtonView *Tview =[[FBTwoButtonView alloc]init];
            [Tview setleftname:@"拒绝" rightname:@"同意"];
            [Tview.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
            [Tview.B_right addTarget:self action:@selector(tongyiCLick) forControlEvents:UIControlEventTouchUpInside];
            
            return Tview;
        }
        return nil;
       
        
    }else
    {
        return nil;
    }
}
-(void)jujueClick
{
   //拒绝
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"拒绝理由";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length ==0) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"输入内容不能为空";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        else
        {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在拒绝";
            
            if (self.isRenShi==1) {
                [WebRequest Set_Off_ByHRWithoffId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
  
                }];
                
            }else
            {
            
        [WebRequest Set_Off_ByCheckerWithoffId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
            }
        }
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}
-(void)tongyiCLick
{
   //同意
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    
    if (self.isRenShi ==1) {
        [WebRequest Set_Off_ByHRWithoffId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            }); 
        }];
    }
    else
    {
    
    [WebRequest  Set_Off_ByCheckerWithoffId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
    }
}





@end
