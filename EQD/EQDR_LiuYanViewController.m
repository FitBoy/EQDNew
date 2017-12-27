//
//  EQDR_LiuYanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_LiuYanViewController.h"
#import "FBTextField.h"
#import "FBButton.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "EQDR_PingLunTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import <Masonry.h>
#import "PPersonCardViewController.h"
#import "EQDR_LiuYanDetailViewController.h"
@interface EQDR_LiuYanViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    UILabel  *L_liuyan;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
    NSString *parentId;
    NSString *firstCommentId;
    NSString *parentUserGuid;
}
@property (nonatomic,strong)  UILabel *textView_show;

@end

@implementation EQDR_LiuYanViewController
-(UILabel*)textView_show
{
    if (!_textView_show) {
        _textView_show = [[UILabel alloc]init];
        _textView_show.hidden= YES;
        _textView_show.numberOfLines =0;
        _textView_show.font = [UIFont systemFontOfSize:16];
        _textView_show.layer.borderColor = [UIColor greenColor].CGColor;
        _textView_show.layer.borderWidth = 1;
        _textView_show.backgroundColor = [UIColor orangeColor];
        _textView_show.textColor = [UIColor whiteColor];
        _textView_show.textAlignment = NSTextAlignmentCenter;
     
        
    }
    return _textView_show;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}

-(void)loadRequestData{
    
    [WebRequest  Articles_Get_ArticleCommentWitharticleId:self.articleId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            page =tdic [@"page"];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                EQDR_pingLunModel *model =[EQDR_pingLunModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
          
            [tableV reloadData];
            }
        }
    }];
    
}
-(void)loadOtherData
{
    [WebRequest  Articles_Get_ArticleCommentWitharticleId:self.articleId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            page =tdic [@"page"];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                EQDR_pingLunModel *model =[EQDR_pingLunModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                  [tableV reloadData];
            }
          
        }
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.textView_show.hidden =YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = [NSString stringWithFormat:@"%@条评论",self.commentCount];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    L_liuyan = [[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-40, DEVICE_WIDTH, 40)];
    [self.view addSubview:L_liuyan];
    L_liuyan.text =@" 我要给文章评论";
    L_liuyan.textColor = [UIColor grayColor];
    L_liuyan.userInteractionEnabled =YES;
    L_liuyan.layer.borderColor=[UIColor darkGrayColor].CGColor;
    L_liuyan.layer.borderWidth =1;
    UITapGestureRecognizer  *tap_liuyan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liuyanCLick)];
    [L_liuyan addGestureRecognizer:tap_liuyan];
    parentId =@"0";
    firstCommentId=@"0";
    parentUserGuid=@" ";
}
-(void)liuyanCLick
{
 //留言
    parentId =@"0";
    firstCommentId=@"0";
    parentUserGuid=@" ";
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.placeHolder = [NSString stringWithFormat:@"给文章评论"];
    LYvc.btnName = @"发表评论";
    LYvc.delegate =self;
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:LYvc animated:NO completion:nil];
    
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_pingLunModel  *model = arr_model[indexPath.row];
    return model.cellHeight;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(void)tap_head2Click:(FBindexTapGestureRecognizer*)tap
{
    EQDR_pingLunModel *model =arr_model[tap.indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.userGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_PingLunTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_PingLunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    EQDR_pingLunModel  *model =arr_model[indexPath.row];
    //头像
    FBindexTapGestureRecognizer *tap_head2 = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head2Click:)];
    tap_head2.indexPath = indexPath;
    
    [cell.IV_head addGestureRecognizer:tap_head2];
    
    //名字
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:model.upname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name yy_setTextHighlightRange:name.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid =model.userGuid;
        [self.navigationController pushViewController:Pvc animated:NO];
    }];
    cell.YL_name.attributedText = name;
    FBindexTapGestureRecognizer *tap_liuyan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick:)];
    tap_liuyan.indexPath = indexPath;
    [cell.IV_liuyan addGestureRecognizer:tap_liuyan];
    FBindexTapGestureRecognizer  *tap_zan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_zanClick:)];
    tap_zan.indexPath =indexPath;
    [cell.IV_zan addGestureRecognizer:tap_zan];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
  
    [content yy_setTextHighlightRange:content.yy_rangeOfAll color:[UIColor grayColor] backgroundColor:[UIColor darkGrayColor] userInfo:@{} tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //点击回复
        self.textView_show.hidden =YES;
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr =@[@"回复",@"复制",@"赞一个",@"查看详情",@"举报"];
        for(int i=0;i<tarr.count;i++)
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i==0) {
                    //回复
                    parentId = model.Id;
                    firstCommentId=model.Id;
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
                                cell.IV_zan.image = [UIImage imageNamed:@"zan_true"];
                                
                            }else
                            {
                                MBFadeAlertView *alert  =[[MBFadeAlertView alloc]init];
                                [alert showAlertWith:@"点赞失败，请重试"];
                            }
                        }];
                    }
                    
                }else if (i==3)
                {
                    //查看详情
                    
                    EQDR_LiuYanDetailViewController  *Dvc = [[EQDR_LiuYanDetailViewController alloc]init];
                    Dvc.model =model;
                    [self.navigationController pushViewController:Dvc animated:NO];
                }else if (i==4)
                {
                    //举报
                }else
                {
                    
                }
            }]];
        }
       
        if([model.userGuid isEqualToString:user.Guid])
        {
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [WebRequest Articles_Delete_ArticleCommentWithuserGuid:user.Guid articleCommentId:model.Id articleId:self.articleId type:@"1" And:^(NSDictionary *dic) {
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
        }else
        {
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
        
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //长按 弹出上级评论的view
        
    }];
    content.yy_lineSpacing =6;
    CGSize  size_content = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size_content.height+5);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.top.mas_equalTo(cell.V_top.mas_bottom).mas_offset(5);
    }];
    cell.YL_content.attributedText = content;
    
  
    
    if (model.arr_muList.count==0) {
        cell.YL_pinglunContent.hidden = YES;
        model.cellHeight = 65+size_content.height;
    }else
    {
        cell.YL_pinglunContent.hidden=NO;
        NSMutableAttributedString * all_pinglun = [[NSMutableAttributedString alloc]initWithString:@""];
        
        for (int i=0; i<model.arr_muList.count; i++) {
            if (i==3) {
                break;
            }
            EQDR_pingLunModel  *model2 =[EQDR_pingLunModel mj_objectWithKeyValues:model.arr_muList[i]];
            NSMutableAttributedString  *upname = [[NSMutableAttributedString alloc]initWithString:model2.upname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [upname yy_setTextHighlightRange:upname.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
              //第一个名字的点击事件
                self.textView_show.hidden =YES;
                PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
                Pvc.userGuid =model2.userGuid;
                [self.navigationController pushViewController:Pvc animated:NO];
                
            }];
            [all_pinglun appendAttributedString:upname];
            NSMutableAttributedString *huifu = [[NSMutableAttributedString alloc]initWithString:@" 回复 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [all_pinglun appendAttributedString:huifu];
            
            NSMutableAttributedString *parentUpname = [[NSMutableAttributedString alloc]initWithString:model2.parentUPname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [parentUpname  yy_setTextHighlightRange:parentUpname.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
               //点击事件
                self.textView_show.hidden =YES;
                PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
                Pvc.userGuid =model2.parentUserGuid;
                [self.navigationController pushViewController:Pvc animated:NO];
            }];
            [all_pinglun appendAttributedString:parentUpname];
            NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@": %@\n",model2.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [content yy_setTextHighlightRange:content.yy_rangeOfAll color:[UIColor grayColor] backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                self.textView_show.hidden =YES;
                UIAlertController  *alert = [[UIAlertController alloc]init];
                NSArray *tarr =@[@"回复",@"复制",@"赞一个",@"查看详情",@"举报"];
                for(int i=0;i<tarr.count;i++)
                {
                    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (i==0) {
                            //回复
                            parentId = model2.Id;
                            firstCommentId=model.Id;
                            parentUserGuid=model2.userGuid;
                            FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
                            LYvc.placeHolder = [NSString stringWithFormat:@"回复%@:",model2.upname];
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
                            pasted.string = model2.content;
                        }else if (i==2)
                        {
                            //赞
                            if ([model2.isZan integerValue]==1) {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.label.text =@"您已经点过赞了";
                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                                });
                            }else
                            {
                                [WebRequest Articles_Add_ArticleComment_ZanWithuserGuid:user.Guid articleCommentId:model2.Id And:^(NSDictionary *dic) {
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
                            //查看详情
                            EQDR_LiuYanDetailViewController  *Dvc = [[EQDR_LiuYanDetailViewController alloc]init];
                            Dvc.model =model;
                            [self.navigationController pushViewController:Dvc animated:NO];
                            
                        }else if (i==4)
                        {
                            //举报
                        }else
                        {
                            
                        }
                    }]];
                }
                
               
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:NO completion:nil];
            } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                ///弹出上级的view
                [self showTextViewWithrect:rect  text:model2.firstComment  tview:containerView];
                
            }];
            [all_pinglun appendAttributedString:content];
           
        }
        
        if ([model.commentCount integerValue] >3 ) {
            NSMutableAttributedString  *more = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"查看详情%@条评论\n",model.commentCount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [more yy_setTextHighlightRange:more.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                //跳到子评论的详情页面
                EQDR_LiuYanDetailViewController  *Dvc = [[EQDR_LiuYanDetailViewController alloc]init];
                Dvc.model =model;
                [self.navigationController pushViewController:Dvc animated:NO];
            }];
            more.yy_alignment = NSTextAlignmentRight;
            [all_pinglun appendAttributedString:more];
        }
        all_pinglun.yy_lineSpacing =6;
        CGSize size = [all_pinglun boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [cell.YL_pinglunContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(cell.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.top.mas_equalTo(cell.YL_content.mas_bottom).mas_offset(5);
        }];
        model.cellHeight = 65+size_content.height+size.height+10;
        
        cell.YL_pinglunContent.attributedText =all_pinglun;
}
    [cell setModel:model];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.textView_show.hidden =YES;
}

-(void)showTextViewWithrect:(CGRect)rect  text:(NSString*)text tview:(UIView*)tview
{
   
   
    
    CGSize  size = [text boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-65, DEVICE_WIDTH/2.1) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    if ( [tview superview].frame.origin.y+tview.frame.origin.y + rect.origin.y +rect.size.height/2.0> (DEVICE_HEIGHT-DEVICE_TABBAR_Height-40)/2.0) {
        
        self.textView_show.frame =CGRectMake(10, rect.origin.y-size.height-5, tview.frame.size.width, size.height);
     
    }else
    {
       self.textView_show.frame =CGRectMake(10, rect.origin.y+rect.size.height+5, tview.frame.size.width, size.height);
       
    }
    [tview addSubview:self.textView_show];
    self.textView_show.hidden=NO;
    self.textView_show.text = [NSString stringWithFormat:@"%@ ",text];

    
}

-(void)tap_zanClick:(FBindexTapGestureRecognizer*)tap
{
    //少逻辑
    EQDR_pingLunModel *model =arr_model[tap.indexPath.row];
    if ([model.isZan integerValue]==0) {
        [WebRequest Articles_Add_ArticleComment_ZanWithuserGuid:user.Guid articleCommentId:model.Id And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
                EQDR_PingLunTableViewCell *cell =[tableV cellForRowAtIndexPath:tap.indexPath];
                cell.IV_zan.image = [UIImage imageNamed:@"zan_true"];
                
            }else
            {
                MBFadeAlertView *alert  =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"点赞失败，请重试"];
            }
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"不能重复点赞";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
   
    
}
-(void)tap_liuyanClick:(FBindexTapGestureRecognizer*)tap
{
   
    EQDR_pingLunModel *model = arr_model[tap.indexPath.row];
    parentId = model.Id;
    firstCommentId=model.Id;
    parentUserGuid=model.userGuid;
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.placeHolder = [NSString stringWithFormat:@"回复%@:",model.upname];
    LYvc.btnName = @"发表评论";
    LYvc.delegate =self;
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:LYvc animated:NO completion:nil];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.textView_show.hidden = YES;
}
#pragma  mark - 自定义的协议代理
-(void)getPresnetText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在评论";
    [WebRequest Articles_Add_ArtcielCommentWithuserGuid:user.Guid articleId:self.articleId parentid:parentId content:text parentUserGuid:parentUserGuid firstCommentId:firstCommentId   And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}


@end
