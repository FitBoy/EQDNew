//
//  CY_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/3.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CY_DetailViewController.h"
#import "RenWu_DetailModel.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "LoadWordViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "commonRenwuModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBShowImg_TextViewController.h"
@interface CY_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    RenWu_DetailModel *D_model;
    UserModel *user;
    NSMutableArray *arr_big;
}

@end

@implementation CY_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [arr_big removeAllObjects];
    [WebRequest Get_Task_InfoWithtaskId:self.renwuID And:^(NSDictionary *dic) {
        D_model =[RenWu_DetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        
        arr_contents =[NSMutableArray arrayWithArray:@[D_model.TaskCode,D_model.TaskName,D_model.parentTaskName,D_model.RS_newRecipient.name,D_model.StartTime,D_model.EndTime,D_model.Duty]];
        if ([D_model.Status integerValue] ==2) {
            //拒绝
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =D_model.RS_newRecipient.name;
            commonM.status =@"已拒绝";
            commonM.contents=D_model.OptionMessage;
            commonM.time=@"";
            [arr_big addObject:commonM];
        }
        else if([D_model.Status integerValue]==1)
        {
            //接受
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =D_model.RS_newRecipient.name;
            commonM.status =@"已接受";
            commonM.contents=D_model.OptionMessage;
            commonM.time=@"";
            [arr_big addObject:commonM];
        }
        else if([D_model.Status integerValue]==3)
        {
            //完成
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =D_model.RS_newRecipient.name;
            commonM.status =@"已完成";
            commonM.contents=D_model.CompleteMessage;
            commonM.imgurls =D_model.CompleteImageUrls;
            commonM.time=D_model.CompleteTime;
            [arr_big addObject:commonM];
        }
        else
        {

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
    
    //获取验收任务的详情
    [WebRequest Get_TaskCheckWithtaskId:self.renwuID And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSDictionary *items =dic[Y_ITEMS];
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.imgurls =items[@"imageUrls"];
            commonM.name =@"验收人";
            commonM.contents =items[@"checkMessage"];
            commonM.status =@"已验收";
           commonM.time = items[@"createTime"];
                [arr_big addObject:commonM];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"任务详情";
    arr_big =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    arr_names=[NSMutableArray arrayWithArray:@[@"任务编码",@"任务名称",@"关联父项目",@"责任人",@"开始时间",@"结束时间",@"责任"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count>0?2:1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents.count:arr_big.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
        //@[@"任务编码",@"任务名称",@"关联父项目",@"责任人",@"开始时间",@"结束时间",@"责任"]];
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
        if (indexPath.row==0||indexPath.row==1||indexPath.row==4||indexPath.row==5) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    return cell;
    }
    else
    {
        static NSString  *cellid1 =@"cellID1";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell =[[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            
        }
        commonRenwuModel *commonM =arr_big[indexPath.row];
        [cell setModel:commonM];
        return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            //关联父项目
            CY_DetailViewController *Dvc =[[CY_DetailViewController alloc]init];
            Dvc.renwuID =D_model.ParentTaskId;
            [self.navigationController pushViewController:Dvc animated:NO];
            
            
        }
        else if (indexPath.row==3)
        {
            //责任人
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:D_model.RS_newRecipient.name message:[NSString stringWithFormat:@"%@-%@",D_model.RS_newRecipient.department,D_model.RS_newRecipient.post] preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:D_model.RS_newRecipient.guid];
                Cvc.navigationItem.title = D_model.RS_newRecipient.name;
                RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:D_model.RS_newRecipient.guid name:D_model.RS_newRecipient.name portrait:D_model.RS_newRecipient.headImage];
                [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:D_model.RS_newRecipient.guid];
                RCUserInfo *userinfo2 = [[RCUserInfo alloc]initWithUserId:user.Guid name:user.username portrait:user.iphoto];
                [[RCIM sharedRCIM] refreshUserInfoCache:userinfo2 withUserId:user.Guid];
                [self.navigationController pushViewController:Cvc animated:NO];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];

            });
            
        }
        else if(indexPath.row==6)
        {
            //责任
            LoadWordViewController *LWvc =[[LoadWordViewController alloc]init];
            LWvc.content=arr_contents[indexPath.row];
            LWvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:LWvc animated:NO];
            
        }else
        {
            
        }
    }
    
        else
        {
            commonRenwuModel *commmodel =arr_big[indexPath.row];
            FBShowImg_TextViewController *Svc =[[FBShowImg_TextViewController alloc]init];
            Svc.contents =commmodel.contents;
            Svc.contentTitle =commmodel.name;
            Svc.arr_imgs =commmodel.imgurls;
            [self.navigationController pushViewController:Svc animated:NO];
        }
    
}




@end
