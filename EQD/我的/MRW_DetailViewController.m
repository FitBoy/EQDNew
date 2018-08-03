//
//  MRW_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MRW_DetailViewController.h"
#import "RenWu_DetailModel.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "LoadWordViewController.h"
#import "Person_zhihui_xiezhuViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "FBTwoButtonView.h"
#import "FBTextvImgViewController.h"
#import "CY_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "commonRenwuModel.h"
#import "FBShowImg_TextViewController.h"
@interface MRW_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextvImgViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_contents;
    RenWu_DetailModel *Detail_model;
    UserModel *user;
    NSMutableArray *arr_big;
    FBTwoButtonView *TBV;
}

@end

@implementation MRW_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [arr_big removeAllObjects];
    [WebRequest Get_Task_InfoWithtaskId:self.model.ID And:^(NSDictionary *dic) {
        NSDictionary *dic2 =dic[Y_ITEMS];
        Detail_model = [RenWu_DetailModel mj_objectWithKeyValues:dic2];
        //@[@"任务编码",@"任务名称",@"任务描述",@"关联父项目",@"协助人",@"开始时间",@"结束时间",@"验收标准",@"验收人",@"验收时间",@"责任",@"发起人"]
        arr_contents =[NSMutableArray arrayWithArray:@[Detail_model.TaskCode,Detail_model.TaskName,Detail_model.TaskDesc,Detail_model.parentTaskName,[NSString stringWithFormat:@"%ld个",Detail_model.RS_newAssist.count],Detail_model.StartTime,Detail_model.EndTime,Detail_model.CheckStandard,Detail_model.RS_newChecker.name,Detail_model.CheckTime,Detail_model.Duty,Detail_model.RS_newInitiator.name]];
        if ([Detail_model.Status integerValue] ==2) {
            //拒绝
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =Detail_model.RS_newRecipient.name;
            commonM.status =@"已拒绝";
            commonM.contents=Detail_model.OptionMessage;
            commonM.time=@"";
            [arr_big addObject:commonM];
        }
        else if([Detail_model.Status integerValue]==1)
        {
            //接受
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =Detail_model.RS_newRecipient.name;
            commonM.status =@"已接受";
            commonM.contents=Detail_model.OptionMessage;
            commonM.time =@"";
            [arr_big addObject:commonM];
        }
        else if([Detail_model.Status integerValue]==3)
        {
            //完成
            commonRenwuModel *commonM =[[commonRenwuModel alloc]init];
            commonM.name =Detail_model.RS_newRecipient.name;
            commonM.status =@"已完成";
            commonM.contents=Detail_model.CompleteMessage;
            commonM.imgurls =Detail_model.CompleteImageUrls;
            commonM.time =Detail_model.CompleteTime;
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
    user =[WebRequest GetUserInfo];
    arr_big =[NSMutableArray arrayWithCapacity:0];
    TBV=[[FBTwoButtonView alloc]init];
    [TBV setleftname:@"拒绝" rightname:@"接受"];
    [TBV.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
    [TBV.B_right addTarget:self action:@selector(jieshouClick) forControlEvents:UIControlEventTouchUpInside];
    TBV.frame =CGRectMake(0, 0, DEVICE_WIDTH, 40);
    self.navigationItem.title =@"任务详情";
     arr_one =[NSMutableArray arrayWithArray:@[@"任务编码",@"任务名称",@"任务描述",@"关联父项目",@"协助人",@"开始时间",@"结束时间",@"验收标准",@"验收人",@"验收时间",@"责任",@"发起人"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    NSString *tstr =@"接受";
    if ([Detail_model.Status integerValue]==1) {
        tstr =@"完成";
    }
    else if ([Detail_model.Status integerValue]==0)
    {
        tstr=@"接受";
    }
    else
    {
        
    }
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:tstr style:UIBarButtonItemStylePlain target:self action:@selector(jieshouClick)];
//    [self.navigationItem setRightBarButtonItem:right];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([Detail_model.Status integerValue]==0|| [Detail_model.Status integerValue]==1) {
        return section==arr_big.count?40:1;
    }
  else
  {
      return 1;
  }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==arr_big.count && [Detail_model.Status integerValue]==0) {
        return TBV;
    }
    else if(section==arr_big.count && [Detail_model.Status integerValue]==1)
    {
        UIButton *tbtn =[UIButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"完成" forState:UIControlStateNormal];
        [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tbtn setBackgroundColor:EQDCOLOR];
        [tbtn addTarget:self action:@selector(jieshouClick) forControlEvents:UIControlEventTouchUpInside];
        
        return tbtn;
    }
    else
    {
        return nil;
    }
}
-(void)jujueClick
{
    //拒绝任务
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"理由";
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
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在拒绝";
            [WebRequest  Set_RefuseTaskWithtaskId:Detail_model.ID userGuid:user.Guid message:alert.textFields[0].text name:user.username And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
        }
        
        
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];

    });
}
-(void)jieshouClick
{
    //接受任务
    if ([Detail_model.Status integerValue]==0) {
        //接受任务
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在接受";
        [WebRequest Set_AgreeTaskWithtaskId:Detail_model.ID userGuid:user.Guid message:@"接受" name:user.username And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
                
            });
        }];
    }
    else if([Detail_model.Status integerValue]==1)
    {
        //完成
        FBTextvImgViewController *TIvc =[[FBTextvImgViewController alloc]init];
        TIvc.indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
        TIvc.delegate =self;
        TIvc.contentTitle =@"完成任务需要的说明";
        [self.navigationController pushViewController:TIvc animated:NO];
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
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
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==0||indexPath.row==1||indexPath.row==5||indexPath.row==6||indexPath.row==9) {
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
        if (indexPath.row==2||indexPath.row==7||indexPath.row==10) {
            //任务描述
            LoadWordViewController *LWvc =[[LoadWordViewController alloc]init];
            LWvc.contentTitle =arr_one[indexPath.row];
            LWvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:LWvc animated:NO];
        }
        else if(indexPath.row==3)
        {
            //关联父项目
            if ([Detail_model.ParentTaskId integerValue]!=0) {
            
            CY_DetailViewController *Dvc =[[CY_DetailViewController  alloc]init];
            Dvc.renwuID =Detail_model.ParentTaskId;
            [self.navigationController pushViewController:Dvc animated:NO];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"暂无父级项目";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
        }
        else if(indexPath.row==4)
        {
            //协助人
            Person_zhihui_xiezhuViewController *Pvc =[[Person_zhihui_xiezhuViewController alloc]init];
            Pvc.arr_list =Detail_model.RS_newAssist;
            Pvc.contentTitle=arr_one[indexPath.row];
            [self.navigationController pushViewController:Pvc animated:NO];
            
        }
        else if(indexPath.row==8)
            
        {
            //验收人
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:Detail_model.RS_newChecker.name message:[NSString stringWithFormat:@"%@-%@",Detail_model.RS_newChecker.department,Detail_model.RS_newChecker.post] preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:Detail_model.RS_newChecker.guid];
                Cvc.navigationItem.title = Detail_model.RS_newRecipient.name;
                RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:Detail_model.RS_newChecker.guid name:Detail_model.RS_newChecker.name portrait:Detail_model.RS_newChecker.headImage];
                [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:Detail_model.RS_newChecker.guid];
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
       
        else if(indexPath.row==11)
        {
            //发起人
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:Detail_model.RS_newInitiator.name message:[NSString stringWithFormat:@"%@-%@",Detail_model.RS_newInitiator.department,Detail_model.RS_newInitiator.post] preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:Detail_model.RS_newInitiator.guid];
                Cvc.navigationItem.title = Detail_model.RS_newInitiator.name;
                RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:Detail_model.RS_newInitiator.guid name:Detail_model.RS_newInitiator.name portrait:Detail_model.RS_newInitiator.headImage];
                [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:Detail_model.RS_newInitiator.guid];
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
        else
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

-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    [WebRequest Set_CompleteTaskWithtaskId:Detail_model.ID userGuid:user.Guid message:text imgs:imgArr And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
}


@end
