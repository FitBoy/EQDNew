//
//  FX_riZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/16.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FX_riZhiViewController.h"
#import "FX_riZhiAddViewController.h"
#import "FBButton.h"
#import <Masonry.h>
#import "Com_dongTanModel.h"
#import "Com_dongTanTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "PPersonCardViewController.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "GZQ_ZanViewController.h"
#import "RiZhi_PingLunViewController.h"
@interface FX_riZhiViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate,Com_dongTanTableViewCellDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
    ///留言所需
    NSString *isHuifu_;
    NSIndexPath *indexPath_selected;
    GZQ_PingLunModel *model_slected;
}

@end

@implementation FX_riZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    
    [WebRequest WorkDynamics_Get_WorkDynamicWithuserGuid:user.Guid companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                Com_dongTanModel *model =[Com_dongTanModel mj_objectWithKeyValues:tarr[i]];
                model.height_cell = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    [WebRequest WorkDynamics_Get_WorkDynamicWithuserGuid:user.Guid companyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                Com_dongTanModel *model =[Com_dongTanModel mj_objectWithKeyValues:tarr[i]];
                model.height_cell = 60;
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
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"工作动态";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaRiZhi)];
    [self.navigationItem setRightBarButtonItem:right];
  
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    isHuifu_ =@"0";
     [self loadRequestData];
}



#pragma  mark - 添加日志
-(void)tianjiaRiZhi
{
    FX_riZhiAddViewController  *Avc = [[FX_riZhiAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_dongTanModel *model =arr_model[indexPath.row];
    return model.height_cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    Com_dongTanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[Com_dongTanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.V_top.IV_fenxiang.hidden =YES;
    Com_dongTanModel  *model = arr_model[indexPath.row];
    model.indexPath_cell = indexPath;
    [cell setModel_dongtai:model];
    cell.delegate_dongtai = self;
    //头像
    FBindexTapGestureRecognizer *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick:)];
    tap_head.indexPath = indexPath;
    [cell.V_top.IV_head addGestureRecognizer:tap_head];
    //内容
    FBindexTapGestureRecognizer *tap_content = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_contentClick:)];
    tap_content.indexPath = indexPath;
    [cell.V_content addGestureRecognizer:tap_content];
    //点赞的人
    FBindexTapGestureRecognizer *tap_zan1 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zan0Click:)];
    tap_zan1.indexPath = indexPath;
    [cell.V_bottom.IV_zan1 addGestureRecognizer:tap_zan1];
    FBindexTapGestureRecognizer *tap_zan2 = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zan0Click:)];
    tap_zan2.indexPath = indexPath;
    [cell.V_bottom.IV_zan2 addGestureRecognizer:tap_zan2];
    FBindexTapGestureRecognizer *tap_zan3 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zan0Click:)];
    tap_zan3.indexPath =indexPath;
    [cell.V_bottom.IV_zan3 addGestureRecognizer:tap_zan3];
    
    FBindexTapGestureRecognizer *tap_zan4 = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zan0Click:)];
    tap_zan4.indexPath = indexPath;
    [cell.V_bottom addGestureRecognizer:tap_zan4];
    
    //点赞
    FBindexTapGestureRecognizer *tap_zan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanCLick:)];
    tap_zan.indexPath =indexPath;
    [cell.V_bottom.IV_zan addGestureRecognizer:tap_zan];
    //评论
    FBindexTapGestureRecognizer *tap_pinglun = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_pinglunClick:)];
    tap_pinglun.indexPath = indexPath;
    [cell.V_bottom.IV_liuyan addGestureRecognizer:tap_pinglun];
    
    
    
    return cell;
}
#pragma  mark - 评论区域的点击事件
-(void)getDongTaiModel:(GZQ_PingLunModel *)model_pinglun AndisHuifu:(NSInteger)isHuifu
{
    model_slected = model_pinglun;
   if(isHuifu ==0)
   {
       PPersonCardViewController *Pvc = [[PPersonCardViewController alloc]init];
       Pvc.userGuid = model_pinglun.Creater;
       [self.navigationController pushViewController:Pvc animated:NO];
   }else if (isHuifu ==1)
   {
       PPersonCardViewController *Pvc = [[PPersonCardViewController alloc]init];
       Pvc.userGuid = model_pinglun.parentUserGuid;
       [self.navigationController pushViewController:Pvc animated:NO];
   }else if (isHuifu ==2)
   {
       indexPath_selected = model_pinglun.indexpath_cell;
       isHuifu_ =@"1";
       FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
       LYvc.providesPresentationContextTransitionStyle = YES;
       LYvc.definesPresentationContext = YES;
       LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
       LYvc.delegate =self;
       LYvc.btnName = @"留言";
       LYvc.placeHolder = [NSString stringWithFormat:@"回复%@：",model_pinglun.createStaffName];
       dispatch_async(dispatch_get_main_queue(), ^{
           [self presentViewController:LYvc animated:NO completion:nil];
       });
   }else if (isHuifu == 3)
   {
       
   }else
   {
       
   }
}
-(void)getMoreWithDongTaiModel:(Com_dongTanModel *)model_more
{
   
    RiZhi_PingLunViewController *Pvc =[[RiZhi_PingLunViewController alloc]init];
    Pvc.temp =[model_more.type integerValue];
    Pvc.dailyId = model_more.objectId;
    [self.navigationController pushViewController:Pvc animated:NO];
}

#pragma  mark - 留言
-(void)tap_pinglunClick:(FBindexTapGestureRecognizer*)tap
{
//    Com_dongTanModel  *model = arr_model[tap.indexPath.row];
    indexPath_selected = tap.indexPath;
    isHuifu_ =@"0";
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.delegate =self;
    LYvc.btnName = @"留言";
    LYvc.placeHolder = @"我也说点什么……";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:LYvc animated:NO completion:nil];
    });
}
#pragma  mark - 留言的delegate
-(void)getPresnetText:(NSString *)text
{
    Com_dongTanModel *model = arr_model[indexPath_selected.row];
    if ([isHuifu_ integerValue]==0) {
        //对动态本身留言
        if ([model.type integerValue]==0) {
            //日志
            
            [WebRequest daily_Add_Daily_CommentWithdailyId:model.objectId userGuid:user.Guid message:text parentId:@"0" parentUserGuid:@" " firstCommentId:@"0" And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    GZQ_PingLunModel *tmodel = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                    NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.Comment];
                    [tarr insertObject:tmodel atIndex:0];
                    model.Comment =tarr;
                    [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model];
                    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                    
                }else
                {
                    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                    [alert showAlertWith:@"未知错误，请重试"];
                }
                
            }];
        }else if ([model.type integerValue]==1)
        {
            //任务
            
            [WebRequest WorkDynamics_MyTask_Add_Task_CommentWithtaskId:model.objectId userGuid:user.Guid message:text parentId:@"0" parentUserGuid:@" " firstCommentId:@"0" And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    GZQ_PingLunModel *tmodel = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                    NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.taskComment];
                    [tarr insertObject:tmodel atIndex:0];
                    model.taskComment =tarr;
                    [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model];
                    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                    
                }else
                {
                    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                    [alert showAlertWith:@"未知错误，请重试"];
                }
            }];
            
        }
        
    }else if ([isHuifu_ integerValue]==1)
        {
            NSString *firstComment = nil;
            if ([model_slected.firstCommentId integerValue]==0) {
                firstComment = model_slected.Id;
            }else
            {
                firstComment = model_slected.firstCommentId;
            }
            if ([model.type integerValue]==0) {
                //日志
                
                [WebRequest daily_Add_Daily_CommentWithdailyId:model.objectId userGuid:user.Guid message:text parentId:model_slected.Id parentUserGuid:model_slected.Creater firstCommentId:firstComment And:^(NSDictionary *dic) {
                    if ([dic[Y_STATUS] integerValue]==200) {
                        GZQ_PingLunModel *tmodel = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                        NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.Comment];
                        [tarr insertObject:tmodel atIndex:0];
                        model.Comment =tarr;
                        [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model];
                        [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                        
                    }else
                    {
                        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"未知错误，请重试"];
                    }
                    
                }];
            }else if ([model.type integerValue]==1)
            {
                //任务
                
                
                [WebRequest WorkDynamics_MyTask_Add_Task_CommentWithtaskId:model.objectId userGuid:user.Guid message:text parentId:model_slected.Id parentUserGuid:model_slected.Creater firstCommentId:firstComment And:^(NSDictionary *dic) {
                    if ([dic[Y_STATUS] integerValue]==200) {
                        GZQ_PingLunModel *tmodel = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                        NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.taskComment];
                        [tarr insertObject:tmodel atIndex:0];
                        model.taskComment =tarr;
                        [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model];
                        [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                        
                    }else
                    {
                        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"未知错误，请重试"];
                    }
                }];
        }
        }
        else
        {
            
        }
    
}
#pragma  mark - 点赞
-(void)tap_zanCLick:(FBindexTapGestureRecognizer*)tap{
    Com_dongTanModel  *model = arr_model[tap.indexPath.row];
    if ([model.type integerValue]==0) {
        //日志
        [WebRequest  daily_Add_Daily_ZanWithdailyId:model.objectId userGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                [tarr addObject:user.iphoto];
                for (int i=0; i<model.UserZan.count; i++) {
                    ZanModel *model2 = model.UserZan[i];
                    [tarr addObject:model2.headImage];
                }
               
                Com_dongTanTableViewCell *cell = [tableV cellForRowAtIndexPath:tap.indexPath];
                [cell.V_bottom updateZanWithZanArr:tarr];
            }else
            {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"您已经点过赞了"];
            }
        }];
    }else if ([model.type integerValue]==1)
    {
        //任务
        [WebRequest WorkDynamics_MyTask_Task_ZanWithtaskId:model.objectId userGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                [tarr addObject:user.iphoto];
                for (int i=0; i<model.UserZan.count; i++) {
                    ZanModel *model2 = model.UserZan[i];
                    [tarr addObject:model2.headImage];
                }
                
                Com_dongTanTableViewCell *cell = [tableV cellForRowAtIndexPath:tap.indexPath];
                [cell.V_bottom updateZanWithZanArr:tarr];
            }else
            {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"点赞失败，请重试"];
            }
        }];
    }else
    {
        
    }
   
}
#pragma  mark - 点赞的人
-(void)tap_zan0Click:(FBindexTapGestureRecognizer*)tap{
    Com_dongTanModel   *model = arr_model[tap.indexPath.row];
    GZQ_ZanViewController  *Zvc = [[GZQ_ZanViewController alloc]init];
    Zvc.temp = [model.type integerValue]+1;
    Zvc.cell_id = model.objectId;
    [self.navigationController pushViewController:Zvc animated:NO];
}
#pragma  mark - 点击内容
-(void)tap_contentClick:(FBindexTapGestureRecognizer*)tap
{
    Com_dongTanModel   *model = arr_model[tap.indexPath.row];
    RiZhi_PingLunViewController  *Pvc =[[RiZhi_PingLunViewController alloc]init];
    Pvc.temp = [model.type integerValue];
    Pvc.dailyId = model.objectId;
    [self.navigationController pushViewController:Pvc animated:NO];
}
#pragma  mark - 点击头像
-(void)tap_headClick:(FBindexTapGestureRecognizer*)tap{
    Com_dongTanModel  *model = arr_model[tap.indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid = model.creater;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
