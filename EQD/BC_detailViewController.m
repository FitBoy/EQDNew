//
//  BC_detailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BC_detailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "DatePicer_AlertView.h"
@interface BC_detailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView *datePicker;
    UserModel *user ;
    
}

@end

@implementation BC_detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =self.model.shiftName;
    arr_names =@[@"上班时间",@"下班时间"];
    arr_contents =[NSMutableArray arrayWithArray:@[@[self.model.startTime1,_model.endTime1]]];
    if (![_model.startTime2 isEqualToString:_model.endTime2]) {
        [arr_contents addObject:@[_model.startTime2,_model.endTime2]];
        if (![_model.startTime3 isEqualToString:_model.endTime3]) {
            [arr_contents addObject:@[_model.startTime3,_model.endTime3]];
            if (![_model.startTime4 isEqualToString:_model.endTime4]) {
                [arr_contents addObject:@[_model.startTime4,_model.endTime4]];
            }
        }
    }
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    datePicker =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    [datePicker.two_btn.B_left addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [datePicker.two_btn.B_right addTarget:self action:@selector(quedingClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)quxiaoClick
{
    [datePicker removeFromSuperview];
}
-(void)quedingClick:(FBButton*)tbtn
{
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *str =[formatter stringFromDate:datePicker.picker.date];
    switch (tbtn.indexpath.section) {
        case 0:
        {
            if (tbtn.indexpath.row==0) {
                self.model.startTime1 =str;
            }
            else
            {
                self.model.endTime1=str;
            }
        }
            break;
        case 1:
        {
            if (tbtn.indexpath.row==0) {
                self.model.startTime2 =str;
            }
            else
            {
                self.model.endTime2=str;
            }
        }
            break;
        case 2:
        {
            if (tbtn.indexpath.row==0) {
                self.model.startTime3 =str;
            }
            else
            {
                self.model.endTime3=str;
            }
        }
            break;
        case 3:
        {
            if (tbtn.indexpath.row==0) {
                self.model.startTime4 =str;
            }
            else
            {
                self.model.endTime4=str;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    
    
   [WebRequest Update_ShiftWithuserGuid:user.Guid companyId:user.companyId shiftId:self.model.Id shiftName:self.model.shiftName startTime1:self.model.startTime1 endTime1:self.model.endTime1 startTime2:self.model.startTime2 endTime2:self.model.endTime2 startTime3:self.model.startTime3 endTime3:_model.endTime3 startTime4:_model.startTime4 endTime4:_model.endTime4 And:^(NSDictionary *dic) {
        [datePicker removeFromSuperview];
       hud.label.text =dic[Y_MSG];
       if ([dic[Y_STATUS] integerValue]==200) {
           NSMutableArray *tarr =[NSMutableArray arrayWithArray:arr_contents[tbtn.indexpath.section]];
           [tarr replaceObjectAtIndex:tbtn.indexpath.row withObject:str];
           [arr_contents replaceObjectAtIndex:tbtn.indexpath.section withObject:tarr];
          
       }
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [hud hideAnimated:NO];
            [tableV reloadRowsAtIndexPaths:@[tbtn.indexpath] withRowAnimation:UITableViewRowAnimationNone];
       });
       
   }];
    
    
    
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_contents.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *tarr =arr_contents[indexPath.section];
    cell.L_left0.text =arr_names[indexPath.row];
    cell.L_right0.text =tarr[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr =arr_contents[indexPath.section];
    [datePicker setDate2:tarr[indexPath.row]];
    datePicker.two_btn.B_right.indexpath =indexPath;
    [self.view addSubview:datePicker];
    
}



@end
