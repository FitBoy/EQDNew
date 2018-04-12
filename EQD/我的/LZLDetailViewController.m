//
//  LZLDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LZLDetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "liZhiListModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBTwoButtonView.h"
@interface LZLDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_onecontents;
    UserModel *user;
    NSMutableArray *arr_recordList;
    LiZhiModel *model_detail;
}

@end

@implementation LZLDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
  
    [WebRequest User_GetQuitRecordListWithquitId:self.model.ID And:^(NSDictionary *dic) {
        [arr_recordList removeAllObjects];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            
            for (int i=0; i<tarr.count; i++) {
                liZhiListModel *model =[liZhiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_recordList addObject:model];
            }
             [tableV reloadData];
        }
        
       

    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_recordList =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"离职单详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_one =[NSMutableArray arrayWithArray:@[@"编码",@"申请人",@"所在部门",@"所在职位",@"工号",@"入职时间",@"预计离职时间",@"离职类型",@"离职原因",@"等待审批"]];
    
    [WebRequest  User_GetQuitInfoWithquitId:self.model.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [LiZhiModel  mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_onecontents =[NSMutableArray arrayWithArray:@[model_detail.code,model_detail.uname,model_detail.department,model_detail.post,model_detail.jobNumber,model_detail.joinTime,model_detail.quitTime,model_detail.quitType,model_detail.quitReason,model_detail.nextCheckerName]];
            [tableV reloadData];
        }
     
    }];
    
   
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==(arr_recordList.count==0?0:1) &&self.isshenpi>0) {
        FBTwoButtonView  *twoB =[[FBTwoButtonView alloc]init];
        [twoB setleftname:@"驳回" rightname:@"同意"];
        [twoB.B_left addTarget:self action:@selector(jujueCLick) forControlEvents:UIControlEventTouchUpInside];
        [twoB.B_right addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
        
        return twoB;
    }else
    {
        return nil;
    }
}
-(void)jujueCLick
{
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入驳回原因" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"驳回原因";
    }];
    [alert  addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在驳回";
        if (self.isshenpi==1) {
            [WebRequest Quit_Set_Quit_ByLeaderWithquitId:model_detail.quitId userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            }];
        }else if(self.isshenpi==2)
        {
            [WebRequest Quit_Set_Quit_ByHRWithquitId:model_detail.quitId userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            }];
        }else
        {
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
}
-(void)tongyiClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    if (self.isshenpi==1) {
        [WebRequest Quit_Set_Quit_ByLeaderWithquitId:model_detail.quitId userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        }];
    }else if(self.isshenpi==2)
    {
        [WebRequest Quit_Set_Quit_ByHRWithquitId:model_detail.quitId userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        }];
    }else
    {
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
        
        
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_recordList.count==0?1:2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_onecontents.count;
    }
    else
    {
        return arr_recordList.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            cell.L_left0.text =arr_one[indexPath.row];
            cell.L_right0.text=arr_onecontents[indexPath.row];
        return cell;
    }
    
    else
    {
        static NSString *cellid0 =@"cellid0";
        FBFour_noimgTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellid0];
        if(!cell)
        {
            cell =[[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid0];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        liZhiListModel *model =arr_recordList[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    
}






@end
