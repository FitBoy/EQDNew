//
//  FX_MyRiZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FX_MyRiZhiViewController.h"
#import "RIZhiListModel.h"
#import "RiZhiListTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "PPersonCardViewController.h"
#import "GZQ_ZanViewController.h"
#import "RiZhi_PingLunViewController.h"
#import "FX_riZhiAddViewController.h"
#import <Masonry.h>
#import "GZQ_unReadViewController.h"
@interface FX_MyRiZhiViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate,RiZhiListTableViewCellDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_model;
    NSIndexPath *indexPath_selected;
    
    NSString *isHuiFu2;
    GZQ_PingLunModel *model_pinglunSelected;
    
    NSString *code_num;
    UIView *tview_head;
    UILabel *tlabel ;
}

@end

@implementation FX_MyRiZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    code_num = @"0";
    [self message_recived];
   
}
-(void)loadRequestData{
  
    if (self.temp ==1) {
    [WebRequest daily_Get_DailyWithcompanyId:user.companyId page:@"0" userGuid:user.Guid And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                RIZhiListModel *model = [RIZhiListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
        
        //清空  402 的code
        [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"402" And:^(NSDictionary *dic) {
            
        }];
        
        
    }else if (self.temp ==0)
    {
    [WebRequest daily_Get_MyDailyWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
           
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                RIZhiListModel *model = [RIZhiListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }else if (self.temp ==2)
    {
        
        [WebRequest daily_Get_UserDailyWithcompanyId:user.companyId objecterGuid:self.otherGuid page:@"0" userGuid:user.Guid  And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    RIZhiListModel *model = [RIZhiListModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
    else
    {
        
    }
}
-(void)loadOtherData{
    if (self.temp ==0) {
    [WebRequest daily_Get_MyDailyWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
         
            NSArray *tarr = dic[Y_ITEMS];
            
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                RIZhiListModel *model = [RIZhiListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }else if (self.temp ==1 )
    {
        [WebRequest daily_Get_DailyWithcompanyId:user.companyId page:page userGuid:user.Guid And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
               
                NSArray *tarr = dic[Y_ITEMS];
                
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page = dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        RIZhiListModel *model = [RIZhiListModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else if (self.temp == 2)
    {
        [WebRequest daily_Get_UserDailyWithcompanyId:user.companyId objecterGuid:self.otherGuid page:page userGuid:user.Guid  And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                
                NSArray *tarr = dic[Y_ITEMS];
                
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page = dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        RIZhiListModel *model = [RIZhiListModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }
    else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tview_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    tview_head.userInteractionEnabled =YES;
    tlabel = [[UILabel alloc]init];
    [tview_head addSubview:tlabel];
    tlabel.backgroundColor = EQDCOLOR;
    tlabel.textColor = [UIColor whiteColor];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.layer.masksToBounds = YES;
    tlabel.layer.cornerRadius =6;
    tlabel.userInteractionEnabled =YES;
    UITapGestureRecognizer  *tap_message = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_messageClick)];
    [tview_head addGestureRecognizer:tap_message];
    [tlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.mas_equalTo(tview_head.mas_centerX);
        make.centerY.mas_equalTo(tview_head.mas_centerY);
    }];
    
    
    user  =[WebRequest GetUserInfo];
    NSString *title_ = nil;
    if (self.temp ==0) {
        title_ = @"个人日志";
    }else if (self.temp ==1)
    {
        title_ = @"企业的日志动态";
    }else if (self.temp ==2)
    {
        title_ = @"个人日志";
    }
    self.navigationItem.title =title_;
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    isHuiFu2 = @"0";
     [self loadRequestData];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaRiZhi)];
    [self.navigationItem setRightBarButtonItem:right];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recived) name:Z_FB_message_received object:nil];
    code_num = @"0";
}
-(void)tap_messageClick
{
    //点赞评论的消息
    
    GZQ_unReadViewController  *Rvc = [[GZQ_unReadViewController alloc]init];
    Rvc.temp =1;
    [self.navigationController pushViewController:Rvc animated:NO];
    
}
-(void)message_recived
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray  *tarr = dic[Y_ITEMS];
         
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==400 ||[dic2[@"code"] integerValue]==401 ) {
                    ///企业日志动态
                    code_num =[NSString stringWithFormat:@"%ld",[code_num integerValue] +[dic2[@"count"] integerValue]];
                }
                else
                {
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
            
        }
    }];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([code_num integerValue]>0) {
        tlabel.text = [NSString stringWithFormat:@"%@条未读消息",code_num];
        return tview_head;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([code_num integerValue]>0) {
        return 40;
    }else
    {
        return 1;
    }
}
-(void)tianjiaRiZhi
{
    FX_riZhiAddViewController  *Avc = [[FX_riZhiAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RIZhiListModel *model = arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
#pragma  mark - 点击评论人的名字
-(void)getPinglunModel:(GZQ_PingLunModel *)model_pinglun AndisHuifu:(NSInteger)isHuifu
{
    indexPath_selected = model_pinglun.indexpath_cell;
    if (isHuifu == 0) {
        PPersonCardViewController  *Pvc = [[PPersonCardViewController alloc]init];
        Pvc.userGuid = model_pinglun.Creater;
        [self.navigationController pushViewController:Pvc animated:NO];

    }else if (isHuifu ==1)
    {
         PPersonCardViewController  *Pvc = [[PPersonCardViewController alloc]init];
        Pvc.userGuid = model_pinglun.parentUserGuid;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (isHuifu ==2 )
    {
        isHuiFu2 =@"1";
        
        model_pinglunSelected = model_pinglun;
        FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
        LYvc.providesPresentationContextTransitionStyle = YES;
        LYvc.definesPresentationContext = YES;
        LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        LYvc.delegate = self;
        LYvc.btnName = @"留言";
        LYvc.placeHolder = [NSString stringWithFormat:@"回复%@：",model_pinglun.createName];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:LYvc animated:NO completion:nil];
        });
    }else if (isHuifu ==3)
    {
        //长按
        if ([user.Guid isEqualToString:model_pinglun.Creater]) {
            UIAlertController  *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"正在删除";
                NSString *type= [model_pinglun.firstCommentId integerValue]==0?@"1":@"2";
                [WebRequest daily_Delete_DailyCommentWithuserGuid:user.Guid commentId:model_pinglun.Id type:type And:^(NSDictionary *dic) {
                    hud.label.text = dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        if ([dic[Y_STATUS] integerValue]==200) {
                            RIZhiListModel  *model = arr_model[indexPath_selected.row];
                           NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.comment];
                            if ([type integerValue]==1) {
                               [tarr removeObject:model_pinglun];
                            }else
                            {
                                NSInteger  temp =0;
                                for (int i=0; i<tarr.count; i++) {
                                    if (temp ==1) {
                                        break;
                                    }
                                    GZQ_PingLunModel *model2 = tarr[i];
                                    NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:model2.childList];
                                    if ([tarr2 containsObject:model_pinglun]) {
                                        [tarr2 removeObject:model_pinglun];
                                        model2.childList = tarr2;
                                        [tarr replaceObjectAtIndex:i withObject:model2];
                                        temp =1;
                                        break;
                                    }
                                   
                                }
                            }
                          
                            [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                        }
                    });
                }];
                
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
        }
    }
    else
    {
        
    }
    
}
#pragma  mark - 点击查看更多
-(void)getMoreWithrizhiModel:(RIZhiListModel *)model_more
{
    RiZhi_PingLunViewController  *Pvc = [[RiZhi_PingLunViewController alloc]init];
    Pvc.temp =0;
    Pvc.dailyId = model_more.Id;
    [self.navigationController pushViewController:Pvc animated:NO];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RiZhiListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RiZhiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    indexPath_selected =indexPath;
    RIZhiListModel *model =arr_model[indexPath.row];
    model.indexPath_model = indexPath;
    cell.delegate_rizhi = self;
    [cell setModel_rizhiList:model];
    /// 留言
    FBindexTapGestureRecognizer  *tap_liuyan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLiuYanClick:)];
    tap_liuyan.indexPath = indexPath;
    [cell.IV_liuyan addGestureRecognizer:tap_liuyan];
    
    
    /// 头像
    FBindexTapGestureRecognizer  *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick:)];
    tap_head.indexPath =indexPath;
    [cell.IV_head addGestureRecognizer:tap_head];
    
    /// 点赞的人的列表
    FBindexTapGestureRecognizer *tap_zan1 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanClick:)];
    tap_zan1.indexPath = indexPath;
    [cell.IV_zan1 addGestureRecognizer:tap_zan1];
    FBindexTapGestureRecognizer *tap_zan2 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanClick:)];
    tap_zan2.indexPath = indexPath;
    [cell.IV_zan2 addGestureRecognizer:tap_zan2];
    FBindexTapGestureRecognizer *tap_zan3 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanClick:)];
    tap_zan3.indexPath = indexPath;
    [cell.IV_zan3 addGestureRecognizer:tap_zan3];
    FBindexTapGestureRecognizer *tap_zan4 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanClick:)];
    tap_zan4.indexPath = indexPath;
    [cell.IV_zan4 addGestureRecognizer:tap_zan4];
    
    ///选项卡
    cell.S_fourItems.indexPath = indexPath;
    [cell.S_fourItems addTarget:self action:@selector(itemsClick:) forControlEvents:UIControlEventValueChanged];
    ///点赞
    FBindexTapGestureRecognizer *tap_zan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanCLick2:)];
    tap_zan.indexPath = indexPath;
    [cell.IV_zan addGestureRecognizer:tap_zan];
    
    return cell;
}
#pragma  mark - 点赞
-(void)tap_zanCLick2:(FBindexTapGestureRecognizer *)tap{
    RIZhiListModel *model = arr_model[tap.indexPath.row];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在点赞";
    [WebRequest daily_Add_Daily_ZanWithdailyId:model.Id userGuid:user.Guid And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                RiZhiListTableViewCell  *cell = [tableV cellForRowAtIndexPath:tap.indexPath];
                [cell updateZanWithmodel:model AndImg:user.iphoto];
            }
        });
        
    }];
    
  
}
#pragma  mark - 选项卡
-(void)itemsClick:(FBSegmentedControl*)sg{
    [tableV reloadRowsAtIndexPaths:@[sg.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 点赞的人
-(void)tap_zanClick:(FBindexTapGestureRecognizer*)tap{
    RIZhiListModel  *model = arr_model[tap.indexPath.row];
    GZQ_ZanViewController  *Zvc = [[GZQ_ZanViewController alloc]init];
    Zvc.cell_id = model.Id;
    Zvc.temp = 1;
    [self.navigationController pushViewController:Zvc animated:NO];
}
#pragma  mark - 点击头像
-(void)tap_headClick:(FBindexTapGestureRecognizer*)tap
{
    RIZhiListModel  *model = arr_model[tap.indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.creater;
    [self.navigationController pushViewController:Pvc animated:NO];
}
#pragma  mark - 留言
-(void)tapLiuYanClick:(FBindexTapGestureRecognizer*)tap
{
    indexPath_selected = tap.indexPath;
    isHuiFu2 =@"0";
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.delegate = self;
    LYvc.btnName = @"留言";
    LYvc.placeHolder = @"我也说点什么……";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:LYvc animated:NO completion:nil];
    });
}
#pragma  mark - 留言内容
-(void)getPresnetText:(NSString *)text
{
    RIZhiListModel  *model =arr_model[indexPath_selected.row];
  /// 点留言图标的回复
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在回复";
    if ([isHuiFu2 integerValue]==0) {
    [WebRequest daily_Add_Daily_CommentWithdailyId:model.Id userGuid:user.Guid message:text parentId:@"0" parentUserGuid:@" " firstCommentId:@"0" And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            
            if ([dic[Y_STATUS] integerValue]==200) {
                GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                RIZhiListModel  *tmodel = arr_model[indexPath_selected.row];
                NSMutableArray *tarr = [NSMutableArray arrayWithArray:tmodel.comment];
                [tarr insertObject:model atIndex:0];
                tmodel.comment =tarr;
                [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:tmodel];
                [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
            }
        });
    }];
    }else if ([isHuiFu2 integerValue] ==1 )
    {//回复某某
        NSString *FirstCommenteId  = nil;
        if ([model_pinglunSelected.firstCommentId integerValue]==0) {
            FirstCommenteId = model_pinglunSelected.Id;
        }else
        {
            FirstCommenteId = model_pinglunSelected.firstCommentId;
        }
        [WebRequest daily_Add_Daily_CommentWithdailyId:model.Id userGuid:user.Guid message:text parentId:model_pinglunSelected.Id parentUserGuid:model_pinglunSelected.Creater firstCommentId:FirstCommenteId And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                    RIZhiListModel  *tmodel = arr_model[indexPath_selected.row];
                    NSMutableArray *tarr = [NSMutableArray arrayWithArray:tmodel.comment];
                    [tarr insertObject:model atIndex:0];
                    tmodel.comment =tarr;
                    [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:tmodel];
                    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                }
            });
        }];
        
    }else
    {
        
    }
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}





@end
