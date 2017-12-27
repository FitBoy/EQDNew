//
//  TiaoBan_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//


#import "TiaoBan_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBFour_noimgTableViewCell.h"
#import "Tiaoban_DetailModel.h"
#import "FBTwoButtonView.h"
#import "ShenPiListModel.h"
#import "FBTextVViewController.h"
@interface TiaoBan_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_list;
    UserModel *user;
    Tiaoban_DetailModel *model_detail;
    NSInteger number_section;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
}

@end

@implementation TiaoBan_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[WebRequest GetUserInfo];
    arr_list =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    number_section =2;
   [WebRequest Get_ChangeShift_ByIdWithchangeShiftId:self.model.ID And:^(NSDictionary *dic) {
       if ([dic[Y_STATUS] integerValue]==200) {
           model_detail =[Tiaoban_DetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
           arr_names =[NSMutableArray arrayWithArray:@[model_detail.createrName,@"调班单编码",@"调班原因"]];
           arr_contents =[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@-%@",model_detail.department,model_detail.post],model_detail.changeShiftCode,model_detail.changeShiftReason]];
           [tableV reloadData];
       }
   }];
    
    //查看审批记录
    [WebRequest Get_ChangeShift_CheckWithchangeShiftId:self.model.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            number_section =3;
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    ShenPiListModel *model =[ShenPiListModel  mj_objectWithKeyValues:tarr[i]];
                    [arr_list addObject:model];
                }
            }
            
            [tableV reloadData];
        }
    }];

}
#pragma  mark - 表的数据源
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==number_section-1) {
        if (self.isshenpi==1) {
            FBTwoButtonView *tView =[[FBTwoButtonView alloc]init];
            [tView setleftname:@"拒绝" rightname:@"同意"];
            [tView.B_left addTarget:self action:@selector(jujueCLick) forControlEvents:UIControlEventTouchUpInside];
            [tView.B_right addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
            
            return tView;
        }else
        {
            return nil;
        }
        
    }else
    {
        return nil;
    }
    
}
-(void)jujueCLick
{
    //拒绝要输入理由
    UIAlertController  *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"拒绝理由";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length==0) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"输入内容不能为空";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在拒绝";
            
            if (self.isRenShi==1) {
                [WebRequest Set_ChangeShift_ByHRWithchangeShiftId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                }];
                
            }
            
            [WebRequest Set_ChangeShift_ByCheckerWithchangeShiftId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
            
        }
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)tongyiClick
{
    
    
    
    //同意不需要理由
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    
    if (self.isRenShi==1) {
        [WebRequest Set_ChangeShift_ByHRWithchangeShiftId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
    else
    {
    [WebRequest Set_ChangeShift_ByCheckerWithchangeShiftId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section==number_section-1) {
        if (self.isshenpi==1) {
            return 50;
        }else
        {
            return 1;
        }
    }else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return model_detail==nil?0:number_section;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_contents.count ;
    }else if (section==1)
    {
        return 2;
    }  else
    {
        return arr_list.count;
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
        if (indexPath.row==2) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.L_left0.text=arr_names[indexPath.row];
        cell.L_right0.text=arr_contents[indexPath.row];
        
        return cell;
    }else if (indexPath.section==1)
    {
        static NSString *cellId=@"cellID1";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row==0) {
            cell.L_left0.text =@"所在班别";
            cell.L_right0.text=model_detail.nowRule.Rule;
            NSMutableString *tstr =[NSMutableString stringWithFormat:@"%@~%@  ",model_detail.nowRule.StartTime1,model_detail.nowRule.EndTime1];
            if (!([model_detail.nowRule.StartTime2 isEqualToString:@"00:00"] &&[model_detail.nowRule.EndTime2 isEqualToString:@"00:00"] )) {
                [tstr appendFormat:@"%@~%@  ",model_detail.nowRule.StartTime2,model_detail.nowRule.EndTime2];
                if (!([model_detail.nowRule.StartTime3 isEqualToString:@"00:00"] &&[model_detail.nowRule.EndTime3 isEqualToString:@"00:00"] )) {
                    [tstr appendFormat:@"%@~%@  ",model_detail.nowRule.StartTime3,model_detail.nowRule.EndTime3];
                    if (!([model_detail.nowRule.StartTime4 isEqualToString:@"00:00"] &&[model_detail.nowRule.EndTime4 isEqualToString:@"00:00"] )) {
                        [tstr appendFormat:@"%@~%@  ",model_detail.nowRule.StartTime4,model_detail.nowRule.EndTime4];
                    }
                }
            }
            cell.L_left1.text =tstr;
            
        }else
        {
          cell.L_left0.text =@"要调班别";
            cell.L_right0.text =model_detail.changeRule.Rule;
            NSMutableString *tstr =[NSMutableString stringWithFormat:@"%@~%@  ",model_detail.changeRule.StartTime1,model_detail.changeRule.EndTime1];
            if (!([model_detail.changeRule.StartTime2 isEqualToString:@"00:00"] &&[model_detail.changeRule.EndTime2 isEqualToString:@"00:00"] )) {
                [tstr appendFormat:@"%@~%@  ",model_detail.changeRule.StartTime2,model_detail.changeRule.EndTime2];
                if (!([model_detail.changeRule.StartTime3 isEqualToString:@"00:00"] &&[model_detail.changeRule.EndTime3 isEqualToString:@"00:00"] )) {
                    [tstr appendFormat:@"%@~%@  ",model_detail.changeRule.StartTime3,model_detail.changeRule.EndTime3];
                    if (!([model_detail.changeRule.StartTime4 isEqualToString:@"00:00"] &&[model_detail.changeRule.EndTime4 isEqualToString:@"00:00"] )) {
                        [tstr appendFormat:@"%@~%@  ",model_detail.changeRule.StartTime4,model_detail.changeRule.EndTime4];
                    }
                }
            }
            cell.L_left1.text =tstr;
            
        }
        return cell;

    }else
    {
        static NSString *cellId=@"cellID2";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        ShenPiListModel  *model =arr_list[indexPath.row];
        [cell setModel:model];
       
        return cell;
    }
    
    
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            //调班原因
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.content =model_detail.changeShiftReason;
            TVvc.contentTitle=@"调班原因";
            [self.navigationController pushViewController:TVvc animated:NO];
        }
    }
}


@end
