//
//  SQXuQiuPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/3.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQXuQiuPersonViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBBuMenChooseViewController.h"
#import "DatePicer_AlertView.h"
#import "FBGangWei_DetailViewController.h"

@interface SQXuQiuPersonViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FBBuMenChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView  *date_alert;
    GangweiModel *model_gangWei;
    BOOL canTijiao;
}

@end

@implementation SQXuQiuPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"人力需求申请";
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    
      arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"职位编制人数",@"职位现有人数",@"待离职人数",@"请输入",@"请输入",@"查看",@"请选择",@"请输入",@"请选择"]];
   
    
    arr_names = [NSMutableArray arrayWithArray:@[@"申请职位",@"职位编制人数",@"职位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作职责",@"要求到岗时间",@"备注",@"招聘渠道",@"审批人"]];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(shenqingCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
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
    
   
    
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents  replaceObjectAtIndex:7 withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [date_alert removeFromSuperview];
}
-(void)shenqingCLick
{
    NSInteger  temp=0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"]) {
            temp=1;
            break;
        }
    }
    
    if (temp==0 && canTijiao==YES) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest manPowerNeed_Add_mpnWithuserGuid:user.Guid depid:user.departId postid:model_gangWei.ID XYrenshu:arr_contents[2] DLZrenshu:arr_contents[3] recruitRenShu:arr_contents[4] recruitReason:arr_contents[5] demandAtWorkTime:arr_contents[7] remark:arr_contents[8] recruitType:arr_contents[9] comid:user.companyId createrName:user.Guid And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        hud.label.text =@"参数不完整";
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
    }
    if((indexPath.row>0 && indexPath.row<4) || indexPath.row==6 )
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            case 0:
        {
            FBBuMenChooseViewController  *Mvc =[[FBBuMenChooseViewController alloc]init];
            Mvc.delegate =self;
            Mvc.departId = user.departId;
            Mvc.comId = user.companyId;
            [self.navigationController pushViewController:Mvc animated:NO];
        }
            break;
        case 4:
        {
            //申请人数
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_contents[indexPath.row];
            TFvc.contentTitle = arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
            break;
        case 5:
        {
           //招聘原因
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.indexpath =indexPath;
            TVvc.contentTitle =arr_names[indexPath.row];
            TVvc.content=arr_contents[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
            
        }
            break;
            case 6:
        {
            if (model_gangWei==nil) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"请先选择岗位";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }else
            {
                FBGangWei_DetailViewController  *Dvc = [[FBGangWei_DetailViewController alloc]init];
                Dvc.model =model_gangWei;
                [self.navigationController pushViewController:Dvc animated:NO];
            }
            
        }
            break;
            case 7:
        {
           //要求到岗时间
            [self.view addSubview:date_alert];
          
            
        }
            break;
            case 8:
        {
            //备注
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle = arr_names[indexPath.row];
            TVvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }
            break;
            case 9:
        {
            UIAlertController  *alert = [[UIAlertController alloc]init];
             NSArray  *tarr = @[@"内招",@"外招",@"内外招"];
            for(int i=0;i<tarr.count;i++)
            {
                [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_contents replaceObjectAtIndex:9 withObject:tarr[i]];
                    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }]];
                
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:NO completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma  mark - 自定义的协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)getGangWei:(GangweiModel *)model
{
    [arr_contents replaceObjectAtIndex:0 withObject:model.name];
    model_gangWei = model;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载数据";
    [WebRequest Com_Get_postRenShu_AllTypeWithuserGuid:user.Guid comid:user.companyId postid:model.ID And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString  *one = [NSString stringWithFormat:@"%@",dic[@"BZrenshu"]];
            NSString *two =[NSString stringWithFormat:@"%@",dic[@"XYrenshu"]];
            NSString *three = [NSString stringWithFormat:@"%@",dic[@"DLZrenshu"]];
            [arr_contents replaceObjectAtIndex:1 withObject:one];
            [arr_contents replaceObjectAtIndex:2 withObject:two];
            [arr_contents replaceObjectAtIndex:3 withObject:three];
            [tableV reloadData];
        }
    }];
}

@end
