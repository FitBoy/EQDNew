//
//  SQTiaoGangViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SQTiaoGangViewController.h"
#import "SQTiaoGang_addViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "TiaoGangListModel.h"
#import "TiaoGangDetail_ViewController.h"
#import <Masonry.h>
@interface SQTiaoGangViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView  *tableV;
    NSMutableArray  *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation SQTiaoGangViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if(self.temp ==1)
    {
        [WebRequest ChangePostsAdd_Get_ChangePost_ByCheckerWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex]  And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                page = tdic[@"page"];
                NSArray *tarr = tdic[@"rows"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    TiaoGangListModel  *model = [TiaoGangListModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height = 60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
    [WebRequest ChangePostsAdd_Get_ChangePost_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            page = tdic[@"page"];
            NSArray *tarr = tdic[@"rows"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                TiaoGangListModel  *model = [TiaoGangListModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }
}
-(void)loadOtherData{
    if (self.temp ==1) {
        [WebRequest ChangePostsAdd_Get_ChangePost_ByCheckerWithcompanyId:user.companyId userGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                page = tdic[@"page"];
                NSArray *tarr = tdic[@"rows"];
                if(tarr.count ==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        TiaoGangListModel  *model = [TiaoGangListModel mj_objectWithKeyValues:tarr[i]];
                        model.cell_height = 60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else
    {
    [WebRequest ChangePostsAdd_Get_ChangePost_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            page = tdic[@"page"];
            NSArray *tarr = tdic[@"rows"];
            if(tarr.count ==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                TiaoGangListModel  *model = [TiaoGangListModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page =@"0";
    self.navigationItem.title = @"调岗申请列表";
    user = [WebRequest GetUserInfo];
    arr_model  =[NSMutableArray arrayWithCapacity:0];
    if (self.temp == 1) {
        
    }else
    {
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    }
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审核",@"已审核"]];
    segmentC.frame =CGRectMake(0, DEVICE_HEIGHT-40-kBottomSafeHeight, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
-(void)rightCLick
{
    //添加调岗申请
    SQTiaoGang_addViewController  *Avc =[[SQTiaoGang_addViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoGangListModel *model =arr_model[indexPath.row];
    return model.cell_height;
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
    TiaoGangListModel *model =arr_model[indexPath.row];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@申请调到%@-%@",model.changerName,model.changeDepartment,model.changePost] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    time.yy_alignment = NSTextAlignmentRight;
    [name appendAttributedString:time];
    name.yy_lineSpacing =6;
    
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height = size.height +20;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    cell.YL_label.attributedText = name;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoGangListModel *model = arr_model[indexPath.row];
    TiaoGangDetail_ViewController *Dvc = [[TiaoGangDetail_ViewController alloc]init];
    if (self.temp == 1 && segmentC.selectedSegmentIndex ==0) {
        Dvc.temp =1;
    }else
    {
        Dvc.temp =0;
    }
    Dvc.Id = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
