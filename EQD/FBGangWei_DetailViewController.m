//
//  FBGangWei_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBGangWei_DetailViewController.h"
#import "FBButton.h"
#import "FBGangWei_AddViewController.h"
#import "GangWeiDetail.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "LeiBie_GangWeiViewController.h"
#import "FBOptionViewController.h"
@interface FBGangWei_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,LeiBie_GangWeiViewControllerDelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    FBButton *B_title;
    GangWeiDetail  *model_detail;
    NSArray *arr_titles;
    NSArray *arr_one;
    NSMutableArray *arr_content_One;
    NSArray *arr_two;
    NSMutableArray *arr_content_two;
    UserModel *user;
}

@end

@implementation FBGangWei_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Adminget_postdetailinfoWithpostid:self.model.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==202) {
            [tableV removeFromSuperview];
            [self.view addSubview:B_title];
        }else if ([dic[Y_STATUS] integerValue]==200)
        {
            model_detail = [GangWeiDetail mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_content_One = [NSMutableArray arrayWithArray:@[model_detail.postName,model_detail.depName,model_detail.jobNature,model_detail.salaryRange,model_detail.workdesc,model_detail.BZrenshu]];
            arr_content_two = [NSMutableArray arrayWithArray:@[model_detail.educationcla,model_detail.workexpecla,model_detail.agecla,model_detail.sexcla,model_detail.pfskills,model_detail.postgenre]];
            [self.view addSubview:tableV];
            [B_title removeFromSuperview];
            [tableV reloadData];
        }else
        {
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"岗位描述";
    user =[WebRequest GetUserInfo];
    B_title = [FBButton buttonWithType:UIButtonTypeSystem];
    [B_title setTitle:@"暂无描述，点我添加" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:[UIFont systemFontOfSize:24]];
    B_title.frame =CGRectMake(5, DEVICE_TABBAR_Height+5, DEVICE_WIDTH-10, 40);
    B_title.layer.shadowOffset =CGSizeMake(5, 5);
    B_title.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    [B_title addTarget:self action:@selector(addDetailClick) forControlEvents:UIControlEventTouchUpInside];
    arr_one = @[@"岗位名称",@"所属部门",@"工作性质",@"薪资范围",@"工作描述",@"编制人数"];
    arr_two = @[@"学历",@"工作经验",@"年龄",@"性别",@"专业技能",@"岗位类别"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    arr_titles = @[@"岗位信息",@"岗位要求"];
}
-(void)addDetailClick
{
    FBGangWei_AddViewController  *Avc = [[FBGangWei_AddViewController alloc]init];
    Avc.model =self.model;
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_content_One.count:arr_content_two.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_titles[section];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
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
    [self xiugaiWithcontent:option indexPath:indexPath];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithcontent:text indexPath:indexPath];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithcontent:content indexPath:indexPath];
}
-(void)leibieModel:(NSArray *)tarr indexPath:(NSIndexPath *)indexPath
{
    NSMutableString  *tstr = [NSMutableString string];
    for (int i=0; i<tarr.count; i++) {
        OptionModel *model =tarr[i];
        [tstr appendFormat:@"%@ ",model.name];
    }
    [self xiugaiWithcontent:tstr indexPath:indexPath];
    
}
-(void)xiugaiWithcontent:(NSString*)content  indexPath:(NSIndexPath*)indexPath
{
    
    NSArray  *tarr = nil;
    
    if (indexPath.section==0) {
        tarr=@[@"postName",@"depName",@"jobNature",@"salaryRange",@"workdesc",@"BZrenshu"];
    }else
    {
        tarr = @[@"educationcla",@"workexpecla",@"agecla",@"sexcla",@"pfskills",@"postgenre"];
    }
    NSString *data =[NSString stringWithFormat:@"{'%@':'%@'}",tarr[indexPath.row],content];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    
    [WebRequest Com_Update_postdetailinfoWithuserGuid:user.Guid recordid:model_detail.ID data:data And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                if (indexPath.section==0) {
                    [arr_content_One replaceObjectAtIndex:indexPath.row withObject:content];
                }else
                {
                    [arr_content_two replaceObjectAtIndex:indexPath.row withObject:content];
                }
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        });
    }];
}


@end
