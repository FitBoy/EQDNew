//
//  MXiaoLaBaAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "MXiaoLaBaAddViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "FBTextVViewController.h"
#import "DatePicer_AlertView.h"
#import "NSString+FBString.h"
@interface MXiaoLaBaAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate>
{
    UITableView  *tableV;
    
    NSMutableArray  *arr_contents;
    NSArray *arr_names;
    NSMutableArray *arr_height;
    DatePicer_AlertView  *date_alert;
    UserModel *user;
}

@end

@implementation MXiaoLaBaAddViewController
#pragma  mark - 小喇叭内容
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.section withObject:text];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"发布小喇叭";
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    arr_names = @[@"小喇叭内容：",@"广播时限：",@"定时发布："];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"不限",@"立即发布"]];
    arr_height = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60"]];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)quedingClick{
    NSInteger temp =0;
    if ([arr_contents[0] isEqualToString:@"请输入"]) {
        temp=1;
    }
    
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发布";
        NSString *tstr = arr_contents[2];
        if ([arr_contents[2] isEqualToString:@"立即发布"]) {
            NSDateFormatter  *formater = [[NSDateFormatter alloc]init];
            [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
            tstr = [formater stringFromDate:[NSDate date]];
        }
        [WebRequest trumpet_Push_trumpetWithuserGuid:user.Guid comid:user.companyId content:arr_contents[0] pushTime:tstr lengthOfTime:[NSString numberWithStr:arr_contents[1]] And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
         
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                });
            
        }];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.section] floatValue];
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
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];

    [date_alert removeFromSuperview];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_names.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:arr_names[indexPath.section] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:arr_contents[indexPath.section] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    content.yy_alignment = NSTextAlignmentRight;
    [name appendAttributedString:content];
    name.yy_lineSpacing = 7;
    cell.YL_label.attributedText = name;
    CGSize  size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [arr_height replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%.2f",size.height+30]];
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.height.mas_equalTo(size.height+30);
    }];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
         FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
         TVvc.delegate =self;
         TVvc.contentTitle =@"发布小喇叭";
         TVvc.content=arr_contents[0];
         TVvc.S_maxnum =@"100";
         [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.section==1)
    {
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"1小时",@"2小时",@"4小时",@"8小时",@"12小时",@"24小时",@"48小时",@"不限"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:1 withObject:tarr[i]];
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }]];
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }else if (indexPath.section==2)
    {
        [self.view addSubview:date_alert];
    }else
    {
        
    }
}




@end
