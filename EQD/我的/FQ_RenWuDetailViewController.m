//
//  FQ_RenWuDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FQ_RenWuDetailViewController.h"
#import "RenWu_DetailModel.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "LoadWordViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "Person_zhihui_xiezhuViewController.h"
#import "CY_DetailViewController.h"
#import "commonRenwuModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBShowImg_TextViewController.h"
@interface FQ_RenWuDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    RenWu_DetailModel *detailModel;
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_big;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation FQ_RenWuDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [arr_big removeAllObjects];
    [WebRequest  Get_Task_InfoWithtaskId:self.model.ID And:^(NSDictionary *dic) {
        NSDictionary *dic2 =dic[Y_ITEMS];
        detailModel = [RenWu_DetailModel mj_objectWithKeyValues:dic2];
        //@[@"任务编码",@"任务名称",@"任务描述",@"关联父项目",@"责任人",@"协助人",@"知会人",@"开始时间",@"结束时间",@"验收标准",@"验收人",@"验收时间",@"责任"]
        
        arr_contents =[NSMutableArray arrayWithArray:@[detailModel.TaskCode,detailModel.TaskName,detailModel.TaskDesc,detailModel.parentTaskName,detailModel.RS_newRecipient.name,[NSString stringWithFormat:@"%ld个",detailModel.RS_newAssist.count],[NSString stringWithFormat:@"%ld个",detailModel.RS_newNotify.count],detailModel.StartTime,detailModel.EndTime,detailModel.CheckStandard,detailModel.RS_newChecker.name,detailModel.CheckTime,detailModel.Duty]];
        if ([detailModel.Status integerValue] ==2) {
            //拒绝
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =detailModel.RS_newRecipient.name;
            commonM.status =@"已拒绝";
            commonM.contents=detailModel.OptionMessage;
            commonM.time=@"";
            [arr_big addObject:commonM];
        }
        else if([detailModel.Status integerValue]==1)
        {
            //接受
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =detailModel.RS_newRecipient.name;
            commonM.status =@"已接受";
            commonM.contents=detailModel.OptionMessage;
            commonM.time=@"";
            [arr_big addObject:commonM];
        }
        else if([detailModel.Status integerValue]==3)
        {
            //完成
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =detailModel.RS_newRecipient.name;
            commonM.status =@"已完成";
            commonM.contents=detailModel.CompleteMessage;
            commonM.imgurls =detailModel.CompleteImageUrls;
            commonM.time=detailModel.CompleteTime;
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
    [WebRequest Get_TaskCheckWithtaskId:self.model.ID And:^(NSDictionary *dic) {
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
    self.navigationItem.title = @"任务详情";
    user =[WebRequest GetUserInfo];
    arr_big =[NSMutableArray arrayWithCapacity:0];
    arr_one =[NSMutableArray arrayWithArray:@[@"任务编码",@"任务名称",@"任务描述",@"关联父项目",@"责任人",@"协助人",@"知会人",@"开始时间",@"结束时间",@"验收标准",@"验收人",@"验收时间",@"责任"]];
    arr_contents=[NSMutableArray arrayWithCapacity:0];
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
    return  section==0?arr_contents.count:arr_big.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row==0||indexPath.row==1||indexPath.row==7||indexPath.row==8||indexPath.row==11)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left0.text =arr_one[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
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
  if(indexPath.section==0)
  {
      switch (indexPath.row) {
          case 2:
          {
           //任务描述
              LoadWordViewController *LWvc =[[LoadWordViewController alloc]init];
              LWvc.contentTitle=arr_one[indexPath.row];
              LWvc.content=arr_contents[indexPath.row];
              [self.navigationController pushViewController:LWvc animated:NO];
              
          }
              break;
          case 3:
          {
              //关联父项目
              CY_DetailViewController *Dvc =[[CY_DetailViewController alloc]init];
              Dvc.renwuID =detailModel.ParentTaskId;
              [self.navigationController pushViewController:Dvc animated:NO];
            }
              break;
          case 4:
          {
              //责任人
              UIAlertController *alert =[UIAlertController alertControllerWithTitle:detailModel.RS_newRecipient.name message:[NSString stringWithFormat:@"%@-%@",detailModel.RS_newRecipient.department,detailModel.RS_newRecipient.post] preferredStyle:UIAlertControllerStyleActionSheet];
              [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:detailModel.RS_newRecipient.guid];
                  Cvc.navigationItem.title = detailModel.RS_newRecipient.name;
                  RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:detailModel.RS_newRecipient.guid name:detailModel.RS_newRecipient.name portrait:detailModel.RS_newRecipient.headImage];
                  [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:detailModel.RS_newRecipient.guid];
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
              break;
          case 5:
          {
             //协助人
              Person_zhihui_xiezhuViewController *PZXvc =[[Person_zhihui_xiezhuViewController alloc]init];
              PZXvc.arr_list =detailModel.RS_newAssist;
              PZXvc.contentTitle=arr_one[indexPath.row];
              [self.navigationController pushViewController:PZXvc animated:NO];
              
          }
              break;
          case 6:
          {
             //知会人
              Person_zhihui_xiezhuViewController *PZXvc =[[Person_zhihui_xiezhuViewController alloc]init];
              PZXvc.arr_list =detailModel.RS_newNotify;
              PZXvc.contentTitle=arr_one[indexPath.row];
              [self.navigationController pushViewController:PZXvc animated:NO];

          }
              break;
          case 9:
          {
              //验收标准
              LoadWordViewController *LWvc =[[LoadWordViewController alloc]init];
              LWvc.contentTitle=arr_one[indexPath.row];
              LWvc.content=arr_contents[indexPath.row];
              [self.navigationController pushViewController:LWvc animated:NO];

          }
              break;
          case 10:
          {
//             验收人
              UIAlertController *alert =[UIAlertController alertControllerWithTitle:detailModel.RS_newChecker.name message:[NSString stringWithFormat:@"%@-%@",detailModel.RS_newChecker.department,detailModel.RS_newChecker.post] preferredStyle:UIAlertControllerStyleActionSheet];
              [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:detailModel.RS_newChecker.guid];
                  Cvc.navigationItem.title = detailModel.RS_newRecipient.name;
                  RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:detailModel.RS_newChecker.guid name:detailModel.RS_newChecker.name portrait:detailModel.RS_newChecker.headImage];
                  [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:detailModel.RS_newChecker.guid];
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
              break;
          case 12:
          {
//             责任
              LoadWordViewController *LWvc =[[LoadWordViewController alloc]init];
              LWvc.contentTitle=arr_one[indexPath.row];
              LWvc.content=arr_contents[indexPath.row];
              [self.navigationController pushViewController:LWvc animated:NO];

          }
              break;
          default:
              break;
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
