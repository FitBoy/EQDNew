//
//  RiZhi_PingLunDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RiZhi_PingLunDetailViewController.h"
#import "GZQ_PingLunTableViewCell.h"
#import "EQDR_labelTableViewCell.h"
#import "PPersonCardViewController.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
@interface RiZhi_PingLunDetailViewController ()<UITableViewDelegate,UITableViewDataSource,EQDR_labelTableViewCellDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
    GZQ_PingLunModel *model_selected;
}

@end

@implementation RiZhi_PingLunDetailViewController
#pragma  mark - 点击人名与内容
-(void)getPingLunRiZhiModel:(GZQ_PingLunModel *)model_pinglun Withtemp:(NSInteger)temp
{
    if (temp ==0) {
        //第一个人
        PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid = model_pinglun.Creater;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (temp==1)
    {
        //第二个人
        PPersonCardViewController *Pvc = [[PPersonCardViewController alloc]init];
        Pvc.userGuid = model_pinglun.parentUserGuid;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (temp ==2)
    {
        //内容
        model_selected = model_pinglun;
        FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
        LYvc.delegate =self;
        LYvc.btnName = @"发送";
        LYvc.placeHolder = [NSString stringWithFormat:@"回复%@",model_pinglun.createName];
        LYvc.providesPresentationContextTransitionStyle = YES;
        LYvc.definesPresentationContext = YES;
        LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:LYvc animated:NO completion:nil];
        });
        
    }else if (temp ==12)
    {
        ///长按内容
        UIAlertController *alert = [[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            if (self.temp ==0) {
            [WebRequest daily_Delete_DailyCommentWithuserGuid:user.Guid commentId:model_pinglun.Id type:@"2" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model removeObject:model_pinglun];
                        [tableV reloadData];
                    }
                });
            }];
            }else if (self.temp ==1)
            {
                [WebRequest WorkDynamics_MyTask_Delete_Task_CommentWithuserGuid:user.Guid commentId:model_pinglun.Id type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        if ([dic[Y_STATUS] integerValue]==200) {
                            [arr_model removeObject:model_pinglun];
                            [tableV reloadData];
                        }
                    });
                }];
            }else
            {
                
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
     
    }
    else
    {
        
    }
}
-(void)IV_liuyanClick
{
    model_selected = self.model;
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.delegate =self;
    LYvc.btnName = @"发送";
    LYvc.placeHolder = [NSString stringWithFormat:@"回复%@",model_selected.createStaffName];
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:LYvc animated:NO completion:nil];
    });
}
#pragma  mark - 留言
-(void)getPresnetText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在发送";
    NSString *FirstCommentId =nil;
    if ([model_selected.firstCommentId integerValue]==0) {
        FirstCommentId = model_selected.Id;
    }else
    {
        FirstCommentId = model_selected.firstCommentId;
    }
    if (self.temp==0) {

    [WebRequest daily_Add_Daily_CommentWithdailyId:model_selected.dailyId userGuid:user.Guid message:text parentId:model_selected.Id parentUserGuid:model_selected.parentUserGuid firstCommentId:FirstCommentId And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                [arr_model insertObject:model atIndex:0];
                [tableV reloadData];
            }
        });
    }];
    }else if(self.temp ==1)
    {
        [WebRequest WorkDynamics_MyTask_Add_Task_CommentWithtaskId:model_selected.taskId userGuid:user.Guid message:text parentId:model_selected.Id parentUserGuid:model_selected.Creater firstCommentId:FirstCommentId And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                    [arr_model insertObject:model atIndex:0];
                    [tableV reloadData];
                }
            });
        }];
    }
        
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    if (self.temp ==0) {
    [WebRequest daily_Get_ChildCommentWithdailyId:self.model.dailyId page:@"0" firstCommentId:self.model.Id And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                GZQ_PingLunModel  *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }else if (self.temp ==1)
    {
        [WebRequest WorkDynamics_MyTask_Get_ChildCommentWithtaskId:self.model.taskId page:@"0" firstCommentId:self.model.Id And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr =dic[Y_ITEMS];
                page = dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    GZQ_PingLunModel  *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
        
    }
}
-(void)loadOtherData{
    if (self.temp==0) {
    [WebRequest daily_Get_ChildCommentWithdailyId:self.model.dailyId page:page firstCommentId:self.model.Id And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                GZQ_PingLunModel  *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }else if (self.temp ==1)
    {
        [WebRequest WorkDynamics_MyTask_Get_ChildCommentWithtaskId:self.model.taskId page:page firstCommentId:self.model.Id And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr =dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page = dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        GZQ_PingLunModel  *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}

#pragma  mark - 内容的长按
-(void)longPressClick
{
    if ([self.model.Creater isEqualToString:user.Guid]) {
        UIAlertController *alert = [[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if(self.temp ==0)
            {
                [WebRequest daily_Delete_DailyCommentWithuserGuid:user.Guid commentId:self.model.Id type:@"1" And:^(NSDictionary *dic) {
                  
                        if ([dic[Y_STATUS] integerValue] == 200) {
                            [self.navigationController popViewControllerAnimated:NO];
                        }else
                        {
                            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                            [alert showAlertWith:@"删除失败请重试"];
                        }
                }];
            }else if (self.temp ==1 )
            {
                //任务
                [WebRequest WorkDynamics_MyTask_Delete_Task_CommentWithuserGuid:user.Guid commentId:self.model.Id type:@"1" And:^(NSDictionary *dic) {
                    if ([dic[Y_STATUS] integerValue] == 200) {
                        [self.navigationController popViewControllerAnimated:NO];
                    }else
                    {
                        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"删除失败请重试"];
                    }
                }];
            }else
            {
                
            }
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"评论详情";
    self.model.childList =nil;
    GZQ_PingLunTableViewCell  *cell = [[GZQ_PingLunTableViewCell alloc]init];
    
    [cell setModel2:self.model];
    UITapGestureRecognizer  *tap_liuyan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(IV_liuyanClick)];
    [cell.IV_liuyan addGestureRecognizer:tap_liuyan];
    FBindexpathLongPressGestureRecognizer *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick)];
    [cell.L_contents addGestureRecognizer:longPress];
    UITapGestureRecognizer *huifu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(IV_liuyanClick)];
    [cell.L_contents addGestureRecognizer:huifu];
    
    cell.frame = CGRectMake(0, 0, DEVICE_WIDTH, self.model.cellHeight);
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    tableV.tableHeaderView = cell;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZQ_PingLunModel *model = arr_model[indexPath.row];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.delegate =self;
    GZQ_PingLunModel *model = arr_model[indexPath.row];
    model.indexpath_cell = indexPath;
    [cell setModel_RiZhiPingLun:model];
    return cell;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
