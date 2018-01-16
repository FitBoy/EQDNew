//
//  PX_PlanDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_PlanDetailViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "PlanListModel.h"

#import <Masonry.h>
@interface PX_PlanDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    PlanListModel  *model_detail;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_height;
}

@end

@implementation PX_PlanDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Training_Get_trainingPlanDetailWithuserGuid:user.Guid comid:user.companyId planId:self.planId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [PlanListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_contents = [NSMutableArray arrayWithArray:@[model_detail.theTheme,model_detail.theCategory,model_detail.trainees,model_detail.budgetedExpense,model_detail.personNumber,model_detail.perCapitaCost,model_detail.teacherName,model_detail.learningModality,model_detail.theTrainTime]];
            [tableV reloadData];
        }
    }];
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"培训计划详情";
    arr_names = @[@"培训主题",@"培训类别",@"受训对象",@"费用预算",@"受训人数",@"人均费用/元",@"培训老师",@"学习形式",@"培训时间"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    arr_height = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_names.count; i++) {
        [arr_height addObject:@"60"];
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.row] integerValue];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:",arr_names[indexPath.row]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:arr_contents[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [name appendAttributedString:content];
    cell.YL_label.attributedText = name;
    /// 适配
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    if (size.height>50) {
        [arr_height replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size.height+10]];
    }
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
