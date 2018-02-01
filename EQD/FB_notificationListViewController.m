//
//  FB_notificationListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_notificationListViewController.h"
#import "FB_notificationAddViewController.h"
#import "PX_NotificationListModel.h"
#import "EQDR_labelTableViewCell.h"
#import "FBAnyWayDetailViewController.h"
#import <Masonry.h>
@interface FB_notificationListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation FB_notificationListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)loadRequestData{
    [WebRequest Training_Get_trainNoticeListWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            page =dic[@"nextpage"];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                PX_NotificationListModel *model = [PX_NotificationListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    [WebRequest Training_Get_trainNoticeListWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
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
                PX_NotificationListModel *model = [PX_NotificationListModel mj_objectWithKeyValues:tarr[i]];
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
    user = [WebRequest GetUserInfo];
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"培训通知列表";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [self loadRequestData];

}
-(void)tianjiaClick
{
    FB_notificationAddViewController *Avc = [[FB_notificationAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PX_NotificationListModel *model =arr_model[indexPath.row];
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    PX_NotificationListModel  *model =arr_model[indexPath.row];
    NSMutableAttributedString  *thethem = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"培训主题：%@",model.theTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n培训地点：%@",model.theplace] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [thethem appendAttributedString:place];
    
    NSMutableAttributedString *person =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n讲师：%@",model.teacherName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [thethem appendAttributedString:person];
  
    NSMutableAttributedString *ttime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n发布时间：%@",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [thethem appendAttributedString:ttime];
    CGSize size =[thethem boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    cell.YL_label.attributedText = thethem;
    model.cellHeight = size.height+10;
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

    PX_NotificationListModel *model =arr_model[indexPath.row];
    [WebRequest Training_Get_trainNoticeDetailWithuserGuid:user.Guid comid:user.companyId noticeId:model.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray  *tarr_name =@[@"培训主题",@"受训对象",@"受训人数",@"培训时间",@"培训地点",@"主讲老师",@"讲师介绍",@"课程大纲",@"创建时间"];
            PX_NotificationListModel *model_detail = [PX_NotificationListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSMutableString  *Tstr = [NSMutableString string];
            for (int i=0; i<model_detail.theTrainTime.count; i++) {
                PXQianDaoModel *model3 =model_detail.theTrainTime[i];
                if (i==model_detail.theTrainTime.count-1) {
                    [Tstr appendString:model3.theTrainTime];
                }else
                {
                    [Tstr appendFormat:@"%@\n",model3.theTrainTime];
                }
            }
            NSArray  *tarr_content = @[model_detail.theTheme,model_detail.trainees,model_detail.personNumber,Tstr,model_detail.theplace,model_detail.teacherName,model_detail.teacherInfo,model_detail.aSyllabus,model_detail.createTime];
            NSMutableArray *tarr_model = [NSMutableArray arrayWithCapacity:0];
            for (int i=0; i<tarr_content.count; i++) {
                AnyWayModel *model2 = [[AnyWayModel alloc]init];
                model2.name =tarr_name[i];
                model2.contents = tarr_content[i];
                if (i==7) {
                    model2.type = @"2";
                }else
                {
                    model2.type = @"1";
                }
                [tarr_model addObject:model2];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                FBAnyWayDetailViewController *Dvc = [[FBAnyWayDetailViewController alloc]init];
                Dvc.Dtitle = @"培训通知详情";
                Dvc.arr_json = tarr_model;
                [self.navigationController pushViewController:Dvc animated:NO];
            });
            
        }
    }];
    
    
}



@end
