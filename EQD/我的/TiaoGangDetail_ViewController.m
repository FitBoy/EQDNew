//
//  TiaoGangDetail_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "TiaoGangDetail_ViewController.h"
#import "TiaoGangListModel.h"
#import "ShenPiListModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "FBTwoButtonView.h"
#import "FB_OnlyForLiuYanViewController.h"
@interface TiaoGangDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_name;
    NSMutableArray *arr_contents;
    TiaoGangListModel  *model_detail;
    
    NSMutableArray *arr_model;
}

@end

@implementation TiaoGangDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    arr_name = @[@"申请人",@"要调的职位",@"薪资",@"调岗生效日期",@"调岗原因",@"申请时间",@"提交申请人"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    [WebRequest ChangePostsAdd_Get_ChangePost_ByIdWithchangePostId:self.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [TiaoGangListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_contents = [NSMutableArray arrayWithArray:@[model_detail.changerStaffName,model_detail.changePost,model_detail.salary,model_detail.implementTime,model_detail.reason,model_detail.createTime,model_detail.createrStaffName]];
            [tableV reloadData];
        }
    }];
    
    [WebRequest ChangePostsAdd_Get_ChangePost_CheckWithchangePostId:self.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model = [ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    
}
#pragma  mark - 表的数据源
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
    }else
    {
        FBTwoButtonView  *T_btn = [[FBTwoButtonView alloc]init];
        [T_btn setleftname:@"拒绝" rightname:@"同意"];
        [T_btn.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [T_btn.B_right addTarget:self action:@selector(tongyiCLick) forControlEvents:UIControlEventTouchUpInside];
        
        return T_btn;
    }
}

-(void)getPresnetText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在拒绝";
    [WebRequest ChangePostsAdd_Set_ChangePostWithchangePostId:self.Id userGuid:user.Guid message:text type:@"2" And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
}
-(void)jujueClick
{
    FB_OnlyForLiuYanViewController *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.btnName = @"拒绝";
    LYvc.placeHolder =@"请输入原因";
    LYvc.delegate =self;
    [self presentViewController:LYvc animated:NO completion:nil];
    
}
-(void)tongyiCLick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    [WebRequest ChangePostsAdd_Set_ChangePostWithchangePostId:self.Id userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 60;
    }else
    {
        ShenPiListModel *model = arr_model[indexPath.row];
        return model.cellHeight;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section ==0)
    {
    return arr_contents.count;
    }else
    {
        return arr_model.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
    static NSString *cellId=@"cellID0";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
        cell.textLabel.text = arr_name[indexPath.row];
        cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
       EQDR_labelTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        ShenPiListModel *model =arr_model[indexPath.row];
        NSString *Tstr = [model.status integerValue] >0? @"已同意":@"已拒绝";
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@在%@ %@ \n意见:%@",model.staffName,model.createTime,Tstr,model.message] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        name.yy_lineSpacing =6;
        
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight = size.height+20;
        cell.YL_label.attributedText =name;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        }];
        return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
