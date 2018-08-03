//
//  MeetingNotice_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "MeetingNotice_DetailViewController.h"
#import "MeetingModel.h"
#import <YYText.h>
#import "FBButton.h"
#import <Masonry.h>
#import "PXKaoQin_ErWeiMaViewController.h"
#import "PXKaoQinListModel.h"
#import "PXQianDaoListTableViewCell.h"
#import "Meeting_recoderListViewController.h"
@interface MeetingNotice_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    MeetingModel *model_detail;
    UIView *V_head;
    FBButton *B_title;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation MeetingNotice_DetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Meeting_Get_signDetails_meetWithuserGuid:user.Guid comid:user.companyId noticeId:self.noticeId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
     if([dic[Y_STATUS] integerValue]==200)
     {
         [arr_model removeAllObjects];
         NSArray *tarr = dic[Y_ITEMS];
         page =dic[@"nextpage"];
         for (int i=0; i<tarr.count; i++) {
             PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
             [arr_model addObject:model];
         }
         [tableV reloadData];
     }
    }];
    
}
-(void)loadOtherData{
    
    [WebRequest Meeting_Get_signDetails_meetWithuserGuid:user.Guid comid:user.companyId noticeId:self.noticeId page:page And:^(NSDictionary *dic) {
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
                    PXKaoQinListModel *model = [PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
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
-(void)erweimaClick{
    if([model_detail.status integerValue]==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发起……";
    [WebRequest Meeting_Launch_meetSignInWithuserGuid:user.Guid comid:user.companyId noticeId:self.noticeId And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
        if ([dic[Y_STATUS] integerValue]==200) {
            PXKaoQin_ErWeiMaViewController *Kvc =[[PXKaoQin_ErWeiMaViewController alloc]init];
            Kvc.temp =1;
            Kvc.model_huiyi =model_detail;
            [self.navigationController pushViewController:Kvc animated:NO];
        }
    }];
    }else if([model_detail.status integerValue]==1)
    {
        ///签到二维码
        PXKaoQin_ErWeiMaViewController *Kvc =[[PXKaoQin_ErWeiMaViewController alloc]init];
        Kvc.temp =1;
        Kvc.model_huiyi =model_detail;
        [self.navigationController pushViewController:Kvc animated:NO];
    }else
    {
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"会议通知详情";
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    V_head = [[UIView alloc]init];
    V_head.userInteractionEnabled =YES;
    V_head.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    B_title = [FBButton buttonWithType:UIButtonTypeSystem];
    [B_title setTitle:@"发起签到" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:19]];
    [B_title addTarget:self action:@selector(erweimaClick) forControlEvents:UIControlEventTouchUpInside];
    
    [WebRequest Meeting_Get_metNoticeDeWithuserGuid:user.Guid comid:user.companyId noticeId:self.noticeId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [MeetingModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            YYLabel *tlabel = [[YYLabel alloc]init];
            tlabel.numberOfLines =0;
            [V_head addSubview:tlabel];
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_detail.type] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
            title.yy_alignment = NSTextAlignmentCenter;
            NSMutableAttributedString *place = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"地点:%@\n",model_detail.place] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            [title appendAttributedString:place];
            NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"时间:%@~%@\n",model_detail.startTime,model_detail.endTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            [title appendAttributedString:time];
            NSMutableAttributedString *zhucheR =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"主持人:%@\n",model_detail.compere.realName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            [title appendAttributedString:zhucheR];
            title.yy_lineSpacing =6;
            CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            float height = size.height +15;
            tlabel.frame = CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+10);
            tlabel.attributedText = title;
            
           
            
            if ([model_detail.compere.guid isEqualToString:user.Guid]&&[model_detail.status integerValue]==0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                 [V_head addSubview:B_title];
                    [B_title mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(110, 30));
                        make.centerX.mas_equalTo(V_head.mas_centerX);
                        make.bottom.mas_equalTo(V_head.mas_bottom).mas_offset(-5);
                    }];
                });
                
                height=height+40;
            }else if([model_detail.status integerValue]==1)
            {
                [B_title setTitle:@"签到二维码" forState:UIControlStateNormal];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [V_head addSubview:B_title];
                    [B_title mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(110, 30));
                        make.centerX.mas_equalTo(V_head.mas_centerX);
                        make.bottom.mas_equalTo(V_head.mas_bottom).mas_offset(-5);
                    }];
                });
                
                height=height+40;
                
            }else if ([model_detail.status integerValue]==2)
            {
                [B_title setTitle:@"签到已结束" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [V_head addSubview:B_title];
                    [B_title mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(110, 30));
                        make.centerX.mas_equalTo(V_head.mas_centerX);
                        make.bottom.mas_equalTo(V_head.mas_bottom).mas_offset(-5);
                    }];
                });
                
                height=height+40;
            }
            else
            {
                [B_title removeFromSuperview];
            }
            V_head.frame =CGRectMake(0, 0, DEVICE_WIDTH, height);
            dispatch_async(dispatch_get_main_queue(), ^{
                tableV.tableHeaderView = V_head;
            });
        }
    }];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"会议记录" style:UIBarButtonItemStylePlain target:self action:@selector(jiluAddClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
#pragma  mark - 添加会议记录
-(void)jiluAddClick
{
    Meeting_recoderListViewController *Rvc = [[Meeting_recoderListViewController alloc]init];
    Rvc.settingId = self.noticeId;
    [self.navigationController pushViewController:Rvc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    PXQianDaoListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PXQianDaoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    PXKaoQinListModel  *model =arr_model[indexPath.row];
    [cell setModel:model];
    cell.L_center.hidden =YES;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
