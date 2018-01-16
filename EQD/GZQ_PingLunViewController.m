//
//  GZQ_PingLunViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GZQ_PingLunViewController.h"
#import "GZQ_PingLunModel.h"
#import "GZQ_PingLunTableViewCell.h"
#import "PPersonCardViewController.h"
#import "FBButton.h"
#import "FBindexTapGestureRecognizer.h"
#import "UITextField+Tool.h"
#import "GZQ_top_DetailView.h"
#import "PPersonCardViewController.h"
#import "FBImgShowViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "GZQ_ZanViewController.h"
#import <Masonry.h>
@interface GZQ_PingLunViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableV;
    NSString *ID_selected;
    NSMutableArray *arr_pinglun;
    UIView *V_bottom;
    UITextField *TF_text;
    FBButton *B_fasong;
    NSString *ID_huifu;
    UserModel *user;
    NSString *ID_big;
    NSIndexPath *indexpath_selected;
    GZQ_top_DetailView *view_top;
    NSString *parentUserGuid;
    NSString *firstCommentId;
    NSString *page;
}

@end

@implementation GZQ_PingLunViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    
    [WebRequest Get_WorkCircleCommentWithworkcircleId:self.model.Id page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_pinglun removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            page =tdic[@"page"];
            NSArray *tarr =tdic[@"rows"];
            for (int i=0; i<tarr.count; i++) {
                GZQ_PingLunModel  *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                [arr_pinglun addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
    
   
 
    /// 获取说说详情
    
    [WebRequest Get_WorkCircle_ByIdWithworkCircleId:self.model.Id userGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            GongZuoQunModel *model2 =[GongZuoQunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [view_top setModel:model2];
        }
        
    }];
    
    
}
-(void)loadOtherData
{
    
    [WebRequest Get_WorkCircleCommentWithworkcircleId:self.model.Id page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            page =tdic[@"page"];
            NSArray *tarr =tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                GZQ_PingLunModel  *model = [GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                [arr_pinglun addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    
 
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ID_selected=@"0";
    self.navigationItem.title = @"详情";
    user =[WebRequest GetUserInfo];
    arr_pinglun=[NSMutableArray arrayWithCapacity:0];
    
    ID_huifu =@"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    V_bottom =[[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-40, DEVICE_WIDTH, 40)];
    [self.view addSubview:V_bottom];
    V_bottom.backgroundColor =[UIColor lightGrayColor];
    V_bottom.userInteractionEnabled=YES;
    TF_text =[[UITextField alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-100, 30)];
    TF_text.borderStyle = UITextBorderStyleRoundedRect;
    [V_bottom addSubview:TF_text];
    TF_text.placeholder=@"我也说一句……";
    B_fasong =[FBButton buttonWithType:UIButtonTypeSystem];
    [V_bottom addSubview:B_fasong];
    B_fasong.frame =CGRectMake(DEVICE_WIDTH-75, 5, 60, 30);
    
    [B_fasong setTitle:@"发送" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [B_fasong addTarget:self action:@selector(fasongClick) forControlEvents:UIControlEventTouchUpInside];
    
    TF_text.delegate =self;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [TF_text setTextFieldInputAccessoryView];
    
    // 键盘将出现事件监听
    [center addObserver:self selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    // 键盘将隐藏事件监听
    [center addObserver:self selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
    
    view_top =[[GZQ_top_DetailView alloc]init];
    [view_top setModel:self.model];
    tableV.tableHeaderView=view_top;
    //添加头像点击事件
    view_top.frame=CGRectMake(0, 64, DEVICE_WIDTH, view_top.height_view);
    FBindexTapGestureRecognizer *tap_head =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick)];
    [view_top.IV_head addGestureRecognizer:tap_head];
    
    FBindexTapGestureRecognizer *tap_name =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick)];
    [view_top.L_name addGestureRecognizer:tap_name];
    
    ///是否显示删除按钮
    if([self.model.Creater isEqualToString:user.Guid])
    {
        FBindexTapGestureRecognizer *tap_delete =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_deleteClick)];
        [view_top.IV_zhuanfa addGestureRecognizer:tap_delete];
        view_top.IV_zhuanfa.alpha=1;
    }
    else
    {
        view_top.IV_zhuanfa.alpha=0;
    }
    ///为图片添加点击事件
    for(int i=0;i<view_top.arr_imgs.count;i++)
    {
        FBindexTapGestureRecognizer  *tap_img =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_imgClick:)];
        tap_img.index =i;
        UIImageView *IV_img =view_top.arr_imgs[i];
        [IV_img addGestureRecognizer:tap_img];
    }
    //点赞
    FBindexTapGestureRecognizer *tap_zan =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanClick)];
    [view_top.IV_zan addGestureRecognizer:tap_zan];
    
    ///留言
    FBindexTapGestureRecognizer *tap_liuyan =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick)];
    [view_top.IV_liuyan addGestureRecognizer:tap_liuyan];
    
    
    ///给点赞的人增加点击事件
    FBindexTapGestureRecognizer  *tap_zan1 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    [view_top.IV_zan1 addGestureRecognizer:tap_zan1];
    
    FBindexTapGestureRecognizer  *tap_zan2 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    [view_top.IV_zan2 addGestureRecognizer:tap_zan2];
    
    FBindexTapGestureRecognizer  *tap_zan3 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    [view_top.IV_zan3 addGestureRecognizer:tap_zan3];
    FBindexTapGestureRecognizer  *tap_zan4 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    [view_top.IV_zan4 addGestureRecognizer:tap_zan4];
     [self loadRequestData];
    
}
-(void)zanCLickcell:(FBindexTapGestureRecognizer*)tap
{
    ///进去点赞人的列表
    GZQ_ZanViewController *Zvc =[[GZQ_ZanViewController alloc]init];
    Zvc.cell_id =self.model.Id;
   
    [self.navigationController pushViewController:Zvc animated:NO];
    
}
///给说说留言
-(void)tap_liuyanClick
{
    [TF_text becomeFirstResponder];
    ID_huifu=@"0";
    parentUserGuid =@" ";
    firstCommentId = @"0";
   
}
-(void)tap_zanClick
{
    //点赞
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
   
    [WebRequest Add_WorkCircle_ZanWithcompanyId:user.companyId userGuid:user.Guid workCircleId:self.model.Id And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            hud.label.text =@"点赞成功";
            ///获取内容的详情 用请求
      [view_top updateZan_numWithuserphoto:user.iphoto Andmodel:self.model];
            if ([self.delegate respondsToSelector:@selector(zanwithIndexPath:)]) {
                [self.delegate zanwithIndexPath:self.indexPath];
            }
        }
        else
        {
            hud.label.text=@"服务器错误";
        }
      
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
}
-(void)tap_imgClick:(FBindexTapGestureRecognizer*)tap
{
    FBImgShowViewController *Svc =[[FBImgShowViewController alloc]init];
    Svc.imgstrs=self.model.imgurls;
    Svc.selected=tap.index;
    [self.navigationController pushViewController:Svc animated:NO];
    
}
-(void)tap_deleteClick
{
    //删除说说
    if ([self.delegate respondsToSelector:@selector(deleteModelWithindexpath:)]) {
        [self.delegate deleteModelWithindexpath:self.indexPath];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)tap_headClick
{
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =self.model.Creater;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}
#pragma  mark - 发送
-(void)fasongClick
{
    [self.view endEditing:YES];
    //发送
        TF_text.placeholder=@"我也说一句……";
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在评论";
   
    
    [WebRequest Add_WorkCircle_CommentWithcompanyId:user.companyId userGuid:user.Guid message:TF_text.text workCircleId:self.model.Id parentId:ID_huifu parentUserGuid:parentUserGuid firstCommentId:firstCommentId And:^(NSDictionary *dic) {
        
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
         hud.label.text =@"评论成功";
            if ([ID_huifu integerValue]!=0) {
            
            }
            else
            {
//                [self loadRequestData];
            }
            [view_top updateliuyan];
            if([self.delegate respondsToSelector:@selector(liuyanWithIndexpath:Withnumber:)])
            {
                [self.delegate liuyanWithIndexpath:self.indexPath Withnumber:view_top.L_liuyan.text];
            }
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ID_huifu=@"0";
        TF_text.text =nil;
        [hud hideAnimated:NO];
    });
}
//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    CGRect  rect =V_bottom.frame;
    rect.origin.y = DEVICE_HEIGHT-40-height;
    V_bottom.frame =rect;
    
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    V_bottom.frame =CGRectMake(0, DEVICE_HEIGHT-40, DEVICE_WIDTH, 40);
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    return YES;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZQ_PingLunModel *model =arr_pinglun[indexPath.row];
    return model.cellHeight;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_pinglun.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GZQ_PingLunModel *model =arr_pinglun[indexPath.row];
    static NSString *cellId=@"cellID";
    GZQ_PingLunTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GZQ_PingLunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    [cell setModel:model];
    float  height_cell = 50;
    CGSize size =[model.Message boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:16]} context:nil].size;
    [cell.L_contents mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.left.mas_equalTo(cell.IV_head.mas_right).mas_offset(5);
        make.right.mas_equalTo(cell.V_bg.mas_right);
        make.top.mas_equalTo(cell.V_top.mas_bottom).mas_offset(5);
    }];
    height_cell = 50+size.height+15;
    if ([model.commentCount  integerValue]==0) {
        cell.yyL_fuwenben.attributedText =nil;
        cell.L_more.hidden = YES;
        cell.yyL_fuwenben.frame = CGRectZero;
        model.cellHeight = height_cell;
    }else
    {
    NSMutableAttributedString *pinglunMore = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    for (int i=0; i<model.list.count; i++) {
        GZQ_PingLunModel *model2 = model.list[i];
        NSMutableAttributedString  *staffName = [[NSMutableAttributedString alloc]initWithString:model2.staffName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [staffName yy_setTextHighlightRange:staffName.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            //名字点击事件
            PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
            Pvc.userGuid = model2.Creater;
            [self.navigationController pushViewController:Pvc animated:NO];
        }];
        [pinglunMore appendAttributedString:staffName];
        NSMutableAttributedString *huifu = [[NSMutableAttributedString alloc]initWithString:@"回复" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [pinglunMore appendAttributedString:huifu];
        NSMutableAttributedString *parentUPname = [[NSMutableAttributedString alloc]initWithString:model2.parentUPname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [parentUPname yy_setTextHighlightRange:parentUPname.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
         //第二个名字的点击事件
            PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
            Pvc.userGuid = model2.parentUserGuid;
            [self.navigationController pushViewController:Pvc animated:NO];
        }];
        [pinglunMore appendAttributedString:parentUPname];
        NSMutableAttributedString *Message = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@\n",model2.Message] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                                                                                                                                                            
    [Message yy_setTextHighlightRange:Message.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] userInfo:@{} tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            //消息的点击事件
        [self getContentId:model2.Id userGuid:model2.Creater name:model2.staffName thismodelId:model.Id indexpath:indexPath];
        
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           //消息的长按事件
            [self getmessage:model2.Message contentId:model2.Id creater:model2.Creater thismodelId:model.Id indexPath:indexPath];
            
        }];
        [pinglunMore appendAttributedString:Message];
        
    }
        pinglunMore.yy_lineSpacing=6;
    CGSize sizepinglun = [pinglunMore boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    height_cell = height_cell+sizepinglun.height+10;
        
    cell.yyL_fuwenben.attributedText = pinglunMore;
        [cell.yyL_fuwenben mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(sizepinglun.height+5);
            make.left.mas_equalTo(cell.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.top.mas_equalTo(cell.L_contents.mas_bottom).mas_offset(5);
        }];
        
    if ([model.commentCount integerValue]>3) {
        cell.L_more.hidden=NO;
        [cell.L_more mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 20));
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(cell.mas_bottom).mas_offset(5);
        }];
        height_cell = height_cell+30;
       
    }else
    {
        cell.L_more.hidden =YES;
    }
        model.cellHeight = height_cell;
    }
    
    
    FBindexTapGestureRecognizer *tap_liuyan =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapliuyanClcik:)];
    tap_liuyan.index =indexPath.row;
    [cell.IV_liuyan addGestureRecognizer:tap_liuyan];
    
    ///评论长按删除
    FBindexpathLongPressGestureRecognizer *longPress_cell =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress_cellClick:)];
    longPress_cell.indexPath =indexPath;
    [cell.L_contents addGestureRecognizer:longPress_cell];
    ///头像与名字点击进个人名片
    FBindexTapGestureRecognizer *tap_head =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(headClickcell:)];
    tap_head.index =indexPath.row;
    [cell.IV_head addGestureRecognizer:tap_head];
    FBindexTapGestureRecognizer *tap_name =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(headClickcell:)];
    tap_name.index =indexPath.row;
    [cell.L_name addGestureRecognizer:tap_name];
    return cell;
}
-(void)headClickcell:(FBindexTapGestureRecognizer*)tap
{
    GZQ_PingLunModel *model =arr_pinglun[tap.index];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.Creater;
    [self.navigationController pushViewController:Pvc animated:NO];
}
///长按cell的操作
-(void)longPress_cellClick:(FBindexpathLongPressGestureRecognizer*)longPress
{
    GZQ_PingLunModel *model =arr_pinglun[longPress.indexPath.row];
    UIAlertController *alert =[[UIAlertController alloc]init];
    if ([user.Guid isEqualToString:model.Creater]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
                [WebRequest Delete_CommentWithuserGuid:user.Guid commentId:model.Id And:^(NSDictionary *dic) {
                    if([dic[Y_STATUS] integerValue]==200)
                    {
                        [view_top updateliuyan2];
                        if ([self.delegate respondsToSelector:@selector(liuyanWithIndexpath:Withnumber:)]) {
                            [self.delegate liuyanWithIndexpath:self.indexPath Withnumber:view_top.L_liuyan.text];
                        }
                        [arr_pinglun removeObject:model];
                        [tableV reloadData];
                    }
                }];
            
            
        }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UIPasteboard generalPasteboard].string =model.Message;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    }else
    {
    }
    
}


-(void)tapliuyanClcik:(FBindexTapGestureRecognizer*)tap
{
    GZQ_PingLunModel *model =arr_pinglun[tap.index];
    parentUserGuid = model.Creater;
    firstCommentId = model.Id;
    indexpath_selected =[NSIndexPath indexPathForRow:tap.index inSection:0];
    ID_huifu =model.Id;
    ID_big =model.Id;
    firstCommentId = model.Id;
    parentUserGuid = model.Creater;
    [TF_text becomeFirstResponder];
    
}
-(void)getContentId:(NSString *)contentId userGuid:(NSString *)userGuid name:(NSString *)name  thismodelId:(NSString *)thisModelId indexpath:(NSIndexPath *)indexpath
{
    ID_big =thisModelId;
    indexpath_selected =indexpath;
    
    //评论
    ID_huifu =contentId;
    parentUserGuid = userGuid;
    firstCommentId =contentId;
        [TF_text  becomeFirstResponder];
        TF_text.placeholder=[NSString stringWithFormat:@"回复%@:",name];
    
}

///长按 内容的操作
-(void)getmessage:(NSString *)message contentId:(NSString *)contentId creater:(NSString *)creater thismodelId:(NSString *)bigModelId indexPath:(NSIndexPath *)indexPath
{
    //删除子评论
     UIAlertController *alert =[[UIAlertController alloc]init];
    
    if ([user.Guid isEqualToString:self.model.Creater]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                [WebRequest Delete_CommentWithuserGuid:user.Guid commentId:contentId And:^(NSDictionary *dic) {
                    if([dic[Y_STATUS] integerValue]==200)
                    {
                        [WebRequest Get_Comment_ByIdWithcommentId:bigModelId And:^(NSDictionary *dic) {
                            NSDictionary *dic2 =dic[Y_ITEMS];
                            GZQ_PingLunModel *model2 =[GZQ_PingLunModel mj_objectWithKeyValues:dic2];
                            [arr_pinglun replaceObjectAtIndex:indexPath.row withObject:model2];
                            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        }];
                    }
                }];
            
        }]];
        
    }
    else
    {
      if([user.Guid isEqualToString:creater])
      {
          [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
              
              [WebRequest Delete_CommentWithuserGuid:user.Guid commentId:contentId And:^(NSDictionary *dic) {
                  if([dic[Y_STATUS] integerValue]==200)
                  {
                      [WebRequest Get_Comment_ByIdWithcommentId:bigModelId And:^(NSDictionary *dic) {
                          NSDictionary *dic2 =dic[Y_ITEMS];
                          GZQ_PingLunModel *model2 =[GZQ_PingLunModel mj_objectWithKeyValues:dic2];
                          [arr_pinglun replaceObjectAtIndex:indexPath.row withObject:model2];
                          [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                      }];
                  }
              }];
              
              
          }]];
      }
        else
        {
            
        }
        
        
    }
   
    [alert addAction:[UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UIPasteboard generalPasteboard].string =message;
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [self presentViewController:alert animated:NO completion:nil];
}



@end
