//
//  YQChengYuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "YQChengYuanViewController.h"
#import "CYShuRuViewController.h"
#import "FBTextFieldTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "FBTwo_Button12TableViewCell.h"
@interface YQChengYuanViewController ()<UITableViewDelegate,UITableViewDataSource,CYShuRuViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_chengyuan;
    ComModel *com;
    UserModel *user;
    UITextField *TF_text;
    NSMutableArray *arr_phone;
}

@end

@implementation YQChengYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_phone=[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =[NSString stringWithFormat:@"%@入职邀请",self.model.name];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    arr_chengyuan =[NSMutableArray arrayWithCapacity:0];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发送邀请" style:UIBarButtonItemStylePlain target:self action:@selector(yaoqingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)yaoqingClick
{
    //发送邀请
    NSMutableArray *tarr =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_phone.count; i++) {
        FBPeople *Person =arr_phone[i];
        [tarr addObject:Person.phone];
    }
    [tarr insertObjects:arr_chengyuan atIndexes:[NSIndexSet indexSetWithIndex:0]];
    
    if (tarr.count==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"您未选择人员";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
        
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在邀请";
 [WebRequest Com_Add_NewStaffWithphones:tarr companyId:user.companyId company:user.company departId:self.model.departid department:self.name_bumen postId:self.model.ID post:self.model.name userGuid:user.Guid user:user.uname And:^(NSDictionary *dic) {
     hud.label.text=dic[Y_MSG];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [hud hideAnimated:NO];
         [self.navigationController popViewControllerAnimated:NO];
         
     });
 }];
        
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    else if(section==1)
    {
        return arr_chengyuan.count;
    }
    else
    {
        return arr_phone.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UITableViewCell *cell =[[UITableViewCell alloc]init];
            cell.textLabel.text = @" + 通讯录添加人员";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
       else if (indexPath.row==1)
       {
           FBTextFieldTableViewCell *cell = [[FBTextFieldTableViewCell alloc]init];
           [cell setPlaceHolder:@"被邀请人的手机号"];
           TF_text =cell.TF_text;
           cell.selectionStyle= UITableViewCellSelectionStyleNone;
           return cell;
       }
     else
     {
         UITableViewCell *cell =[[UITableViewCell alloc]init];
         cell.textLabel.text=@"添加";
         cell.textLabel.textAlignment=NSTextAlignmentCenter;
         return cell;
     }
    }
    else if(indexPath.section==1)
    {
        static NSString *cellid =@"cellid1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text=arr_chengyuan[indexPath.row];
        return cell;
    }
    else
    {
        static NSString *cellid =@"cellid2";
        FBTwo_Button12TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[FBTwo_Button12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FBPeople *person=arr_phone[indexPath.row];
        cell.L_name.text =person.name;
        cell.L_number.text=person.phone;
        return cell;
    }
    return nil;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
//            选择通讯录的联系人邀请
            CYShuRuViewController *SRvc =[[CYShuRuViewController alloc]init];
            SRvc.delegate =self;
            SRvc.arr_pre =arr_phone;
            SRvc.arr_shoudong=[NSMutableArray arrayWithArray:arr_chengyuan];
            [self.navigationController pushViewController:SRvc animated:NO];
        }
        else if(indexPath.row==2)
        {
            //添加手机号
            [arr_chengyuan insertObject:TF_text.text atIndex:0];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        /*    if ([RCKitUtility validateCellPhoneNumber:TF_text.text]) {
              
                
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"手机号的格式不正确";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }*/
        }
        else
        {
            
        }
    }
    
    else
    {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)numberarr:(NSArray *)numberArr shoudong:(NSArray *)shoudong
{
    arr_chengyuan =[NSMutableArray arrayWithArray:shoudong];
    arr_phone = [NSMutableArray arrayWithArray:numberArr];
    [tableV reloadData];
}
#pragma mark - 删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
   return indexPath.section==0?NO:YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //拒绝邀请
        if (indexPath.section==1) {
            [arr_chengyuan removeObjectAtIndex:indexPath.row];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexPath.row] withRowAnimation:UITableViewRowAnimationNone];
        }
        else if(indexPath.row==2)
        {
            [arr_phone removeObjectAtIndex:indexPath.row];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexPath.row] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}




@end
