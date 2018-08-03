//
//  RiZhi_PingLunViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RiZhi_PingLunViewController.h"
#import "GZQ_PingLunTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "PPersonCardViewController.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "RiZhi_PingLunDetailViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "RenWu_DetailModel.h"
#import "RIZhiListModel.h"
#import <Masonry.h>
#import "FBImgsScrollView.h"
//#import "FBImgShowViewController.h"
#import "FBShowimg_moreViewController.h"
#import "RIZhiListModel.h"
@interface RiZhi_PingLunViewController ()<UITableViewDelegate,UITableViewDataSource,GZQ_PingLunTableViewCellDelegate,FB_OnlyForLiuYanViewControllerDlegate,FBImgsScrollViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    GZQ_PingLunModel  *model_selected;
    NSIndexPath *indexPath_selected;
    UserModel *user;
    UIView *V_head;
    NSArray *arr_imgs;
}

@end

@implementation RiZhi_PingLunViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)loadRequestData{
    
    
    if(self.temp ==0)
    {
    [WebRequest daily_Get_Daily_CommentWithdailyId:self.dailyId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }else if (self.temp ==1)
    {
        [WebRequest WorkDynamics_MyTask_Get_Task_CommentWithtaskId:self.dailyId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
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
    [WebRequest daily_Get_Daily_CommentWithdailyId:self.dailyId page:page And:^(NSDictionary *dic) {
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
                GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }else if (self.temp==1)
    {
        [WebRequest WorkDynamics_MyTask_Get_Task_CommentWithtaskId:self.dailyId page:page And:^(NSDictionary *dic) {
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
                        GZQ_PingLunModel *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight = 60;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"评论详情";
    arr_model = [NSMutableArray arrayWithCapacity:0];
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
    tableV.tableHeaderView.userInteractionEnabled = YES;
    if(self.temp ==0)
    {
       //日志
        [WebRequest daily_Get_Daily_ByIdWithdailyId:self.dailyId userGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                RIZhiListModel  *model = [RIZhiListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                YYLabel *tlabel = [[YYLabel alloc]init];
                tlabel.numberOfLines = 0;
                [V_head addSubview:tlabel];
            
                NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@的日志\n",model.staffName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
                title.yy_alignment = NSTextAlignmentCenter;
              
               
             
                NSMutableString  *content = [NSMutableString string];
                if (model.Feeling.length>0) {
                    NSMutableString *ganwu =[NSMutableString stringWithFormat:@"#当天感悟#：\n    %@\n",model.Feeling];
                    [content appendString:ganwu];
                }
                if (model.plan.count>0) {
                    NSMutableString  *plan = [NSMutableString stringWithFormat:@"#当天计划#：\n"];
                    for (int i=0; i<model.plan.count; i++) {
                        RiZhiModel *model2 =model.plan[i];
                        [plan appendFormat:@"    %d.%@\n",i+1,model2.content];
                    }
                    [content appendString:plan];
                }
                if (model.matter.count>0) {
                    NSMutableString *matter = [NSMutableString stringWithFormat:@"#临时事项#：\n"];
                    for (int i=0; i<model.matter.count; i++) {
                        RiZhiModel *model2 =model.matter[i];
                        [matter appendFormat:@"    %d.%@\n",i+1,model2.content];
                    }
                    [content appendString:matter];
                }
                if (model.tomorrowMatter.count>0) {
                    NSMutableString *tomorrowMatter = [NSMutableString stringWithFormat:@"#明日计划#：\n"];
                    for (int i=0; i<model.tomorrowMatter.count; i++) {
                        RiZhiModel *model2 = model.tomorrowMatter[i];
                        [tomorrowMatter appendFormat:@"    %d.%@\n",i+1,model2.content];
                    }
                    [content appendString:tomorrowMatter];
                }
                
                NSMutableAttributedString  *content2 = [[NSMutableAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                [title appendAttributedString:content2];
                title.yy_lineSpacing =6;
                CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                tlabel.attributedText = title;
                V_head.frame = CGRectMake(0, 0, DEVICE_WIDTH, size.height+10);
                [tlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(size.height+5);
                    make.centerY.mas_equalTo(V_head.mas_centerY);
                    make.left.mas_equalTo(V_head.mas_left).mas_offset(15);
                    make.right.mas_equalTo(V_head.mas_right).mas_offset(-15);
                }];
                tableV.tableHeaderView =V_head;
            }
        }];
    }else if (self.temp ==1)
    {
      //任务
        [WebRequest Get_Task_InfoWithtaskId:self.dailyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                RenWu_DetailModel  *model = [RenWu_DetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                YYLabel *tlabel = [[YYLabel alloc]init];
                tlabel.numberOfLines =0;
                [V_head addSubview:tlabel];
                NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:model.TaskName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:2]}];
                title.yy_alignment = NSTextAlignmentCenter;
                NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model.TaskDesc] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                [title appendAttributedString:content];
                NSMutableAttributedString *name=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@在%@完成的结果：\n",model.RS_newRecipient.name,model.CompleteTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
                [title appendAttributedString:name];
                NSMutableAttributedString  *completeMessage = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.CompleteMessage] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                [title appendAttributedString:completeMessage];
                title.yy_lineSpacing =6;
                CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                tlabel.attributedText  =title;
                V_head.frame = CGRectMake(0, 0, DEVICE_WIDTH, size.height+10);
                tlabel.frame = CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+5);
              
                if (model.CompleteImageUrls.count>0) {
                    arr_imgs  = model.CompleteImageUrls;
                    FBImgsScrollView *ISV = [[FBImgsScrollView alloc]init];
                    [V_head addSubview:ISV];
                    float width = (DEVICE_WIDTH -30-20)/3.0;
                    [ISV setArr_stringImgs:model.CompleteImageUrls Withsize:CGSizeMake(width, width)];
                    ISV.delegate_imgviews =self;
                    V_head.frame = CGRectMake(0, 0, DEVICE_WIDTH, size.height+10+width+15);
                    ISV.frame = CGRectMake(15, size.height+15, DEVICE_WIDTH-30, width+5);
               
                }
                tableV.tableHeaderView =V_head;
            }
        }];
    }else
    {
        
    }
    [self loadRequestData];
}
#pragma  mark - 滚动图片的delegate
-(void)getImgsScrollViewSelectedViewWithtag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath
{
    FBShowimg_moreViewController  *SMvc =[[FBShowimg_moreViewController alloc]init];
    SMvc.arr_imgs = arr_imgs;
    SMvc.index = tag;
    [self.navigationController pushViewController:SMvc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZQ_PingLunModel *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    GZQ_PingLunTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GZQ_PingLunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    GZQ_PingLunModel  *model =arr_model[indexPath.row];
    model.indexpath_cell =indexPath;
    [cell setModel2:model];
    cell.delegate_pinglun = self;
    ///头像
    FBindexTapGestureRecognizer *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick:)];
    tap_head.indexPath =indexPath;
    [cell.IV_head addGestureRecognizer:tap_head];
    ///留言
    FBindexTapGestureRecognizer *tap_liuyan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick:)];
    tap_liuyan.indexPath =indexPath;
    [cell.IV_liuyan addGestureRecognizer:tap_liuyan];
    
    ///点击大内容进行回复
    FBindexTapGestureRecognizer *tap_lliuyan2 = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick:)];
    tap_lliuyan2.indexPath = indexPath;
    [cell.L_contents addGestureRecognizer:tap_lliuyan2];
    
    ///长按内容删除
    FBindexpathLongPressGestureRecognizer *longpress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(liuyan_Longpress:)];
    longpress.indexPath = indexPath;
    [cell.L_contents addGestureRecognizer:longpress];
    
    
    
    return cell;
}

-(void)liuyan_Longpress:(FBindexpathLongPressGestureRecognizer*)longPress{
   
    GZQ_PingLunModel *model = arr_model[longPress.indexPath.row];
    if ([model.Creater isEqualToString:user.Guid]) {
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        if(self.temp ==0)
        {
        [WebRequest daily_Delete_DailyCommentWithuserGuid:user.Guid commentId:model.Id type:@"1" And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue] == 200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }
            });
        }];
        }else if (self.temp ==1 )
        {
            //任务
            [WebRequest WorkDynamics_MyTask_Delete_Task_CommentWithuserGuid:user.Guid commentId:model.Id type:@"1" And:^(NSDictionary *dic) {
                hud.label.text = dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue] == 200) {
                        [arr_model removeObject:model];
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
    
}

-(void)getPinglunModel:(GZQ_PingLunModel *)model_pinglun Withtemp:(NSInteger)temp
{
    if (temp==0) {
        ///前面人的名字
        PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid = model_pinglun.Creater;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (temp ==1)
    {
        //后面人的名字
        PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid = model_pinglun.parentUserGuid;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (temp ==2)
    {
        //点击文本内容
        indexPath_selected = model_pinglun.indexpath_cell;
        model_selected = model_pinglun;
        FB_OnlyForLiuYanViewController *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
        LYvc.delegate =self;
        LYvc.btnName = @"发送";
        LYvc.providesPresentationContextTransitionStyle = YES;
        LYvc.definesPresentationContext = YES;
        LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        LYvc.placeHolder = [NSString stringWithFormat:@"回复%@:",model_pinglun.createName];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:LYvc animated:NO completion:nil];
        });
        
    }else if (temp ==3)
    {
        ///点击查看更多
       
        RiZhi_PingLunDetailViewController  *Dvc = [[RiZhi_PingLunDetailViewController alloc]init];
        
            Dvc.temp =self.temp;
        Dvc.model = model_pinglun;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else if (temp ==12)
    {
       // 长按
        if ([model_pinglun.Creater isEqualToString:user.Guid]) {

        UIAlertController  *alert = [[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            if (self.temp==0) {
            [WebRequest daily_Delete_DailyCommentWithuserGuid:user.Guid commentId:model_pinglun.Id type:@"2" And:^(NSDictionary *dic) {
                hud.label.text = dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        GZQ_PingLunModel  *model = arr_model[model_pinglun.indexpath_cell.row];
                        NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.childList];
                        [tarr removeObject:model_pinglun];
                        model.childList =tarr;
                        [arr_model replaceObjectAtIndex:model_pinglun.indexpath_cell.row withObject:model];
                        [tableV reloadData];
                    }
                });
            }];
            }else if (self.temp ==1)
            {
                //任务
                [WebRequest WorkDynamics_MyTask_Delete_Task_CommentWithuserGuid:user.Guid commentId:model_pinglun.Id type:@"2" And:^(NSDictionary *dic) {
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        GZQ_PingLunModel  *model = arr_model[model_pinglun.indexpath_cell.row];
                        NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.childList];
                        [tarr removeObject:model_pinglun];
                        model.childList =tarr;
                        [arr_model replaceObjectAtIndex:model_pinglun.indexpath_cell.row withObject:model];
                        [tableV reloadData];
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
    }else
    {
        
    }
}
#pragma  mark - 留言
-(void)tap_liuyanClick:(FBindexTapGestureRecognizer*)tap{
    indexPath_selected = tap.indexPath;
    GZQ_PingLunModel *model = arr_model[tap.indexPath.row];
    model_selected = model;
    FB_OnlyForLiuYanViewController *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.delegate =self;
    LYvc.btnName = @"发送";
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.placeHolder = [NSString stringWithFormat:@"回复%@:",model.createName];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:LYvc animated:NO completion:nil];
    });
    
}
#pragma  mark - 留言的内容
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
    [WebRequest daily_Add_Daily_CommentWithdailyId:self.dailyId userGuid:user.Guid message:text parentId:model_selected.Id parentUserGuid:model_selected.Creater firstCommentId:FirstCommentId And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                GZQ_PingLunModel  *model1 = arr_model[indexPath_selected.row];
                GZQ_PingLunModel *model2 = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                NSMutableArray *tarr = [NSMutableArray arrayWithArray:model1.childList];
                [tarr insertObject:model2 atIndex:0];
                model1.childList = tarr;
                [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model1];
                [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
            }
        });
    }];
    }else if (self.temp ==1)
    {
        [WebRequest WorkDynamics_MyTask_Add_Task_CommentWithtaskId:self.dailyId userGuid:user.Guid message:text parentId:model_selected.Id parentUserGuid:model_selected.Creater firstCommentId:FirstCommentId And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    GZQ_PingLunModel  *model1 = arr_model[indexPath_selected.row];
                    GZQ_PingLunModel *model2 = [GZQ_PingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                    NSMutableArray *tarr = [NSMutableArray arrayWithArray:model1.childList];
                    [tarr insertObject:model2 atIndex:0];
                    model1.childList = tarr;
                    [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model1];
                    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
                }
            });
        }];
    }else
    {
        
    }
}
#pragma  mark - 点击头像
-(void)tap_headClick:(FBindexTapGestureRecognizer*)tap{
    GZQ_PingLunModel *model = arr_model[tap.indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid = model.Creater;
    [self.navigationController pushViewController:Pvc animated:NO];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}




@end
