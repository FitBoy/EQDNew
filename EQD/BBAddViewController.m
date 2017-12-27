//
//  BBAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BBAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "BB_choosebcViewController.h"
#import "FBMutableChoose_TongShiViewController.h"
#import "BB_WeeksViewController.h"
@interface BBAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,BB_choosebcViewControllerDelegate,FBMutableChoose_TongShiViewControllerDelegate,BB_WeeksViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    BanCiModel *selected_model;
    //人员 com_usermodel
    NSArray *arr_selected;
    UserModel *user;
}

@end

@implementation BBAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"班别设置";
    arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请选择",@"星期一;星期二;星期三;星期四;星期五",@" "]];
    arr_names = [NSMutableArray arrayWithArray:@[@"班别名称",@"班次",@"适应人员",@"设置上班周期",@"设置节假日"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)quedingClick
{
    NSMutableString *tstr =[NSMutableString string];
    for (int i=0; i<arr_selected.count; i++) {
        Com_UserModel *model =arr_selected[i];
        if (i==arr_selected.count-1) {
            [tstr appendString:model.userGuid];
        }
        else
        {
            [tstr appendFormat:@"%@;",model.userGuid];
        }
    }
    if ([arr_contents containsObject:@"请输入"] || [arr_contents containsObject:@"请选择"]) {
        
    }
    else
    {
    
        if (tstr.length==0) {
            [tstr  appendFormat:@" "];
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在设置";
        NSMutableString *tstr2 =[NSMutableString stringWithFormat:@"%@ ~ %@  ",selected_model.startTime1,selected_model.endTime1];
        if (!([selected_model.startTime2 isEqualToString:@"00:00"]&&[selected_model.endTime2 isEqualToString:@"00:00"])) {
            [tstr2 appendFormat:@"%@ ~ %@  ",selected_model.startTime2,selected_model.endTime2];
            if (!([selected_model.startTime3 isEqualToString:@"00:00"]&&[selected_model.endTime3 isEqualToString:@"00:00"])) {
                [tstr2 appendFormat:@"%@ ~ %@  ",selected_model.startTime3,selected_model.endTime3];
                if (!([selected_model.startTime4 isEqualToString:@"00:00"]&&[selected_model.endTime4 isEqualToString:@"00:00"])) {
                    [tstr2 appendFormat:@"%@ ~ %@  ",selected_model.startTime4,selected_model.endTime4];
                }
            }
        }
   [WebRequest Add_RuleShiftWithruleName:arr_contents[0] ruleDescribe:tstr2 companyId:user.companyId userGuid:user.Guid objecter:tstr shiftId:selected_model.Id weeks:arr_contents[3] holidays:arr_contents[4] And:^(NSDictionary *dic) {
       if([dic[Y_STATUS] integerValue]==200)
       {
           hud.label.text=@"设置成功";
           [self.navigationController popViewControllerAnimated:NO];
       }
       else
       {
           hud.label.text =@"设置失败";
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
    return  arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *cellId=@"cellID";
        FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_left1.text =arr_contents[indexPath.row];
        return cell;
  
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.row) {
            case 0:
            {
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.indexPath =indexPath;
                TFvc.delegate =self;
                TFvc.contentTitle =arr_names[indexPath.row];
                TFvc.content =arr_contents[indexPath.row];
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
                break;
              case 1:
            {
                //班次
                BB_choosebcViewController *Cvc =[[BB_choosebcViewController alloc]init];
                Cvc.delegate =self;
                Cvc.indexPath =indexPath;
                [self.navigationController pushViewController:Cvc animated:NO];
            }
                break;
                case 2:
            {
                //人员
                FBMutableChoose_TongShiViewController *TSvc =[[FBMutableChoose_TongShiViewController alloc]init];
                TSvc.delegate=self;
                TSvc.indePath =indexPath;
                [self.navigationController pushViewController:TSvc animated:NO];
                
                
            }
                break;
                case 3:
            {
                //上班周期
                BB_WeeksViewController *Wvc =[[BB_WeeksViewController alloc]init];
                Wvc.delegate=self;
                Wvc.indexPath =indexPath;
                Wvc.arr_names =@[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
                Wvc.arr_contents=[NSMutableArray arrayWithArray:@[@"1",@"1",@"1",@"1",@"1",@"0",@"0"]];
                [self.navigationController pushViewController:Wvc animated:NO];
            }
                break;
                case 4:
            {
                //节假日
                BB_WeeksViewController *Wvc =[[BB_WeeksViewController alloc]init];
                Wvc.delegate=self;
                Wvc.indexPath =indexPath;
                Wvc.arr_names =@[@"元旦",@"春节",@"清明节",@"劳动节",@"端午节",@"中秋节",@"国庆节"];
                Wvc.arr_contents=[NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
                [self.navigationController pushViewController:Wvc animated:NO];
                
            }
                break;
            default:
                break;
        }
   
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
}
-(void)banciModel:(BanCiModel *)model indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model.shiftName];
    selected_model =model;
    [tableV reloadData];
}
-(void)mutableChooseArr:(NSArray *)chooses tarr:(NSArray *)tarr indexPath:(NSIndexPath *)indexPath
{
    arr_selected =chooses;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%ld个",chooses.count]];
    [tableV reloadData];
}
-(void)chooseArr:(NSArray *)tarr  indexPath:(NSIndexPath *)indexPath
{
    NSMutableString  *tstr =[NSMutableString string];
    for (int i=0; i<tarr.count; i++) {
        if (i==tarr.count-1) {
            [tstr appendString:tarr[i]];
        }
        else
        {
            [tstr appendFormat:@"%@,",tarr[i]];
        }
        if (tstr.length==0) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:@" "];
        }
        else
        {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:tstr];
        }
        
        [tableV reloadData];
        
    }
}
@end
