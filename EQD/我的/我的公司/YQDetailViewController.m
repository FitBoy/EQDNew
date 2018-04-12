//
//  YQDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "YQDetailViewController.h"
#import "BeforeYaoQingViewController.h"
@interface YQDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_big;
    NSArray *arr_title;
}

@end

@implementation YQDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"入职邀请";
    arr_big = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr_one = [NSMutableArray arrayWithArray:@[@[@"邀约公司",self.model.company],@[@"邀约人",self.model.Inviter],@[@"邀约人职务",self.model.admin],@[@"邀约人的电话",self.model.phone]]];
    NSMutableArray *arr_two = [NSMutableArray arrayWithArray:@[@[@"入职部门",self.model.udepartment],@[@"入职岗位",self.model.upost]]];
    NSString *tstr = [_model.status integerValue]==0?@"接受":@"已拒绝";
    NSMutableArray *arr_three = [NSMutableArray arrayWithArray:@[tstr]];
    [arr_big addObject:arr_one];
    [arr_big addObject:arr_two];
    [arr_big addObject:arr_three];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_title = @[@"接受邀请",@"等待管理员审核",@"管理员已同意",@"管理员拒绝",@"离职"];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = arr_big[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if(indexPath.section==arr_big.count-1)
    {
        UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 50)];
        tlabel.numberOfLines =0;
        NSMutableString *tstr =[NSMutableString stringWithString:arr_title[[_model.status integerValue]]];
        if ([_model.status integerValue]==3) {
            for (int i=0; i<_model.RecordList.count; i++) {
                RecordListModel  *model2 =_model.RecordList[i];
                [tstr appendFormat:@"\n%@",model2.Message];
            }
        }

        tlabel.text = tstr;
        if([_model.status integerValue]==0)
        {
        tlabel.textColor = [UIColor whiteColor];
         cell.backgroundColor = EQDCOLOR;
        }else
        {
            tlabel.textColor = [UIColor grayColor];
            cell.backgroundColor = [UIColor whiteColor];
        }
        tlabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:tlabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
    NSArray *arr = arr_big[indexPath.section];
    NSArray *small_arr = arr[indexPath.row];
    cell.textLabel.text = small_arr[0];
    cell.detailTextLabel.text = small_arr[1];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==arr_big.count-1 && [_model.status integerValue]==0) {
        //接受邀请
        BeforeYaoQingViewController *Bvc =[[BeforeYaoQingViewController alloc]init];
        Bvc.model =self.model;
        [self.navigationController pushViewController:Bvc animated:NO];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请耐心等待";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //拒绝邀请
        if([_model.status integerValue]==0){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在拒绝";
        [WebRequest User_Delete_ApplyForEntryWithentryId:self.model.ID status:self.model.status And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"非法操作";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"拒绝";
}



@end
