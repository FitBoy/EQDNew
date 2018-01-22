//
//  PX_Plan_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/10.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_Plan_AddViewController.h"
#import "PXChooseListViewController.h"
#import "FBTextFieldViewController.h"
#import "FB_TimeSectionViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
@interface PX_Plan_AddViewController ()<UITableViewDataSource,UITableViewDelegate,PXChooseListViewControllerdelegate,FBTextFieldViewControllerDelegate,FB_TimeSectionViewControllerdelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    FB_PeiXun_ListModel *model_peixun;
    NSArray *arr_CthreeSectionModel;
    float height_cell8;
}

@end

@implementation PX_Plan_AddViewController
#pragma  mark - 自定义的协议代理
-(void)getThreeSectionModel:(NSArray<ThreeSectionModel *> *)arr_threeSectionModel
{
    arr_CthreeSectionModel = arr_threeSectionModel;
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:8 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getPeiXunlistModel:(FB_PeiXun_ListModel *)model
{
    model_peixun = model;
    [arr_contents replaceObjectAtIndex:0 withObject:model_peixun.theTheme];
    [arr_contents replaceObjectAtIndex:1 withObject:model_peixun.theCategory];
    [arr_contents replaceObjectAtIndex:2 withObject:model_peixun.trainees];
    [arr_contents replaceObjectAtIndex:3 withObject:model.budgetedExpense];
    [tableV reloadData];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==4)
    {
        if (model_peixun) {
            float  avality = [arr_contents[3] floatValue]/[content integerValue];
            [arr_contents replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%.2f",avality]];
            [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"添加培训计划";
    arr_names = @[@"培训主题",@"培训类别",@"受训对象",@"费用预算",@"受训人数",@"人均费用/元",@"培训老师",@"学习形式",@"培训时间"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"根据主题生成",@"根绝主题生成",@"根据主题生成",@"请输入",@"自动生成",@"请输入",@"请选择",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick
{
    NSInteger temp = 0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    NSMutableString  *Tstr = [NSMutableString string];
    for (int i=0; i<arr_CthreeSectionModel.count; i++) {
        ThreeSectionModel  *model = arr_CthreeSectionModel[i];
        if (i==arr_CthreeSectionModel.count-1) {
            [Tstr appendString:[NSString stringWithFormat:@"%@ %@~%@",model.date,model.time1,model.time2]];
        }else
        {
              [Tstr appendString:[NSString stringWithFormat:@"%@ %@~%@,",model.date,model.time1,model.time2]];
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
    [WebRequest Training_Add_trainingPlanWithuserGuid:user.Guid comid:user.companyId theCategory:model_peixun.theCategory theTheme:model_peixun.theTheme trainees:model_peixun.trainees personNumber:arr_contents[4] teacherGuid:@" " teacherName:arr_contents[6] budgetedExpense:model_peixun.budgetedExpense theTrainTime:Tstr learningModality:arr_contents[7] receTrainDepId:model_peixun.depid receTrainDepName:model_peixun.depName applyId:model_peixun.ID betrainedPostId:model_peixun.betrainedPostId And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
        
    }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"填写信息不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==8) {
       
        return height_cell8<60?60:height_cell8;
    }else
    {
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==8 && arr_CthreeSectionModel.count >0 ) {
        EQDR_labelTableViewCell *cell1 = [[EQDR_labelTableViewCell alloc]init];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:@"培训时间" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            for (int i=0; i<arr_CthreeSectionModel.count; i++) {
                ThreeSectionModel *model = arr_CthreeSectionModel[i];
                NSMutableAttributedString *content =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@   %@~%@",model.date,model.time1,model.time2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
                [name appendAttributedString:content];
                content.yy_lineSpacing = 6;
                
            }
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [cell1.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.centerY.mas_equalTo(cell1.mas_centerY);
            make.left.mas_equalTo(cell1.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell1.mas_right).mas_offset(-15);
        }];
        
        height_cell8 = size.height+10;
        cell1.YL_label.attributedText =name;
        return cell1;
    }else
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font =Y_TextFont;
        cell.detailTextLabel.font = Y_TextFontSmall;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///@[@"培训主题",@"培训类别",@"受训对象",@"费用预算",@"受训人数",@"人均费用",@"培训老师",@"学习形式",@"培训时间"];
    if (indexPath.row==0) {
        //培训主题
        PXChooseListViewController  *Cvc =[[PXChooseListViewController alloc]init];
        Cvc.delegate =self;
        [self.navigationController pushViewController:Cvc animated:NO];
    }else if (indexPath.row==4)
    {
      //受训人数
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==6)
    {
        //培训老师
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==7)
    {
        //学习形式
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"线下面授",@"线下集体网络",@"网络自学"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            
        }
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }else if (indexPath.row==8)
    {
        //培训时间
        FB_TimeSectionViewController  *Svc =[[FB_TimeSectionViewController alloc]init];
        Svc.delegate =self;
        Svc.arr_IthreeSectionModel = arr_CthreeSectionModel;
        [self.navigationController pushViewController:Svc animated:NO];
    }else
    {
        
    }
}




@end
