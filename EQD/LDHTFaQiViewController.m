//
//  LDHTFaQiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LDHTFaQiViewController.h"
#import "FBTimeDayViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBButton.h"
#import "FQSearchViewController.h"
#import "DatePicer_AlertView.h"
#import "FBOptionViewController.h"
#import "HeTong_DetailModel.h"
@interface LDHTFaQiViewController ()<UITableViewDataSource,UITableViewDelegate,FBTimeDayViewControllerDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FQSearchViewControllerDelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSDictionary  *dic10;
    NSDictionary  *dic11;
    NSDictionary  *dic12;
    NSDictionary  *dic13;
    DatePicer_AlertView *date_alert;
    UserModel *user;
    Com_UserModel *C_model;
}

@end

@implementation LDHTFaQiViewController
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    NSDictionary *dic = @{@"name":@"入职时间",@"code":@"3",@"content":date_str};
    [arr_names replaceObjectAtIndex:3 withObject:dic];
    [date_alert removeFromSuperview];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        arr_names =[NSMutableArray arrayWithArray:@[
                                                    @{@"name":@"签订人",@"code":@"0",@"content":@"请输入"},
                                                    @{@"name":@"所在部门",@"code":@"1",@"content":@""},
                                                    @{@"name":@"所在岗位",@"code":@"2",@"content":@""},
                                                    @{@"name":@"入职时间",@"code":@"3",@"content":@""},
                                                    @{@"name":@"合同类型",@"code":@"4",@"content":@"请选择"},
                                                    @{@"name":@"合同性质",@"code":@"5",@"content":@"请选择"},
  @{@"name":@"合同开始时间",@"code":@"7",@"content":@"请选择"},
                                                    @{@"name":@"合同结束时间",@"code":@"8",@"content":@"请选择"},
                                                    @{@"name":@"工资发放银行",@"code":@"9",@"content":@"请输入"},
                                                    @{@"name":@"试用期工资（元）",@"code":@"14",@"content":@"请输入"}
                                                    ]];
        dic10=@{@"name":@"劳动合同形式",@"code":@"10",@"content":@"请选择"};
        
        dic11 =@{@"name":@"试用期(月)",@"code":@"11",@"content":@"请输入"};
        dic12 =@{@"name":@"上次合同结束原因",@"code":@"12",@"content":@"请输入"};
        dic13=@{@"name":@"合同签订次数",@"code":@"6",@"content":@" "};
   
    self.navigationItem.title =@"发起劳动合同";
   

    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(fasongClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"发 送" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:24]];
    [tbtn addTarget:self action:@selector(fasongClick) forControlEvents:UIControlEventTouchUpInside];
    
    return tbtn;
}
-(void)fasongClick
{
    NSInteger temp=0;
    HeTong_DetailModel *model_detail =[[HeTong_DetailModel alloc]init];

     model_detail.contractForm =@" ";
    model_detail.probation =@" ";
 model_detail.lastReason =@" ";
    model_detail.signedNumber =@" ";
    NSString *signEntryTime=nil;
    NSString *contractStartTime=nil;
    NSString *contractEndTime=nil;
    
    for(int i=3;i<arr_names.count;i++)
    {
        NSDictionary *dic =arr_names[i];
        if ([dic[@"content"] isEqualToString:@"请输入"] || [dic[@"content"] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
        
        if ([dic[@"code"] integerValue]==3) {
            signEntryTime =[NSString stringWithFormat:@"%@",dic[@"content"]];
        }else if ([dic[@"code"] integerValue]==4)
        {
            model_detail.contractType =dic[@"content"];
        }else if ([dic[@"code"] integerValue]==5)
        {
            model_detail.contractNature =dic[@"content"];
        }else if ([dic[@"code"] integerValue]==7)
        {
            contractStartTime =[NSString stringWithFormat:@"%@",dic[@"content"]];
        }else if ([dic[@"code"] integerValue]==8)
        {
           contractEndTime =[NSString stringWithFormat:@"%@",dic[@"content"]];
        }else if ([dic[@"code"] integerValue]==9)
        {
            model_detail.bank =dic[@"content"];
        }
        else if ([dic[@"code"] integerValue]==10) {
            model_detail.contractForm =dic[@"content"];
        }else if ([dic[@"code"] integerValue]==11) {
            model_detail.probation =dic[@"content"];
        }else  if ([dic[@"code"] integerValue]==12) {
            model_detail.lastReason =dic[@"content"];
        }else if ([dic[@"code"] integerValue]==6) {
            model_detail.signedNumber =dic[@"content"];
        }else if ([dic[@"code"] integerValue] ==14)
        {
//        试用期工资
            model_detail.ProbationSalary =dic[@"content"];
        }
        else
            {
                
            }
        }
    
    
    
    if (temp==1) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不全";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
    //发送劳动合同
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发送";
        [WebRequest Contracts_Add_ContractWithuserGuid:user.Guid companyId:user.companyId signatory:C_model.userGuid signDepartId:C_model.departmentId signPostId:C_model.postId signEntryTime:signEntryTime contractType:model_detail.contractType contractNature:model_detail.contractNature signedNumber:model_detail.signedNumber lastReason:model_detail.lastReason contractForm:model_detail.contractForm contractStartTime:contractStartTime contractEndTime:contractEndTime probation:model_detail.probation bank:model_detail.bank ProbationSalary:model_detail.ProbationSalary And:^(NSDictionary *dic) {
        
                   hud.label.text =dic[Y_MSG];
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
           [ self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSDictionary *dic = arr_names[indexPath.row];
    cell.textLabel.text =dic[@"name"];
    cell.detailTextLabel.text =dic[@"content"];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = arr_names[indexPath.row];
    switch ([dic[@"code"] integerValue]) {
        case 0:
        {
            //签订人
            FQSearchViewController  *Svc =[[FQSearchViewController alloc]init];
            Svc.delegate =self;
            [self.navigationController pushViewController:Svc animated:NO];
            
        }
            break;
        case 3:
        {
            [self.view addSubview:date_alert];
        }
            break;
        case 4:
        {
           //合同类型
            UIAlertController *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"劳动合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionaryWithDictionary:dic];
               [ dic1 setValue:action.title forKey:@"content"];
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic10];
                [arr_names removeObject:dic11];
                    [arr_names  insertObject:dic10 atIndex:indexPath.row+1];
                    [arr_names insertObject:dic11 atIndex:indexPath.row+2];
                    [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"保密协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionaryWithDictionary:dic];
                [ dic1 setValue:action.title forKey:@"content"];
                 [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic10];
                [arr_names removeObject:dic11];
                
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"竞业禁止协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionaryWithDictionary:dic];
                [ dic1 setValue:action.title forKey:@"content"];
                 [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic10];
                [arr_names removeObject:dic11];

                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"培训协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionaryWithDictionary:dic];
                [ dic1 setValue:action.title forKey:@"content"];
                 [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic10];
                [arr_names removeObject:dic11];

                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 =[NSMutableDictionary dictionaryWithDictionary:dic];
                [ dic1 setValue:action.title forKey:@"content"];
                 [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic10];
                [arr_names removeObject:dic11];

                [tableV reloadData];
            }]];
            [self presentViewController:alert animated:NO completion:nil];
            
        }
            break;
        case 5:
        {
           //合同性质
            UIAlertController *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"新签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic13];
                [arr_names removeObject:dic12];
                [tableV reloadData];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"续签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic13];
                [arr_names removeObject:dic12];
                dic13=@{@"name":@"合同签订次数",@"code":@"6",@"content":@" "};
                [arr_names insertObject:dic13 atIndex:indexPath.row+1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"变更" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic13];
                [arr_names removeObject:dic12];
                dic13=@{@"name":@"合同签订次数",@"code":@"6",@"content":@" "};
                 [arr_names insertObject:dic13 atIndex:indexPath.row+1];
                [tableV reloadData];
            }]];
            [self presentViewController:alert animated:NO completion:nil];
            
        }
            break;
        case 6:
        {
            //合同签订次数
            UIAlertController *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"新签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic13 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                 [arr_names removeObject:dic12];
                [tableV reloadData];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"第二次签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic13 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic12];
                [arr_names insertObject:dic12 atIndex:indexPath.row+1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"第三次签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic13 = dic1;
                [dic1 setValue:action.title forKey:@"content"];
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [arr_names removeObject:dic12];
                [arr_names insertObject:dic12 atIndex:indexPath.row+1];
                [tableV reloadData];
            }]];
            [self presentViewController:alert animated:NO completion:nil];
        }
            break;
        case 7:
        {
           //合同开始时间
            FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
            TDvc.delegate =self;
            TDvc.indexPath =indexPath;
            TDvc.contentTitle =dic[@"name"];
            [self.navigationController pushViewController:TDvc animated:NO];
        }
            break;
        case 8:
        {
          //合同结束时间
            FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
            TDvc.delegate =self;
            TDvc.indexPath =indexPath;
            TDvc.contentTitle =dic[@"name"];
            [self.navigationController pushViewController:TDvc animated:NO];
        }
            break;
        case 9:
        {
            //工资发放银行
            FBOptionViewController *TFvc =[[FBOptionViewController alloc]init];
            TFvc.option=35;
            TFvc.delegate =self;
            TFvc.indexPath=indexPath;
            TFvc.contentTitle =dic[@"name"];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
            break;
            case 10:
        {
            //劳动合同形式
            UIAlertController *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"固定期" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic10 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"无固定期" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic10 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"临时工" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic10 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"劳务派遣" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic10 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
            }]];
            
            [self presentViewController:alert animated:NO completion:nil];
            
        }
            break;
            case 11:
        {
            //试用期（月）
            UIAlertController *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"1个月" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dic=arr_names[indexPath.row];
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic11 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"2个月" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dic=arr_names[indexPath.row];
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic11 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"3个月" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {NSDictionary *dic=arr_names[indexPath.row];
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dic1 setValue:action.title forKey:@"content"];
                dic11 = dic1;
                [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
                [tableV reloadData];
                
            }]];
            
            
            
            
            [self presentViewController:alert animated:NO completion:nil];
        }
            break;
            case 12:
        {
            //上次合同结束原因
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.indexpath =indexPath;
            TVvc.contentTitle =dic[@"name"];
            TVvc.content =dic[@"content"];
            [self.navigationController pushViewController:TVvc animated:NO];
            
        }
            break;
            case 14:
        {
            ///试用期工资
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =dic[@"content"];
            TFvc.contentTitle = dic[@"name"];
            [self.navigationController pushViewController:TFvc animated:NO];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=arr_names[indexPath.row];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic1 setValue:content forKey:@"content"];
    if([dic[@"code"] integerValue]==11)
    {
         dic11 = dic1;
    }
   
    [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
    [tableV reloadData];
}
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    NSString *time2 =[time substringWithRange:NSMakeRange(0, 10)];
    NSDictionary *dic=arr_names[indexPath.row];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic1 setValue:time2 forKey:@"content"];
    [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
    [tableV reloadData];

}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=arr_names[indexPath.row];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic1 setValue:text forKey:@"content"];
    dic12 = dic1;
    [arr_names replaceObjectAtIndex:indexPath.row withObject:dic1];
    [tableV reloadData];
}
#pragma  mark - 自定义的协议代理
-(void)Com_userModel:(Com_UserModel *)model
{
    C_model =model;
    NSDictionary *dic1 =@{@"name":@"签订人",@"code":@"0",@"content":model.username};
    NSDictionary *dic2 = @{@"name":@"所在部门",@"code":@"1",@"content":model.department};
    NSDictionary *dic3 =@{@"name":@"所在岗位",@"code":@"2",@"content":model.post};
    [arr_names replaceObjectAtIndex:0 withObject:dic1];
    [arr_names replaceObjectAtIndex:1 withObject:dic2];
    [arr_names replaceObjectAtIndex:2 withObject:dic3];
    [tableV reloadData];
    
    
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =@{@"name":@"工资发放银行",@"code":@"9",@"content":option};
    [arr_names replaceObjectAtIndex:indexPath.row withObject:dic];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
