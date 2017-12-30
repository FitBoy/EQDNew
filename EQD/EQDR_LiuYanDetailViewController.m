//
//  EQDR_LiuYanDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_LiuYanDetailViewController.h"
#import "EQDR_PingLunTableViewCell.h"
#import "EQDR_PinglunTextTableViewCell.h"
#import <Masonry.h>
#import "PPersonCardViewController.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "EQDR_JuBaoViewController.h"
@interface EQDR_LiuYanDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate,EQDR_JuBaoViewControllerdelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
    NSString *parentId;
    NSString *parentUserGuid;
    EQDR_PingLunTableViewCell  *headView;
    NSString *commentReportId;
}
@property (nonatomic,strong) YYLabel *text_ShowLabel;

@end

@implementation EQDR_LiuYanDetailViewController
-(YYLabel*)text_ShowLabel
{
    if (!_text_ShowLabel) {
        _text_ShowLabel = [[YYLabel alloc]init];
        _text_ShowLabel.font = [UIFont systemFontOfSize:16];
        _text_ShowLabel.numberOfLines =0;
        _text_ShowLabel.hidden =YES;
        _text_ShowLabel.backgroundColor = [UIColor orangeColor];
        _text_ShowLabel.textColor = [UIColor whiteColor];
        _text_ShowLabel.layer.borderColor =[UIColor greenColor].CGColor;
        _text_ShowLabel.layer.borderWidth=1;
        [tableV addSubview:_text_ShowLabel];
        
    }
    return _text_ShowLabel;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.text_ShowLabel.hidden =YES;
}
-(void)showView:(UIView*)tview text:(NSString*)text
{
    self.text_ShowLabel.hidden =NO;
    NSMutableAttributedString  *textContet = [[NSMutableAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    textContet.yy_lineSpacing =5;
    CGSize size = [textContet boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-45, (DEVICE_HEIGHT-DEVICE_TABBAR_Height-40)/2.0) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    if ([tview superview].center.y > self.view.center.y) {
        self.text_ShowLabel.frame = CGRectMake(30, [tview superview].frame.origin.y-size.height-5, DEVICE_WIDTH-40, size.height+10);
    }else
    {
      self.text_ShowLabel.frame = CGRectMake(30, [tview superview].frame.origin.y+[tview superview].frame.size.height+5, DEVICE_WIDTH-40, size.height+10);
    }

    self.text_ShowLabel.attributedText = textContet;
}
- (BOOL)prefersHomeIndicatorAutoHidden
{
    return NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Articles_Get_ChildCommentWithuserGuid:user.Guid articleId:self.model.articleId firstCommentId:self.model.Id page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_pingLunModel *model = [EQDR_pingLunModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Articles_Get_ChildCommentWithuserGuid:user.Guid articleId:self.model.articleId firstCommentId:self.model.Id page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                  page = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_pingLunModel *model = [EQDR_pingLunModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page =@"0";
    parentId=@"0";
    parentUserGuid = @" ";
    user = [WebRequest GetUserInfo];
    arr_model  =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"评论详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    commentReportId = @"0";
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"EQD_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(menuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    //头部
    headView = [[EQDR_PingLunTableViewCell alloc]init];
    UITapGestureRecognizer  *tap_head = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadClick)];
    [headView.IV_head addGestureRecognizer:tap_head];
    [headView setModel:self.model];
    UITapGestureRecognizer  *tap_liuyan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_LiuyanClick)];
    [headView.IV_liuyan addGestureRecognizer:tap_liuyan];
    
    UITapGestureRecognizer  *tap_Zan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_ZanClick)];
    [headView.IV_zan addGestureRecognizer:tap_Zan];
    NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",self.model.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    contents.yy_lineSpacing =6;
    CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    [headView.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
        make.left.mas_equalTo(headView.mas_left).mas_offset(15);
        make.right.mas_equalTo(headView.mas_right).mas_offset(-15);
        make.top.mas_equalTo(headView.V_top.mas_bottom).mas_offset(5);
    }];
    headView.frame = CGRectMake(0, 0, DEVICE_WIDTH, size.height+55);
    
    headView.YL_content.attributedText = contents;;
    headView.YL_content.textColor = [UIColor grayColor];
    tableV.tableHeaderView = headView;
}
-(void)tap_ZanClick
{
    if ([self.model.isZan integerValue]==1) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"您已经点过赞了";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
        [WebRequest Articles_Add_ArticleComment_ZanWithuserGuid:user.Guid articleCommentId:self.model.Id And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
                MBFadeAlertView *alert  =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"点赞成功"];
                headView.IV_zan.image = [UIImage imageNamed:@"zan_true"];
                headView.L_zan.text = [NSString stringWithFormat:@"%ld",[headView.L_zan.text integerValue]+1];
            }else
            {
                MBFadeAlertView *alert  =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"点赞失败，请重试"];
            }
        }];
    }
}
-(void)tap_LiuyanClick
{
    parentId = self.model.Id;
    
    parentUserGuid=self.model.userGuid;
    
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.placeHolder = [NSString stringWithFormat:@"回复%@:",self.model.upname];
    LYvc.btnName = @"发表评论";
    LYvc.delegate =self;
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:LYvc animated:NO completion:nil];
}
-(void)tapHeadClick
{
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =self.model.userGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}
-(void)menuClick
{
    //删除 回复 复制
    UIAlertController *alert = [[UIAlertController alloc]init];
//    NSArray *tarr =@[@"回复",@"复制"];
        [alert addAction:[UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //复制
            UIPasteboard  *pasted = [UIPasteboard generalPasteboard];
            pasted.string = self.model.content;
        }]];
    
    
    if ([user.Guid isEqualToString:self.model.userGuid]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [WebRequest  Articles_Delete_ArticleCommentWithuserGuid:user.Guid articleCommentId:self.model.articleId articleId:self.model.Id type:@"1" And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                    MBFadeAlertView *alert1 = [[MBFadeAlertView alloc]init];
                    [alert1 showAlertWith:@"删除成功，请刷新"];
                }else
                {
                    MBFadeAlertView *alert1 = [[MBFadeAlertView alloc]init];
                    [alert1 showAlertWith:@"删除失败，请重试"];
                }
                
            }];
            
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_pingLunModel *model =arr_model[indexPath.row];
    
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_PinglunTextTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_PinglunTextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    EQDR_pingLunModel  *model =arr_model[indexPath.row];
    NSMutableAttributedString  *all_Pinglun = [[NSMutableAttributedString alloc]initWithString:model.upname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [all_Pinglun yy_setTextHighlightRange:all_Pinglun.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        self.text_ShowLabel.hidden =YES;
        PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid =model.userGuid;
        [self.navigationController pushViewController:Pvc animated:NO];
    }];
    NSMutableAttributedString  *huifu = [[NSMutableAttributedString alloc]initWithString:@" 回复 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [all_Pinglun appendAttributedString:huifu];
    
    NSMutableAttributedString  *upName = [[NSMutableAttributedString alloc]initWithString:model.parentUPname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [upName yy_setTextHighlightRange:upName.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        PPersonCardViewController *Pvc = [[PPersonCardViewController alloc]init];
        Pvc.userGuid =model.parentUserGuid;
        [self.navigationController pushViewController:Pvc animated:NO];
    }];
    
    [all_Pinglun appendAttributedString:upName];
    
    NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@": %@\n",model.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
    [content yy_setTextHighlightRange:content.yy_rangeOfAll color:nil backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        UIAlertController *alert  = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"回复",@"复制",@"赞一个",@"举报"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i==0) {
                   //回复
                    
                    parentId = model.Id;
                    
                    parentUserGuid=model.userGuid;
                    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
                    LYvc.placeHolder = [NSString stringWithFormat:@"回复%@:",model.upname];
                    LYvc.btnName = @"发表评论";
                    LYvc.delegate =self;
                    LYvc.providesPresentationContextTransitionStyle = YES;
                    LYvc.definesPresentationContext = YES;
                    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    [self presentViewController:LYvc animated:NO completion:nil];
                }else if (i==1)
                {
                  //复制
                    UIPasteboard  *pasted = [UIPasteboard generalPasteboard];
                    pasted.string = model.content;

                }else if (i==2)
                {
                  //赞
                    if ([model.isZan integerValue]==1) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"您已经点过赞了";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });
                    }else
                    {
                        [WebRequest Articles_Add_ArticleComment_ZanWithuserGuid:user.Guid articleCommentId:model.Id And:^(NSDictionary *dic) {
                            if([dic[Y_STATUS] integerValue]==200)
                            {
                                MBFadeAlertView *alert  =[[MBFadeAlertView alloc]init];
                                [alert showAlertWith:@"点赞成功"];
                            }else
                            {
                                MBFadeAlertView *alert  =[[MBFadeAlertView alloc]init];
                                [alert showAlertWith:@"点赞失败，请重试"];
                            }
                        }];
                    }
                    
                    
                }else if (i==3)
                {
                    //举报
                    commentReportId = model.Id;
                    EQDR_JuBaoViewController  *JBvc =[[EQDR_JuBaoViewController alloc]init];
                    JBvc.type =1;
                    JBvc.delegate =self;
                    JBvc.providesPresentationContextTransitionStyle = YES;
                    JBvc.definesPresentationContext = YES;
                    JBvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    [self.navigationController presentViewController:JBvc animated:NO completion:nil];
                }else
                {
                    
                }
            }]];
            
        }
        if ([model.userGuid isEqualToString:user.Guid]) {
            [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [WebRequest Articles_Delete_ArticleCommentWithuserGuid:user.Guid articleCommentId:model.Id articleId:self.model.articleId type:@"2" And:^(NSDictionary *dic) {
                    if([dic[Y_STATUS] integerValue]==200)
                    {
                        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"删除成功"];
                        [arr_model  removeObject:model];
                        [tableV reloadData];
                    }else
                    {
                        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"删除失败"];
                    }
                }];
            }]];
            
        }
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
        
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //弹出相应的框
        [self showView:containerView text:model.firstComment];
    }];
    [all_Pinglun  appendAttributedString:content];
    
    all_Pinglun.yy_lineSpacing =6;
    CGSize  size = [all_Pinglun boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    cell.YL_content.attributedText = all_Pinglun;
    [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    model.cellHeight = size.height;
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.text_ShowLabel.hidden =YES;
}

#pragma  mark - 自定义的协议代理
-(void)getPresnetText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在评论";
    [WebRequest Articles_Add_ArtcielCommentWithuserGuid:user.Guid articleId:self.model.articleId     parentid:parentId content:text parentUserGuid:parentUserGuid firstCommentId:self.model.Id   And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        if([dic[Y_STATUS] integerValue]==200)
        {
            EQDR_pingLunModel *model = [EQDR_pingLunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [arr_model insertObject:model atIndex:0];
            [tableV reloadData];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}

#pragma  mark - 举报的协议代理
-(void)getJuBaoType:(NSString *)type text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    [WebRequest  Articles_Add_Article_Comment_ReportWithuserGuid:user.Guid articleId:self.model.articleId articleCommentId:commentReportId reason:text reportType:type And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text = @"感谢您的举报,我们会尽快处理";
        }else
        {
            hud.label.text =@"网络问题，请重试";
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}

@end
