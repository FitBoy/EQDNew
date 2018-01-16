//
//  PXChooseListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXChooseListViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
@interface PXChooseListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation PXChooseListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Training_Get_trainingApply_byHRWithuserGuid:user.Guid comid:user.companyId type:@"1" page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    [WebRequest Training_Get_trainingApply_byHRWithuserGuid:user.Guid comid:user.companyId type:@"1" page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page =dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"培训选择";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FB_PeiXun_ListModel  *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    FB_PeiXun_ListModel *model = arr_model[indexPath.row];
    NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:@"培训主题:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    content.yy_color = [UIColor grayColor];
    NSMutableAttributedString *zhuti =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.theTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [content appendAttributedString:zhuti];
    NSMutableAttributedString  *leibie = [[NSMutableAttributedString alloc]initWithString:@"类别:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    leibie.yy_color  = [UIColor grayColor];
    [content appendAttributedString:leibie];
    
    NSMutableAttributedString  *leibie2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.theCategory] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [content appendAttributedString:leibie2];
    NSMutableAttributedString  *duiXiang = [[NSMutableAttributedString alloc]initWithString:@"对象:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    duiXiang.yy_color = [UIColor grayColor];
    [content appendAttributedString:duiXiang];
    NSMutableAttributedString   *duixiang2 =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.trainees] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [content appendAttributedString:duixiang2];
    
    NSMutableAttributedString  *time = [[NSMutableAttributedString alloc]initWithString:@"时间段:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    time.yy_color = [UIColor grayColor];
    [content appendAttributedString:time];
    NSMutableAttributedString  *time2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ~ %@",model.thedateStart,model.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [content appendAttributedString:time2];
    
    cell.YL_label.attributedText = content;
    CGSize  size = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cellHeight =size.height+15;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FB_PeiXun_ListModel  *model =arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getPeiXunlistModel:)]) {
        [self.delegate getPeiXunlistModel:model];
    }
    [self.navigationController popViewControllerAnimated:NO];
}

@end
