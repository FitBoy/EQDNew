//
//  GLChance_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLChance_DetailViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBOptionViewController.h"
#import "GLLianXiRenViewController.h"
#import "DatePicer_AlertView.h"
@interface GLChance_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate>
{
    NSMutableArray *arr_names;
    UITableView *tableV;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView *date_alert;
    NSArray *arr_key;
}

@end

@implementation GLChance_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"销售机会详情";
    user =[WebRequest GetUserInfo];
   arr_names = [NSMutableArray arrayWithArray:@[@"机会名称",@"机会分类",@"客户",@"联系人",@"兴趣产品",@"预期成交日期",@"产品销售金额（元）",@"预期金额（元）",@"备注",@"提醒",@"创建日期"]];
    arr_contents = [NSMutableArray arrayWithArray:@[_model.chanceName,_model.chanceClassify,self.kehuName,_model.contactsName,_model.interestproducts,_model.exdateofcompletion,_model.productsalesmoney,_model.expectmoney,_model.remark,_model.remindTime,_model.createTime]];
    arr_key =@[@"chanceName",@"chanceClassify",@"kehu",@"contactsName",@"interestproducts",@"exdateofcompletion",@"productsalesmoney",@"expectmoney",@"remark",@"remindTime",@"createTime"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];

}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    if (date_alert.two_btn.B_right.indexpath.row==9) {
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
        [self xiugaiWithtext:date_str indexPath:date_alert.two_btn.B_right.indexpath];
        
       
    }else
    {
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
       [self xiugaiWithtext:date_str indexPath:date_alert.two_btn.B_right.indexpath];
        
    }
   
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
    if(indexPath.row==2 || indexPath.row==10)
    {
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
    // @[@"机会名称",@"机会分类",@"客户",@"联系人",@"兴趣产品",@"预期成交日期",@"产品销售金额（元）",@"预期金额（元）",@"备注",@"提醒",@"创建日期"]];
    if (indexPath.row==0 || indexPath.row==6|| indexPath.row==7) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==1)
    {
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option=37;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }else if (indexPath.row==3)
    {
        GLLianXiRenViewController *Lvc =[[GLLianXiRenViewController alloc]init];
        Lvc.ischoose=1;
        Lvc.delegate =self;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==4 || indexPath.row==8)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
        
    }else if (indexPath.row==5)
    {
        //预期成交日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_str = [formatter stringFromDate:[NSDate date]];
        [date_alert setDate3:date_str];
        date_alert.picker.datePickerMode =UIDatePickerModeDate;
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }else if (indexPath.row==9)
    {
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *date_str = [formatter stringFromDate:[NSDate date]];
        [date_alert setDate:date_str];
        date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }else
    {
    }
}
#pragma  mark - 自定义的协议代理
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithtext:option indexPath:indexPath];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithtext:content indexPath:indexPath];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithtext:text indexPath:indexPath];
}

-(void)xiugaiWithtext:(NSString*)text indexPath:(NSIndexPath*)indexPath
{
    NSString *tstr = [NSString stringWithFormat:@"{'%@':'%@'}",arr_key[indexPath.row],text];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest  crmModule_Update_saleschanceWithowner:user.Guid saleschanceid:self.model.ID data:tstr And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
             hud.label.text =@"修改成功";
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
             hud.label.text =@"您没有此权限修改";
        }
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}
-(void)lianxiModel:(GLLianXiModel*)model
{
    //contactsName contactsPhone contacts
    NSString *tstr =[NSString stringWithFormat:@"{'contactsName':'%@','contactsPhone':'%@','contacts':'%@'}",model.name,model.cellphone,model.ID];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest crmModule_Update_saleschanceWithowner:user.Guid saleschanceid:self.model.ID data:tstr And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:3 withObject:model.name];
            [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}

@end
