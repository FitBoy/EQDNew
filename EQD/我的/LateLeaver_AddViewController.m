//
//  LateLeaver_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LateLeaver_AddViewController.h"
#import "FB_twoTongShi2ViewController.h"
#import "FBTextvImgViewController.h"
#import "Late_leave_ChooseViewController.h"
@interface LateLeaver_AddViewController ()<UITableViewDataSource,UITableViewDelegate,FB_twoTongShi2ViewControllerDelegate,FBTextvImgViewControllerDelegate,Late_leave_ChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    NSArray *arr_img;
    Com_UserModel *model_detail;
    NSString  *date_str;
    NSMutableString  *str_id;
    NSMutableString *str_times;
    BOOL canTijiao;
}

@end

@implementation LateLeaver_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    if(self.isLou==1)
    {
         arr_names =[NSMutableArray arrayWithArray:@[@"消漏打卡时间点",@"原因",@"证明人(可选)",@"审批人"]];
    }else
    {
        arr_names =[NSMutableArray arrayWithArray:@[@"迟到早退时间点",@"原因",@"证明人(可选)",@"审批人"]];
        
    }
    arr_contents =[NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请选择"]];
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString *tstr = dic[Y_ITEMS];
            if(tstr.length!=0)
            {
                canTijiao =YES;
                [arr_contents addObject:dic[Y_ITEMS]];
            }else
            {
                canTijiao=NO;
                [arr_contents addObject:@"无审批人，请联系管理员"];
            }
            [tableV reloadData];
        }
    }];

    self.navigationItem.title =self.isLou==0?@"消迟到早退":@"消漏打卡";
   
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    model_detail = [[Com_UserModel alloc]init];
   model_detail.userGuid =@" ";
}
-(void)tijiaoCLick
{
    
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"]||[arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    
    if (temp==0) {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    if(self.isLou==1)
    {
        [WebRequest Sickleaves_Add_MissClockWithuserGuid:user.Guid choseDate:date_str times:str_times reason:arr_contents[1] witness:model_detail.userGuid  imgArr:arr_img And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });

        }];
        
    }else
    {
    
    [WebRequest  Sickleaves_Add_SickleavesWithuserGuid:user.Guid choseDate:date_str ids:str_id reason:arr_contents[1] witness:model_detail.userGuid imgarr:arr_img And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"都是必选项";
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if (indexPath.row==3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //迟到早退点
            Late_leave_ChooseViewController *Cvc =[[Late_leave_ChooseViewController alloc]init];
            Cvc.isLater=self.isLou+1;
            Cvc.delegate =self;
            Cvc.indexPath =indexPath;
            [self.navigationController pushViewController:Cvc animated:NO];
        }
            break;
        case 1:
        {
           //图文原因
            FBTextvImgViewController *TIvc =[[FBTextvImgViewController alloc]init];
            TIvc.delegate =self;
            TIvc.indexPath =indexPath;
            TIvc.contentTitle =@"图文原因";
            [self.navigationController pushViewController:TIvc animated:NO];
            
        }
            break;
            case 2:
        {
            //证明人
            FB_twoTongShi2ViewController *TSvc =[[FB_twoTongShi2ViewController alloc]init];
            TSvc.indexPath =indexPath;
            TSvc.delegate_tongshiDan =self;
            [self.navigationController pushViewController:TSvc animated:NO];
        }
            break;
        default:
            break;
    }
}

-(void)dakaModelArr:(NSArray *)modelArr indexPath:(NSIndexPath *)indexPath dateStr:(NSString *)date
{
    date_str =date;
    NSMutableString  *tstr =[NSMutableString string];
    str_id =[NSMutableString string];
    str_times =[NSMutableString string];
    for (int i=0; i<modelArr.count; i++) {
        DaKaJiLu *model =modelArr[i];
        if (i==modelArr.count-1) {
            
            self.isLou==0? [tstr appendString:model.createTime]:[tstr appendString:model.clockTime];
            [str_id appendString:model.Id];
            [str_times appendFormat:@"%@/%@",model.clockTime,model.type];
        }else
        {
        self.isLou==0? [tstr appendFormat:@"%@;",model.createTime]:[tstr appendFormat:@"%@;",model.clockTime];
            [str_id appendFormat:@"%@;",model.Id];
            [str_times appendFormat:@"%@/%@;",model.clockTime,model.type];
        }
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:tstr];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    arr_img =imgArr;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    model_detail =model_com;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
