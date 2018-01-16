//
//  FB_notificationAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_notificationAddViewController.h"
#import "PX_PlanViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
@interface FB_notificationAddViewController ()<UITableViewDelegate,UITableViewDataSource,PX_PlanViewControllerDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    PlanListModel  *model_detail;
}

@end

@implementation FB_notificationAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"添加培训通知";
    arr_names = @[@"培训主题",@"受训对象",@"受训人数",@"培训时间",@"培训地点",@"主讲老师",@"讲师介绍",@"课程大纲",@"纪律要求"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"根据主题生成",@"根据主题生成",@"根据主题生成",@"请输入",@"根据主题生成",@"请输入",@"请输入",@"查看"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)quedingClick{
    NSInteger temp = 0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"]) {
            temp =1;
            break;
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Training_Add_trainingNoticeWithuserGuid:user.Guid comid:user.companyId thePlanId:model_detail.Id theplace:arr_contents[4] teacherGuid:model_detail.teacherGuid teacherName:model_detail.teacherName teacherInfo:arr_contents[6] aSyllabus:arr_contents[7] presetReleaseTime:@"" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
            
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"信息填写不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if(indexPath.row==0 || indexPath.row==4 || indexPath.row>5)
    {
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
       cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //通知的主题
        PX_PlanViewController *Pvc = [[PX_PlanViewController alloc]init];
        Pvc.delegate =self;
        [self.navigationController pushViewController:Pvc animated:NO];
        
    }else if(indexPath.row==4)
    {
      //培训地点
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==6 ||indexPath.row==7)
    {
        // 讲师介绍  课程大纲
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==8)
    {
        //查看纪律要求
    }
    else
    {
        
    }
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getPlanListModel:(PlanListModel *)planModel
{
    [WebRequest  Training_Get_trainingPlanDetailWithuserGuid:user.Guid comid:user.companyId planId:planModel.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [PlanListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [arr_contents replaceObjectAtIndex:0 withObject:model_detail.theTheme];
            [arr_contents replaceObjectAtIndex:1 withObject:model_detail.trainees];
            [arr_contents replaceObjectAtIndex:2 withObject:model_detail.personNumber];
            [arr_contents replaceObjectAtIndex:3 withObject:model_detail.theTrainTime];
            [arr_contents replaceObjectAtIndex:5 withObject:model_detail.teacherName];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"服务器错误请重试";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];
    
}


@end
