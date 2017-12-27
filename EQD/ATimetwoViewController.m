//
//  ATimetwoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ATimetwoViewController.h"
#import "FBTimeView.h"
#import "NSString+FBString.h"
@interface ATimetwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    BOOL  shangban;
}
@property (nonatomic,strong) FBTimeView *TV_time;
@end

@implementation ATimetwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请选择",@"请选择"]];
    arr_names =[NSMutableArray arrayWithArray:@[@"上班时间",@"上班打卡设置",@"下班时间",@"下班打卡设置"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(shezhiClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)shezhiClick
{
    //右上角设置好的
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}
-(FBTimeView*)TV_time
{
    if (!_TV_time) {
        _TV_time = [[FBTimeView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-250, DEVICE_WIDTH, 250)];
        [_TV_time setime:@[@"9",@"00"]];
        [_TV_time.B_quxiao addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
        [_TV_time.B_queding addTarget:self action:@selector(quedingClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return  _TV_time;
}
-(void)quxiaoClick
{
    //取消
    [_TV_time removeFromSuperview];
    
}
-(void)quedingClick
{
    //确定
    [_TV_time removeFromSuperview];
    NSString *str= [NSString stringWithFormat:@"%@:%@",_TV_time.arr_time[0],_TV_time.arr_time[1]];
    
    [arr_contents replaceObjectAtIndex:shangban==NO?2:0 withObject:str];
    [tableV reloadData];
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            shangban =YES;
            [self.view addSubview:self.TV_time];
            
        }
            break;
            case 1:
        {
            [self.TV_time removeFromSuperview];
            UIAlertController *alert =[[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"不限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"提前30分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"提前1小时" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"提前2小时" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"自定义时间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:NO completion:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:nil message:@"提前时间(分钟)" preferredStyle:UIAlertControllerStyleAlert];
                    [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        textField.placeholder = @"请输入提前时间(分钟)";
                    }];
                    [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if ([NSString deptNumInputShouldNumber:alert2.textFields[0].text]) {
                            [arr_contents replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"下班后%@分钟内",alert2.textFields[0].text]];
                            [tableV reloadData];
                        }
                        else
                        {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text =@"必须是纯数字";
                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                [MBProgressHUD hideHUDForView:self.view  animated:YES];
                            });
                        }
                    }]];
                    [self presentViewController:alert2 animated:NO completion:nil];
                });
                
                
            }]];
            [self presentViewController:alert animated:NO completion:nil];
            
            
        }
            break;
            case 2:
        {
            shangban =NO;
            [self.view addSubview:self.TV_time];
            [_TV_time setime:@[@"18",@"00"]];
        }
            break;
            case 3:
        {
            [self.TV_time removeFromSuperview];
            UIAlertController *alert =[[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"不限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"下班后15分钟内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"下班后30分钟内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"下班后1小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"下班后2小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
                [tableV reloadData];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"自定义时间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:NO completion:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:nil message:@"下班后打卡时间(分钟)" preferredStyle:UIAlertControllerStyleAlert];
                    [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        textField.placeholder = @"请输入下班后打卡时间(分钟)";
                    }];
                    [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if ([NSString deptNumInputShouldNumber:alert2.textFields[0].text]) {
                            [arr_contents replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"下班后%@分钟内",alert2.textFields[0].text]];
                            [tableV reloadData];
                        }
                        else
                        {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text =@"必须是纯数字";
                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                [MBProgressHUD hideHUDForView:self.view  animated:YES];
                            });
                        }
                        
                        
                    }]];
                    [self presentViewController:alert2 animated:NO completion:nil];
                });
                
                
            }]];

            
            [self presentViewController:alert animated:NO completion:nil];
        }
            break;
        default:
            break;
    }
}




@end
