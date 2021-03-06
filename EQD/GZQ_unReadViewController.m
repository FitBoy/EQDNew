//
//  GZQ_unReadViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "GZQ_unReadViewController.h"
#import "GZQ_messageTableViewCell.h"
#import "GongZuoQunModel.h"
#import "GZQ_PingLunViewController.h"
#import "RiZhi_PingLunViewController.h"
@interface GZQ_unReadViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
    UITableView *tableV;
}

@end

@implementation GZQ_unReadViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    if(self.temp ==1)
    {
   [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"400" And:^(NSDictionary *dic) {
            
        }];
        [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"401" And:^(NSDictionary *dic) {
            
        }];
    }else
    {
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"360" And:^(NSDictionary *dic) {
        
    }];
    }
    
}
-(void)loadRequestData{
  
    if (self.temp ==1) {
        [WebRequest daily_Get_DailyNewsWithpage:@"0" userGuid:user.Guid And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
            
                NSArray *tarr = dic[Y_ITEMS];
                page = dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    GZQ_MessageModel  *model = [GZQ_MessageModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
    [WebRequest  WorkCircles_news_Get_MyWorkCircleNewsWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSArray *tarr = dic2[@"rows"];
            page = dic2[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                GZQ_MessageModel  *model = [GZQ_MessageModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }
    
}
-(void)loadOtherData{
    
    if (self.temp ==1) {
        [WebRequest daily_Get_DailyNewsWithpage:@"0" userGuid:user.Guid And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *dic2 =dic[Y_ITEMS];
                NSArray *tarr = dic2[@"rows"];
                page = dic2[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    GZQ_MessageModel  *model = [GZQ_MessageModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
    
    [WebRequest  WorkCircles_news_Get_MyWorkCircleNewsWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
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
                GZQ_MessageModel  *model = [GZQ_MessageModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
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
    self.navigationItem.title = @"评论点赞的消息";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page = @"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZQ_MessageModel  *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    GZQ_messageTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GZQ_messageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    GZQ_MessageModel  *model = arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZQ_MessageModel  *model1 = arr_model[indexPath.row];
    
    if (self.temp ==1) {
        RiZhi_PingLunViewController  *PLvc = [[RiZhi_PingLunViewController alloc]init];
        PLvc.temp =0;
        PLvc.dailyId = model1.dailyId;
        [self.navigationController pushViewController:PLvc animated:NO];
    }else
    {
    [WebRequest Get_WorkCircle_ByIdWithworkCircleId:model1.workCircleId userGuid:user.Guid And:^(NSDictionary *dic) {
       
        if ([dic[Y_STATUS] integerValue]==200) {
            
            GongZuoQunModel *model = [GongZuoQunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            dispatch_async(dispatch_get_main_queue(), ^{
                GZQ_PingLunViewController  *PLvc = [[GZQ_PingLunViewController alloc]init];
                PLvc.model = model;
                [self.navigationController pushViewController:PLvc animated:NO];
            });
            
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"服务器错误"];
        }
    }];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.temp ==1)
    {
    return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //拒绝邀请
        GZQ_MessageModel  *model = arr_model[indexPath.row];
        [WebRequest daily_Delete_DailyNewsWithuserGuid:user.Guid newsId:model.Id And:^(NSDictionary *dic) {
            MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"成功"];
                [arr_model removeObject:model];
                [tableV reloadData];
            }else
            {
                [alert showAlertWith:@"删除失败，请重试！"];
            }
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}




@end
