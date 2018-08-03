//
//  FX_riZhiSectionAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/16.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 时间
 内容
 标记 1 是一行文字 2 多行文字  3 时间选择
 */
#import "FX_riZhiSectionAddViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "DatePicer_AlertView.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
@interface FX_riZhiSectionAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    DatePicer_AlertView  * date_alert;
    NSIndexPath *indexPath_selected;
}

@end

@implementation FX_riZhiSectionAddViewController
#pragma  mark - 一行文字
-(void)content:(NSString*)content WithindexPath:(NSIndexPath*)indexPath
{
    GNmodel  *model = _arr_json [indexPath.row];
    model.content = content;
//    [_arr_json replaceObjectAtIndex:indexPath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 多行文字
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    GNmodel  *model = _arr_json[indexPath.row];
    model.content = text;
    [_arr_json replaceObjectAtIndex:indexPath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate2:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)tianjiaCLick{
    
    NSInteger temp =0;
    for(int i=0;i<self.arr_json.count;i++)
    {
        GNmodel *model =self.arr_json[i];
        if ([model.content isEqualToString:@"请输入"] ||[model.content isEqualToString:@"请选择"]  ) {
            temp=1;
            break;
        }
    }
    
    if (temp ==1) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    if([self.delegate_riZhi respondsToSelector:@selector(getarr_json:)])
    {
        [self.delegate_riZhi getarr_json:self.arr_json];
        [self.navigationController popViewControllerAnimated:NO];
    }
    }
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick{
    
    GNmodel  *model = _arr_json[indexPath_selected.row];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    model.content = date_str;
    [_arr_json replaceObjectAtIndex:indexPath_selected.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
     [date_alert removeFromSuperview];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GNmodel *model =_arr_json[indexPath.row];
    return model.cellHeight==0?60:model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_json.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    GNmodel *model = _arr_json[indexPath.row];
    [cell setModel_GN:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GNmodel *model =_arr_json[indexPath.row];
    if (model.biaoji ==3 ) {
        indexPath_selected = indexPath;
        [self.view addSubview:date_alert];
    }else if(model.biaoji ==2)
    {
        [date_alert removeFromSuperview];
        //多行文字
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=model.name;
        TVvc.content =model.content;
        [self.navigationController pushViewController:TVvc animated:NO];
        
        
    }else if (model.biaoji ==1)
    {
        //一行文字
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =model.content;
        TFvc.contentTitle =model.name;
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (model.biaoji ==4)
    {
        //选择
        UIAlertController *alert = [[UIAlertController alloc]init];
        NSArray  *tarr = @[@"已完成",@"未完成",@"取消"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                GNmodel *model =_arr_json[indexPath.row];
                model.content = tarr[i];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }
    else
    {
        
    }
}




@end
