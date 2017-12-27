//
//  HeTong_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "HeTong_DetailViewController.h"
#import "HeTong_DetailModel.h"
#import "FBTwoButtonView.h"
#import "FBTextFieldViewController.h"
#import "ShenPiListModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "NSString+FBString.h"
@interface HeTong_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    HeTong_DetailModel *model_detial;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UITableView *tableV;
    NSInteger section_number;
    UserModel *user;
    NSMutableArray *arr_shenpi;
}

@end

@implementation HeTong_DetailViewController

-(void)loadRequestData{
    
    [WebRequest Contracts_Get_Contract_ByIdWithcontractId:self.model.ID And:^(NSDictionary *dic) {
        model_detial =[HeTong_DetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
       
        arr_contents =[NSMutableArray arrayWithArray:@[model_detial.contractCode,model_detial.signatoryName,model_detial.department,model_detial.post,model_detial.signEntryTime,model_detial.contractType,model_detial.contractForm,model_detial.probation,model_detial.contractNature,model_detial.signedNumber,model_detial.lastReason,model_detial.contractStartTime,model_detial.contractEndTime,model_detial.bank,model_detial.ProbationSalary,model_detial.openBank.length==0?@"请输入":model_detial.openBank,model_detial.bankCard.length==0?@"请输入":model_detial.bankCard]];
        
        
      if (model_detial.contractForm.length==0) {
            [arr_names removeObject:@"劳动合同形式"];
            [arr_contents removeObject:model_detial.contractForm];
        }
        if (model_detial.probation.length==0) {
            [arr_names removeObject:@"试用期（月）"];
            [arr_contents removeObject:model_detial.probation];
        }
        if (model_detial.signedNumber.length==0) {
            [arr_names removeObject:@"合同签订次数"];
            [arr_contents removeObject:model_detial.signedNumber];
        }
        if (model_detial.lastReason.length==0) {
            [arr_names removeObject:@"上次合同结束原因"];
            [arr_contents removeObject:model_detial.lastReason];
        }
        [tableV reloadData];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    section_number =1;
    self.navigationItem.title =@"合同详情";
    arr_names=[NSMutableArray arrayWithArray:@[@"合同编码",@"签订人",@"签订人所在部门",@"签订人所在岗位",@"入职时间",@"合同类型",@"劳动合同形式",@"试用期（月）",@"合同性质",@"合同签订次数",@"上次合同结束原因",@"合同开始时间",@"合同结束时间",@"工资发放银行",@"试用期工资",@"工资卡开户行",@"工资卡账号"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    
    [WebRequest Contracts_Get_CheckWithcontractId:self.model.ID And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
           
        }
         section_number =2;
        [tableV reloadData];
        
    }];
   
    [self loadRequestData];
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==section_number-1 && self.isQianDing!=0) {
        return 50;
    }
    else
    {
        return 1;
    }
}
-(void)rightClick
{
    
    if ([arr_contents[arr_contents.count-1] isEqualToString:@"请输入"] ||[arr_contents[arr_contents.count-2] isEqualToString:@"请输入"]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"开户行或银行账号不能为空";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    
    //确认
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在确认";
    if(self.isQianDing==1)
    {
        //签订
     
        [WebRequest Contracts_Set_Contract_BySignatoryWithcontractId:self.model.ID userGuid:user.Guid message:@" " type:@"1" bankCard:arr_contents[arr_contents.count-1] openBank:arr_contents[arr_contents.count-2] And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
        
    }else if(self.isQianDing ==2){
        //人事的审批
        [WebRequest Contracts_Set_Contract_ByCreaterWithcontractId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
        
     }else if (self.isQianDing==3)
     {
        ///领导的审批
         [WebRequest Contracts_Set_Contract_ByLeaderWithcontractId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
             hud.label.text =dic[Y_MSG];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [hud hideAnimated:NO];
                 [self.navigationController popViewControllerAnimated:NO];
             });
  
         }];
         
     }else
     {
         
     }
    
    }
}
-(void)leftClick
{
    //驳回
   
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder =@"拒绝理由";
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
                
                if (self.isQianDing==1) {
                    [WebRequest Contracts_Set_Contract_BySignatoryWithcontractId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" bankCard:@" " openBank:@" " And:^(NSDictionary *dic) {
                        hud.label.text =dic[Y_MSG];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [hud hideAnimated:NO];
                            [self.navigationController popViewControllerAnimated:NO];
                        });
                    }];
                }else if (self.isQianDing==2)
                {
                    [WebRequest Contracts_Set_Contract_ByCreaterWithcontractId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                        hud.label.text =dic[Y_MSG];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [hud hideAnimated:NO];
                            [self.navigationController popViewControllerAnimated:NO];
                        });
                    }];
                }else if(self.isQianDing==3)
                {
                   [WebRequest Contracts_Set_Contract_ByLeaderWithcontractId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                       hud.label.text =dic[Y_MSG];
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [hud hideAnimated:NO];
                           [self.navigationController popViewControllerAnimated:NO];
                       });
                   }];
                    
                }else
                {
                    
                }
               
            }
            
        }]];
   }
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==section_number-1 && self.isQianDing!=0) {
        FBTwoButtonView *Tview =[[FBTwoButtonView alloc]init];
        [Tview setleftname:@"拒绝" rightname:@"确认"];
        [Tview.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [Tview.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        
        return Tview;
    }else
    {
        return nil;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return section_number;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_contents.count;
    }else
    {
        return arr_shenpi.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
        }
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        if (self.isQianDing==1 &&(indexPath.row==arr_contents.count-1 || indexPath.row==arr_contents.count-2)) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
        }
        ShenPiListModel *model =arr_shenpi[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (self.isQianDing==1 &&(indexPath.row==arr_contents.count-1 || indexPath.row==arr_contents.count-2)) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.contentTitle =arr_names[indexPath.row];
            TFvc.content =arr_contents[indexPath.row];
            TFvc.indexPath =indexPath;
            TFvc.delegate =self;
            [self.navigationController pushViewController:TFvc animated:NO];
        }
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==arr_contents.count-1) {
        //银行卡账号
       if( [NSString checkCardNo:content]==NO)
       {
           MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
           hud.mode = MBProgressHUDModeText;
           hud.label.text =@"不符合银行卡号规则";
           dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
           dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
               [MBProgressHUD hideHUDForView:self.view  animated:YES];
           });
       }else
       {
         [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
       }
    }else
    {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    }
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
