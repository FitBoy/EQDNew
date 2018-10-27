//
//  KeHuChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/14.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "KeHuChooseViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "FB_OnlyForLiuYanViewController.h"
@interface KeHuChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSString *page;
    NSMutableArray *arr_model;
    UserModel *user;
    UIView *V_head;
}

@end

@implementation KeHuChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest crmModule_Owner_getcuslistWithowner:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page =dic[@"nextpage"];
            [arr_model removeAllObjects];
            for ( int i=0; i<tarr.count; i++) {
                KeHu_ListModel  *model = [KeHu_ListModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadOtherData
{
      [WebRequest crmModule_Owner_getcuslistWithowner:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"nextpage"];
            for ( int i=0; i<tarr.count; i++) {
                KeHu_ListModel  *model = [KeHu_ListModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(30, 200, DEVICE_WIDTH-60, DEVICE_HEIGHT-400) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];

    V_head = [[UIView alloc]init];
    V_head.userInteractionEnabled = YES;
    YYLabel *tlabel = [[YYLabel alloc]init];
    tlabel.numberOfLines =0;
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:@"请选择想要把联系人添加到的客户" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
//    contents.yy_alignment = NSTextAlignmentCenter;
    CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [V_head addSubview:tlabel];
    tlabel.attributedText = contents;
    V_head.frame = CGRectMake(0, 0, DEVICE_WIDTH, size.height+20);
    tlabel.frame = CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+10);
    tableV.tableHeaderView = V_head;
    

    
}
#pragma  mark - 表的数据源
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
    KeHu_ListModel *model = arr_model[indexPath.row];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.cusName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.salesTerritory] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:contents];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-90, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height =size.height+20;
    cell.YL_label.attributedText =name;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+15);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KeHu_ListModel  *model = arr_model[indexPath.row];
    return model.cell_height;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KeHu_ListModel  *model = arr_model[indexPath.row];
    if ([self.delegate_kehu respondsToSelector:@selector(getKeHuModel:)]) {
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.delegate_kehu getKeHuModel:model];
    }
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}



@end
