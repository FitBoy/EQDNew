//
//  Traffic_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Traffic_AddViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextFieldViewController.h"
#import "FBTextvImgViewController.h"
@interface Traffic_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextvImgViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView  *date_alert;
    NSArray *arr_imgs;
}

@end

@implementation Traffic_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"添加违章记录";
    user =[WebRequest GetUserInfo];
    arr_names =@[@"车号",@"违章人",@"违章时间",@"违章原因",@"扣罚(扣分与罚款)",@"是否处理"];
    arr_contents = [NSMutableArray arrayWithArray:@[self.plteNumber,@"请输入",@"请选择",@"请输入",@"请输入",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)TijiaoClick
{
    NSInteger  temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] ||[arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    // arr_names =@[@"车号",@"违章人",@"违章时间",@"违章原因",@"扣罚(扣分与罚款)",@"是否处理"];
    if (temp==0) {
        NSString *tstr = [arr_contents[5] isEqualToString:@"已处理"]?@"true":@"false";
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Com_Vehicle_Add_vehiclelllegalWithuserGuid:user.Guid comid:user.companyId createrName:user.username vehicleId:self.Id plateNumber:arr_contents[0] personLiableName:arr_contents[1] theFine:arr_contents[4] theDate:arr_contents[2] theReason:arr_contents[3] isdone:tstr arr_imgs:arr_imgs And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if (([dic[Y_STATUS] integerValue]==200)) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"所有内容都是必填项";
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
    [arr_contents replaceObjectAtIndex:2 withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    if (indexPath.row==0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1|| indexPath.row==4) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==2)
    {
        [self.view addSubview:date_alert];
    }else if (indexPath.row==5)
    {
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"已处理",@"未处理"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }else if (indexPath.row==3)
    {
        FBTextvImgViewController *IVvc =[[FBTextvImgViewController alloc]init];
        IVvc.delegate =self;
        IVvc.contentTitle =arr_names[indexPath.row];
        IVvc.indexPath =indexPath;
        [self.navigationController pushViewController:IVvc animated:NO];
    }
    else
    {
    }
}
#pragma  mark -  自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    arr_imgs =imgArr;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
