//
//  Meeting_noticeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Meeting_noticeViewController.h"
#import "Meeting_addViewController.h"
#import "MeetingModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "NSString+FBString.h"
#import "MeetingNotice_DetailViewController.h"
@interface Meeting_noticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_huiyi;
    UIView *V_head;
    
}

@end

@implementation Meeting_noticeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    if (self.temp ==1) {
        [WebRequest Meeting_Get_metNotices_adminWithuserGuid:user.Guid comid:user.companyId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue] == 200) {
                page =dic[@"nextpage"];
                [arr_model removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    MeetingModel *model = [MeetingModel mj_objectWithKeyValues:tarr[i]];
                    
                    model.cell_height = 60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else {
        
    [WebRequest Meeting_Get_meetingNoticesWithuserGuid:user.Guid comid:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue] == 200) {
            page =dic[@"nextpage"];
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                MeetingModel *model = [MeetingModel mj_objectWithKeyValues:tarr[i]];

                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }
}
-(void)loadOtherData
{
    if (self.temp ==1) {
        [WebRequest Meeting_Get_metNotices_adminWithuserGuid:user.Guid comid:user.companyId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue] == 200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page =dic[@"nextpage"];
                    for (int i=0; i<tarr.count; i++) {
                        MeetingModel *model = [MeetingModel mj_objectWithKeyValues:tarr[i]];
                        model.cell_height = 60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else
    {
    
    [WebRequest Meeting_Get_meetingNoticesWithuserGuid:user.Guid comid:user.companyId page:page And:^(NSDictionary *dic) {
    [tableV.mj_header endRefreshing];
    [tableV.mj_footer endRefreshing];
    if ([dic[Y_STATUS] integerValue] == 200) {
        NSArray *tarr = dic[Y_ITEMS];
        if (tarr.count==0) {
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            page =dic[@"nextpage"];
        for (int i=0; i<tarr.count; i++) {
            MeetingModel *model = [MeetingModel mj_objectWithKeyValues:tarr[i]];
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
    arr_huiyi = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"会议通知";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    [WebRequest Meeting_Get_MettionByAdminWithuserGuid:user.Guid companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue] == 200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaTongZhiClick)];
                    [self.navigationItem setRightBarButtonItem:right];
                });
                [arr_huiyi removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    MeetingModel *model = [MeetingModel mj_objectWithKeyValues:tarr[i]];
                    [arr_huiyi addObject:model];
                }
            }
        }
    }];
    
    
    V_head = [[UIView alloc]init];
    V_head.userInteractionEnabled =YES;
    UILabel *tlabel = [[UILabel alloc]init];
    tlabel.numberOfLines =0;
    [V_head addSubview:tlabel];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.lineSpacing =6;
    NSMutableAttributedString *Tstr =[[NSMutableAttributedString alloc]initWithString:@"1.会议通知人点右上角的+，可以发会议通知\n2.会议主持人点会议通知进详情，可以发起会议签到\n3.会议记录人可以点会议通知进详情，添加记录信息" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[[UIColor redColor] colorWithAlphaComponent:0.6],NSParagraphStyleAttributeName:para}] ;
   
    CGSize size = [Tstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    V_head.frame =CGRectMake(0, 0, DEVICE_WIDTH, size.height+20);
    tlabel.frame =CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+10);
    tlabel.attributedText =Tstr;
    V_head.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    tableV.tableHeaderView =V_head;
   
}
#pragma  mark - 添加通知
-(void)tianjiaTongZhiClick
{
    if (arr_huiyi.count==1) {
        MeetingModel *model =arr_huiyi[0];
        Meeting_addViewController  *Avc =[[Meeting_addViewController alloc]init];
        Avc.temp =1;
        Avc.settingId = model.Id;
        [self.navigationController pushViewController:Avc animated:NO];
    }else if(arr_huiyi.count >1)
    {
        UIAlertController *alert = [[UIAlertController alloc]init];
        for(int i=0;i<arr_huiyi.count;i++)
        {
            MeetingModel *model =arr_huiyi[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.type style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                Meeting_addViewController  *Avc =[[Meeting_addViewController alloc]init];
                Avc.temp =1;
                Avc.settingId = model.Id;
                [self.navigationController pushViewController:Avc animated:NO];
                
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }else
    {
        
    }
   
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetingModel *model =arr_model[indexPath.row];
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
    MeetingModel  *model =arr_model[indexPath.row];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.type] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:2]}];
    name.yy_alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *times =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"时间:%@~%@\n",model.startTime,model.endTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:times];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"地点:%@\n",model.place] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:place];
    name.yy_lineSpacing = 6;
    cell.YL_label.attributedText =name;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height = size.height +20;
    
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height +10);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetingModel *model = arr_model[indexPath.row];
    if ([self.delegate_huiyi respondsToSelector:@selector(getMeetingModel:)]) {
        [self.delegate_huiyi getMeetingModel:model];
    }else
    {
    MeetingNotice_DetailViewController  *Dvc = [[MeetingNotice_DetailViewController alloc]init];
    Dvc.noticeId = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
    }
}




@end
