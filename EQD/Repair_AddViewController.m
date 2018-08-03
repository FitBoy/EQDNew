//
//  Repair_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Repair_AddViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextFieldViewController.h"
#import "FBTextvImgViewController.h"
#import "Car_managerOnlyViewController.h"
#import "CarManager_DetailViewController.h"
@interface Repair_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextvImgViewControllerDelegate,Car_managerOnlyViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView  *date_alert;
    CarManagerModel  *model_only;
    NSArray *arr_imgs;
}

@end

@implementation Repair_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"添加保养/维修记录";
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    arr_names = [NSMutableArray arrayWithArray:@[@"*车",@"*保养/维修时间",@"*保养/维修地点",@"*保养/维修花费(元)",@"*保养/维修",@"*保养维修人",@"备注"]];
    arr_contents =[NSMutableArray arrayWithArray:@[_model.plateNumber,@"请选择",@"请输入",@"请输入",@"请选择",user.username,@"请输入"]];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    model_only = self.model;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)TijiaoClick
{
    //提交
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count-1; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] ||[arr_contents[i] isEqualToString:@"请输入"] ) {
            temp=1;
            break;
        }
    }
    if ([arr_contents[5] isEqualToString:@"请输入"]) {
        arr_contents[5] =@" ";
    }
    
    if (temp ==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Com_Vehicle_Add_repairedRecordVWithuserGuid:user.Guid comid:user.companyId createrName:user.username vehicleId:model_only.Id plateNumber:model_only.plateNumber type:arr_contents[4] agent:arr_contents[5] when:arr_contents[1] cost:arr_contents[3] where:arr_contents[2] remark:arr_contents[6] arr_imgs:arr_imgs And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        hud.label.text =@"带*为必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents replaceObjectAtIndex:1 withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
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
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [NSMutableArray arrayWithArray:@[@"*车",@"*时间",@"*地点",@"*保养/维修花费(元)",@"备注"]];
    if (indexPath.row==0) {
        if ([self.model.Id integerValue]==0) {
            Car_managerOnlyViewController  *Ovc =[[Car_managerOnlyViewController alloc]init];
            Ovc.isChoose=1;
            Ovc.delegate=self;
            [self.navigationController pushViewController:Ovc animated:NO];
        }else
        {
            CarManager_DetailViewController  *Dvc =[[CarManager_DetailViewController alloc]init];
            Dvc.Id =_model.Id;
            [self.navigationController pushViewController:Dvc animated:NO];
        }
    }else if (indexPath.row==1)
    {
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }else if (indexPath.row==2 || indexPath.row==3)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==6)
    {
        FBTextvImgViewController  *IVvc =[[FBTextvImgViewController alloc]init];
        IVvc.delegate =self;
        IVvc.indexPath =indexPath;
        IVvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:IVvc animated:NO];
    }else if (indexPath.row==4)
    {
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"维修",@"保养"];
        for(int i=0;i<tarr.count;i++)
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:4 withObject:tarr[i]];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }else if (indexPath.row==5)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }
    else
    {
    }
}
#pragma  mark - 自定义的协议代理
-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    arr_imgs =imgArr;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getCar_managerOnlyModel:(CarManagerModel *)model
{
    model_only = model;
    [arr_contents replaceObjectAtIndex:0 withObject:model.plateNumber];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}



@end
