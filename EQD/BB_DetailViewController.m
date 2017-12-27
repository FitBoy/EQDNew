//
//  BB_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BB_DetailViewController.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBButton.h"
#import "BB_choosebcViewController.h"
#import "BB_WeeksViewController.h"
#import "BB_PeopleViewController.h"
#import "FBTextFieldViewController.h"
@interface BB_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,BB_choosebcViewControllerDelegate,BB_WeeksViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation BB_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"详情";
    arr_names =[NSMutableArray arrayWithArray:@[@"班别名称",@"班次",@"查看人员",@"上班周期",@"上班节假日"]];
    arr_contents=[NSMutableArray arrayWithArray:@[_model.ruleName,_model.shiftName,@"查看",_model.weeks,_model.Holidays]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
  

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FBButton *tbtn =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"删除" titleColor:[UIColor whiteColor] backgroundColor:[UIColor redColor] font:[UIFont systemFontOfSize:17]];
    [tbtn addTarget:self action:@selector(shanchuCLick) forControlEvents:UIControlEventTouchUpInside];
    return tbtn;
}
-(void)shanchuCLick
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"您确认删除吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest Delete_RuleShiftWithuserGuid:user.Guid shiftId:_model.Id companyId:user.companyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =@"删除成功";
            }
            else
            {
                hud.label.text=@"未知错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<3) {
        static NSString *cellId=@"cellID";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text=arr_contents[indexPath.row];
        return cell;
    }
    else
    {
        static NSString *cellId=@"cellID2";
        FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_left1.text=arr_contents[indexPath.row];
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTishi =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==1) {
        //班次
        BB_choosebcViewController *Cvc =[[BB_choosebcViewController alloc]init];
        Cvc.indexPath=indexPath;
        Cvc.delegate=self;
        
        [self.navigationController pushViewController:Cvc animated:NO];
    }
    else if(indexPath.row==2)
    {
        //查看人员
        BB_PeopleViewController *Pvc=[[BB_PeopleViewController alloc]init];
        Pvc.ruleId =_model.Id;
        [self.navigationController pushViewController:Pvc animated:NO];
    }
    else if (indexPath.row==3 || indexPath.row==4)
    {
        BB_WeeksViewController *Wvc =[[BB_WeeksViewController alloc]init];
        Wvc.indexPath=indexPath;
        Wvc.delegate=self;
        
        if (indexPath.row==3) {
            Wvc.arr_names=@[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
            Wvc.arr_contents=[NSMutableArray arrayWithArray:[self arrWithOtherstring:self.model.weeks compareArr:Wvc.arr_names]];
            
        }
        else
        {
            Wvc.arr_names=@[@"元旦",@"春节",@"清明节",@"劳动节",@"端午节",@"中秋节",@"国庆节"];
          Wvc.arr_contents=Wvc.arr_contents=[NSMutableArray arrayWithArray:[self arrWithOtherstring:self.model.Holidays compareArr:Wvc.arr_names]];
        }
        
        
        [self.navigationController pushViewController:Wvc animated:NO];
        
    }
}

-(NSArray*)arrWithOtherstring:(NSString*)Otherstring compareArr:(NSArray*)compareArr
{
    NSArray *otherArr =[Otherstring componentsSeparatedByString:@","];
    NSMutableArray *tarr =[NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    for (int i=0; i<compareArr.count; i++) {
        if ([otherArr containsObject:compareArr[i]]) {
            [tarr replaceObjectAtIndex:i withObject:@"1"];
        }
    }
    return tarr;
}
#pragma  mark - 自定义的协议代理
-(void)banciModel:(BanCiModel *)model indexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Update_RuleShiftWithshiftId:model.Id weeks:_model.weeks holidays:_model.Holidays userGuid:user.Guid companyId:user.companyId ruleShiftId:_model.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =@"修改成功";
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:model.shiftName];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           
        }
        else
        {
            hud.label.text =@"服务器错误";
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            
        });
    }];
    
    
   
}
-(void)chooseArr:(NSArray *)tarr indexPath:(NSIndexPath *)indexPath
{
    NSMutableString *tstr =[NSMutableString string];
    for (int i=0; i<tarr.count; i++) {
        [tstr appendFormat:@"%@,",tarr[i]];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    if (indexPath.row==3) {
        //星期
        [WebRequest Update_RuleShiftWithshiftId:_model.ShiftId weeks:tstr holidays:_model.Holidays userGuid:user.Guid companyId:user.companyId ruleShiftId:_model.Id And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =@"修改成功";
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:tstr];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                hud.label.text =@"服务器错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];

    }
    else
    {
        
        //节假日
        [WebRequest Update_RuleShiftWithshiftId:_model.ShiftId weeks:_model.weeks holidays:tstr userGuid:user.Guid companyId:user.companyId ruleShiftId:_model.Id And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =@"修改成功";
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:tstr];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                hud.label.text =@"服务器错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });

        }];
        

    }
   }
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Update_RuleShiftWithshiftId:_model.ShiftId weeks:_model.weeks holidays:_model.Holidays userGuid:user.Guid companyId:user.companyId ruleShiftId:_model.Id And:^(NSDictionary *dic) {
        
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =@"修改成功";
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           
        }
        else
        {
            hud.label.text =@"服务器错误";
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            
        });
       
    }];
    
}

@end
