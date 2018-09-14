//
//  FB_pipeiNeedViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_pipeiNeedViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "PXNeedModel.h"
#import <Masonry.h>
#import "PXNeedDetailViewController.h"
@interface FB_pipeiNeedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation FB_pipeiNeedViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Training_TrainingMatch_Get_CourseTrainMatchWithcourseId:self.courseId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            
            [arr_model removeAllObjects];
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PXNeedModel  *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData
{
    [WebRequest Training_TrainingMatch_Get_CourseTrainMatchWithcourseId:self.courseId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PXNeedModel  *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
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
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"根据课程匹配的需求";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXNeedModel *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    PXNeedModel  *model = arr_model[indexPath.row];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.thetheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:3]}];
    NSMutableAttributedString  *com = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"[%@]\n",model.company] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [name appendAttributedString:com];
    NSMutableAttributedString  *timePlace = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"培训地点：%@\n预计时间：%@ ~ %@",model.theplace,model.thedateStart,model.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    timePlace.yy_alignment = NSTextAlignmentRight;
    [name appendAttributedString:timePlace];
    name.yy_lineSpacing =6;
    cell.YL_label.attributedText = name;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cellHeight = size.height+20;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+15);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXNeedModel  *model = arr_model[indexPath.row];
    PXNeedDetailViewController *Dvc = [[PXNeedDetailViewController alloc]init];
    Dvc.Id = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
