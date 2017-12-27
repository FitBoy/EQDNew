//
//  FBGangWei_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBGangWei_AddViewController.h"
#import "FBOptionViewController.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "LeiBie_GangWeiViewController.h"
@interface FBGangWei_AddViewController ()<UITableViewDataSource,UITableViewDelegate,FBOptionViewControllerDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,LeiBie_GangWeiViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_titles;
    NSArray *arr_one;
    NSMutableArray *arr_content_One;
    NSArray *arr_two;
    NSMutableArray *arr_content_two;
}

@end

@implementation FBGangWei_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"添加岗位描述";
    user = [WebRequest GetUserInfo];
    arr_titles = @[@"岗位信息",@"岗位要求"];
    arr_one = @[@"岗位名称",@"所属部门",@"工作性质",@"薪资范围",@"工作描述",@"编制人数"];
     arr_two = @[@"学历",@"工作经验",@"年龄",@"性别",@"专业技能",@"岗位类别"];
    arr_content_One = [NSMutableArray arrayWithArray:@[self.model.name,self.model.dename,@"请选择",@"请输入",@"请输入",@"请输入"]];
    arr_content_two =[NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请选择",@"请输入",@"请选择",]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addGangWeiClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)addGangWeiClick
{
    NSInteger temp=0;
    for (int i=0; i<arr_content_One.count; i++) {
        if ([arr_content_One[i] isEqualToString:@"请输入"]||[arr_content_One[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    if (temp==0) {
        for (int i=0; i<arr_content_two.count; i++) {
            if ([arr_content_two[i] isEqualToString:@"请输入"]||[arr_content_two[i] isEqualToString:@"请选择"]) {
                temp=1;
                break;
            }
        }
    }
    
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        [WebRequest Com_Create_postdetailinfoWithcompanyid:user.companyId postid:_model.ID postName:_model.name depName:_model.dename jobNature:arr_content_One[2] salaryRange:arr_content_One[3] workdesc:arr_content_One[4] educationcla:arr_content_two[0] workexpecla:arr_content_two[1] agecla:arr_content_two[2] sexcla:arr_content_two[3] pfskills:arr_content_two[4] postgenre:arr_content_two[5] creater:user.Guid numOfStaff:arr_content_One[5] And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
                
            });
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"填写不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
   
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_titles[section];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_content_One.count:arr_content_two.count;
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
    if (indexPath.section==0 &&(indexPath.row==0 || indexPath.row==1)) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =indexPath.section==0?arr_one[indexPath.row]:arr_two[indexPath.row];
    cell.detailTextLabel.text =indexPath.section==0?arr_content_One[indexPath.row]:arr_content_two[indexPath.row];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            //工作性质
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.indexPath =indexPath;
            Ovc.option=38;
            Ovc.delegate =self;
            Ovc.contentTitle =arr_one[indexPath.row];
            [self.navigationController pushViewController:Ovc animated:NO];
        }else if (indexPath.row==3)
        {
            //薪资范围
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_content_One[indexPath.row];
            TFvc.contentTitle =arr_one[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }else if (indexPath.row==4)
        {
            //工作描述
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle=arr_one[indexPath.row];
            TVvc.content =arr_content_One[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }else if (indexPath.row==5)
        {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_content_One[indexPath.row];
            TFvc.contentTitle =arr_one[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }
        else
        {
        }
    }else
    {
        if (indexPath.row==0) {
            //学历
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.indexPath =indexPath;
            Ovc.option=39;
            Ovc.delegate =self;
            Ovc.contentTitle =arr_two[indexPath.row];
            [self.navigationController pushViewController:Ovc animated:NO];
        }else if (indexPath.row==1)
        {
            //工作经验
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.indexPath =indexPath;
            Ovc.option=40;
            Ovc.delegate =self;
            Ovc.contentTitle =arr_two[indexPath.row];
            [self.navigationController pushViewController:Ovc animated:NO];
        }else if (indexPath.row==2)
        {
            //年龄
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_content_two[indexPath.row];
            TFvc.contentTitle =arr_two[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }else if (indexPath.row==3)
        {
            //性别
            NSArray *tarr = @[@"男",@"女",@"不限"];
            UIAlertController  *alert = [[UIAlertController alloc]init];
            for (int i=0; i<tarr.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_content_two replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                }]];
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:NO completion:nil];
        }else if (indexPath.row==4)
        {
            //专业技能
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle=arr_two[indexPath.row];
            TVvc.content =arr_content_two[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }else if (indexPath.row==5)
        {
            //岗位类别
            LeiBie_GangWeiViewController *Gvc =[[LeiBie_GangWeiViewController alloc]init];
            Gvc.delegate =self;
            Gvc.indexPath =indexPath;
            
            [self.navigationController pushViewController:Gvc animated:NO];
        }else
        {
        }
    }
        
}
#pragma  mark - 自定义的协议代理
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_content_One replaceObjectAtIndex:indexPath.row withObject:option];
        
    }else
    {
        [arr_content_two replaceObjectAtIndex:indexPath.row withObject:option];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_content_One replaceObjectAtIndex:indexPath.row withObject:content];
        
    }else
    {
        [arr_content_two replaceObjectAtIndex:indexPath.row withObject:content];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_content_One replaceObjectAtIndex:indexPath.row withObject:text];
        
    }else
    {
      [arr_content_two replaceObjectAtIndex:indexPath.row withObject:text];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)leibieModel:(NSArray *)tarr indexPath:(NSIndexPath *)indexPath
{
    NSMutableString  *tstr = [NSMutableString string];
    for (int i=0; i<tarr.count; i++) {
        OptionModel  *model =tarr[i];
        [tstr appendFormat:@"%@ ",model.name];
    }
    [arr_content_two replaceObjectAtIndex:indexPath.row withObject:tstr];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
