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
@interface GZQ_PingLunViewController ()<UITableViewDelegate,UITableViewDataSource,GZQ_PingLunTableViewCellDelegate,UITextFieldDelegate>
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
}

@end

@implementation GZQ_PingLunViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
   
    [WebRequest Get_Comment_ByWorkCircleIdWithworkCircleId:self.model.Id ID:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_pinglun removeAllObjects];
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    GZQ_PingLunModel *model =[GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                    [arr_pinglun addObject:model];
                    if (i==tarr.count-1) {
                        ID_selected =model.Id;
                    }
                }
            }
           
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });

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
    
    
    
    [WebRequest Get_Comment_ByWorkCircleIdWithworkCircleId:self.model.Id ID:ID_selected And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else{
                for (int i=0; i<tarr.count; i++) {
                    GZQ_PingLunModel *model =[GZQ_PingLunModel mj_objectWithKeyValues:tarr[i]];
                    [arr_pinglun addObject:model];
                    if (i==tarr.count-1) {
                        ID_selected =model.Id;
                    }
                }
            }
                [tableV reloadData];
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
    self.navigationItem.title = @"说说详情";
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
-(void)fasongClick
{
    [self.view endEditing:YES];
    //发送
        TF_text.placeholder=@"我也说一句……";
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在评论";
   
    
    [WebRequest Add_WorkCircle_CommentWithcompanyId:user.companyId userGuid:user.Guid message:TF_text.text workCircleId:self.model.Id parentId:ID_huifu And:^(NSDictionary *dic) {
        
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
         hud.label.text =@"评论成功";
            if ([ID_huifu integerValue]!=0) {
               [WebRequest Get_Comment_ByIdWithcommentId:ID_big And:^(NSDictionary *dic) {
                   if ([dic[Y_STATUS] integerValue]==200) {
                   NSDictionary *dic2 =dic[Y_ITEMS];
                   GZQ_PingLunModel *model2 =[GZQ_PingLunModel mj_objectWithKeyValues:dic2];
                   [arr_pinglun replaceObjectAtIndex:indexpath_selected.row withObject:model2];
                   [tableV reloadRowsAtIndexPaths:@[indexpath_selected] withRowAnimation:UITableViewRowAnimationNone];
                   }
               }];
            }
            else
            {
                [self loadRequestData];
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
   
     CGSize size =[model.Message boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-73, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    NSMutableParagraphStyle *para =[[NSMutableParagraphStyle alloc]init];
    para.lineSpacing=6;
    NSMutableAttributedString *text =[[NSMutableAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:para}];
    if (model.children.count) {
        for (int i=0; i<model.children.count; i++) {
            GZQ_PingLunModel *model2 =model.children[i];
            [ text appendAttributedString:[self getstringWithmodel:model2]];
        }
        CGSize size2 =[text boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-73, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        return 70+size.height+size2.height;

    }
    else
    {
        return 70+size.height;
    }
    
   
    }

-(NSMutableAttributedString*)getstringWithmodel:(GZQ_PingLunModel*)model
{
    NSMutableParagraphStyle *para =[[NSMutableParagraphStyle alloc]init];
    para.lineSpacing=6;
    NSMutableAttributedString *tstr =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@回复%@%@\n",model.beforeName,model.staffName,model.Message] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:para}];
    
    ///获取所有子评论的内容
    if (model.children.count) {
        for (int i=0; i<model.children.count; i++) {
            GZQ_PingLunModel *model2 =model.children[i];
            [tstr appendAttributedString:[self getstringWithmodel:model2]];
        }
    }
    return tstr;
    
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
    cell.indexPath =indexPath;
    [cell setModel:model];
    cell.delegate=self;
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
    
    indexpath_selected =[NSIndexPath indexPathForRow:tap.index inSection:0];
    ID_huifu =model.Id;
    ID_big =model.Id;
    [TF_text becomeFirstResponder];
    
}
-(void)getContentId:(NSString *)contentId userGuid:(NSString *)userGuid name:(NSString *)name  thismodelId:(NSString *)thisModelId indexpath:(NSIndexPath *)indexpath
{
    ID_big =thisModelId;
    indexpath_selected =indexpath;
    
    //评论
    ID_huifu =contentId;
        [TF_text  becomeFirstResponder];
        TF_text.placeholder=[NSString stringWithFormat:@"回复%@:",name];
    
}
-(void)getuserGuid:(NSString *)userGuid
{
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid=userGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}
-(void)getOtherGuid:(NSString *)otherGuid
{
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid=otherGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
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
