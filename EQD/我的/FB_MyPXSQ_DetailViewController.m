//
//  FB_MyPXSQ_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_MyPXSQ_DetailViewController.h"
#import "FB_PeiXun_ListModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
@interface FB_MyPXSQ_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_names;
    NSArray *arr_contents;
    NSArray *arr_model;
    NSMutableArray *arr_height;
}

@end

@implementation FB_MyPXSQ_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_height = [NSMutableArray arrayWithCapacity:0];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    [WebRequest Training_Get_trainingApplyDetailWithuserGuid:user.Guid applicationId:self.ID And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            FB_PeiXun_ListModel *model = [FB_PeiXun_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_model = model.checkList;
            arr_contents = @[model.theTheme,model.theCategory,model.trainees,[NSString stringWithFormat:@"%@ ~ %@",model.thedateStart,model.thedateEnd],model.theDemand,model.applyReason,model.budgetedExpense,model.recoDocentName,model.applicantName,model.createTime];
            [arr_height removeAllObjects];
            for (int i=0; i<10; i++) {
                [arr_height addObject:@"60"];
            }
            [tableV reloadData];
        }
    }];
    
     arr_names = @[@"培训主题",@"培训类别",@"培训对象",@"申请培训时间段",@"培训要求",@"申请理由",@"预算费用/元",@"推荐讲师",@"申请人",@"申请时间"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [arr_height[indexPath.row] integerValue];
    }else
    {
        return 60;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_model.count==0?1:2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_contents.count;
    }else
    {
        return arr_model.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.YL_label.numberOfLines=0;
        NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:\n",arr_names[indexPath.row]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        title.yy_lineSpacing =6;
        
        NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:arr_contents[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        content.yy_lineSpacing =6;
        [title appendAttributedString:content];
        CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [arr_height replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%f",size.height+20]];
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        }];
        
        cell.YL_label.attributedText = title;
      
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
        
        return cell;
    }
  
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
