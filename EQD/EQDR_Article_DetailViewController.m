//
//  EQDR_Article_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_Article_DetailViewController.h"
#import "EQDR_articleListModel.h"
#import "EQDR_ArticleHeadTableViewCell.h"
#import "EQDR_webviewTableViewCell.h"
#import "EQDR_labelTableViewCell.h"
#import "FBButton.h"
#import <Masonry.h>
#import "EQDR_IVLView.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "PPersonCardViewController.h"
#import "EQDR_LiuYanViewController.h"
#import "R_RichTextEditor_ViewController.h"
#import "EQDR_JuBaoViewController.h"
#import "FB_ShareEQDViewController.h"
#import "EQD_HtmlTool.h"
#import "EQDM_ArticleModel.h"
/**

 
    [webview_Detail loadHTMLString:[NSString stringWithFormat:@"<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" > <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\"></head><body> %@ </body></html>",model_detail.content] baseURL:nil];
 */
@interface EQDR_Article_DetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate,EQDR_JuBaoViewControllerdelegate>
{
    EQDR_articleListModel  *model_detail;
    UIWebView  *webview_Detail;
    MBProgressHUD *hud;
    UIView *V_top; // 返回 关注 更多（收藏，分享，举报）
    UIView *V_bottom; // 留言  点赞  转发(分享)（数目写在下面）
    UserModel *user;
    EQDR_IVLView  *V_zan;
    EQDR_IVLView  *V_liuyan;
    EQDR_IVLView  *V_zhuanfa;
   /* FBButton  *B_guanZhu ;
    FBButton *B_head;*/
    UIImageView *IV_head;
    UILabel *L_guanzhu;
  // 易企创的模型
    EQDM_ArticleModel *model_MDetail;
    
    
}

@end

@implementation EQDR_Article_DetailViewController
- (BOOL)prefersHomeIndicatorAutoHidden
{
    return NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [hud hideAnimated:NO];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
   hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载中";
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)loadRequestData{
    if (self.temp == EQDArticle_typeMade) {
        [WebRequest Makerspace_Get_MakerArticleDetailWitharticleId:self.articleId userGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_MDetail  = [EQDM_ArticleModel mj_objectWithKeyValues:dic[Y_ITEMS]];
               
                [webview_Detail loadHTMLString:[NSString stringWithFormat:@"<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" > <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\"></head><body><h2 style=\" text-align:center\"> %@</h2><small style=\"color:#C0C0C0\"> %@ 评论 • %@ 喜欢</small><small style=\"color:#C0C0C0; float:right\" >%@</small><br> %@ </body></html>", model_MDetail.title,model_MDetail.commentCount,model_MDetail.praiseCount, model_MDetail.postTime,model_MDetail.ArticleContent] baseURL:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setTop];
                    [self setBottom];
                });
            }
        }];
        
    }else
    {
    [WebRequest Articles_Get_Article_ByIdWitharticleId:self.articleId userGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [EQDR_articleListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [webview_Detail loadHTMLString:[NSString stringWithFormat:@"<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" > <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\"></head><body><h2 style=\" text-align:center\"> %@</h2><small style=\"color:#C0C0C0\"> %@ 阅读 • %@ 评论 • %@ 转发</small><small style=\"color:#C0C0C0; float:right\" >%@</small><br> %@ </body></html>", model_detail.title,model_detail.browseCount,model_detail.commentCount,model_detail.reprintCount,model_detail.createTime, model_detail.content] baseURL:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTop];
                [self setBottom];
            });
         
        }else
        {
            [webview_Detail loadHTMLString:@"<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" > <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\"></head><body style=\"font-size:25px; color:gray;text-align:center\" >文章已被作者删除</body></html>"  baseURL:nil];
        }
    }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];

    webview_Detail= [[UIWebView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-50-kBottomSafeHeight)];
    adjustsScrollViewInsets_NO(webview_Detail.scrollView, self);
    [self.view addSubview:webview_Detail];
    webview_Detail.delegate =self;
    webview_Detail.scrollView.delegate =self;
    webview_Detail.scrollView.pagingEnabled=YES;
    V_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    V_top.userInteractionEnabled = YES;
    self.navigationItem.titleView =V_top;
    
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"EQD_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(menuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    V_bottom = [[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-50-kBottomSafeHeight, DEVICE_WIDTH, 50)];
    V_bottom.userInteractionEnabled=YES;
    [V_bottom setBackgroundColor:[UIColor blackColor]];
//    V_bottom.hidden=YES;
    [self.view addSubview:V_bottom];
      [self loadRequestData];
}



-(void)setTop{
    if (!IV_head) {
        IV_head = [[UIImageView alloc]init];
        IV_head.userInteractionEnabled =YES;
        [V_top addSubview:IV_head];
        UITapGestureRecognizer  *tap_head = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick)];
        [IV_head addGestureRecognizer:tap_head];
        [IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerX.mas_equalTo(V_top.mas_centerX);
            make.centerY.mas_equalTo(V_top.mas_centerY);
        }];
        
        if (self.temp ==EQDArticle_typeMade) {
            [IV_head sd_setImageWithURL:[NSURL URLWithString:model_MDetail.avatar] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        }else
        {
        [IV_head sd_setImageWithURL:[NSURL URLWithString:model_detail.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        }
        
}
 
    
    if (!L_guanzhu) {
        L_guanzhu = [[UILabel alloc]init];
        L_guanzhu.textAlignment =NSTextAlignmentCenter;
        L_guanzhu.font=[UIFont systemFontOfSize:15];
        L_guanzhu.userInteractionEnabled =YES;
        [V_top addSubview:L_guanzhu];
        UITapGestureRecognizer  *tap_guanzhu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(guanZhuClick)];
        [L_guanzhu addGestureRecognizer:tap_guanzhu];
        
        if (self.temp ==EQDArticle_typeMade) {
            if( [model_MDetail.isAttention integerValue]==0)
            {
                L_guanzhu.text = @"+ 关注";
                L_guanzhu.textColor = [UIColor orangeColor];
            }else
            {
                L_guanzhu.text = @"已关注";
                L_guanzhu.textColor = [UIColor grayColor];
            }
        }else
        {
        if( [model_detail.isAttention integerValue]==0)
        {
            L_guanzhu.text = @"+ 关注";
            L_guanzhu.textColor = [UIColor orangeColor];
        }else
        {
             L_guanzhu.text = @"已关注";
            L_guanzhu.textColor = [UIColor grayColor];
        }
        }
        [L_guanzhu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.centerY.mas_equalTo(V_top.mas_centerY);
            make.left.mas_equalTo(IV_head.mas_right).mas_offset(5);
        }];
    }
   
    
    
}
-(void)menuClick
{
    //菜单
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"收藏",@"分享",@"举报"];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(i==0)
            {
              //收藏
                if(self.temp ==1)
                {
                    [WebRequest Collection_Add_collectionowner:user.Guid type:@"12" title:model_detail.title url:[NSString stringWithFormat:@"%@;%@",model_MDetail.picUrl,[EQD_HtmlTool getEQDR_ArticleDetailWithId:model_MDetail.Id]] source:@"易企创" sourceOwner:model_MDetail.userGuid articleId:model_MDetail.Id And:^(NSDictionary *dic) {
                        if ([dic[Y_STATUS] integerValue]==200) {
                            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                            [alert showAlertWith:@"收藏成功"];
                        }
                    }];
                }else
                {
                [WebRequest Collection_Add_collectionowner:user.Guid type:@"10" title:model_detail.title url:[NSString stringWithFormat:@"%@;%@",model_detail.homeImage,[EQD_HtmlTool getEQDR_ArticleDetailWithId:model_detail.Id]] source:@"易企阅" sourceOwner:model_detail.userGuid articleId:model_detail.Id And:^(NSDictionary *dic) {
                    if ([dic[Y_STATUS] integerValue]==200) {
                        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"收藏成功"];
                    }
                }];
                }
            }else if (i==1)
            {
             //分享
                FB_ShareEQDViewController  *Svc =[[FB_ShareEQDViewController alloc]init];
                Svc.providesPresentationContextTransitionStyle = YES;
                Svc.definesPresentationContext = YES;
                Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                Svc.articleId = model_MDetail.Id;
                //url text title imageURL
                if(self.temp ==1)
                {
                    //易企创
                    Svc.url =[EQD_HtmlTool getEQDM_ArticleDetailWithId:model_MDetail.Id];
                    Svc.Stitle =model_MDetail.title;
                    Svc.text =model_MDetail.splendidContent;
                    Svc.imageURL = [NSString stringWithFormat:@"%@%@",HTTP_PATH,model_MDetail.picUrl];
                    Svc.articleId = self.articleId;
                    Svc.source = @"易企创";
                    Svc.type = 12;
                    Svc.type2=1;
                    Svc.sourceOwner=model_MDetail.userGuid;
                }else
                {
                Svc.url =[EQD_HtmlTool getEQDR_ArticleDetailWithId:model_detail.Id];
                Svc.Stitle =model_detail.title;
                Svc.text =model_detail.textContent;
                Svc.imageURL = model_detail.homeImage;
                    Svc.articleId = self.articleId;
                    Svc.source = @"易企阅";
                    Svc.sourceOwner = model_detail.userGuid;
                }
                Svc.EQD_ShareType = EQD_ShareTypeLink;
                Svc.type = 10;
                Svc.type2=1;
                [self presentViewController:Svc animated:NO completion:nil];
                
            }else if (i==2)
            {
              //举报
                EQDR_JuBaoViewController  *JBvc =[[EQDR_JuBaoViewController alloc]init];
                JBvc.type =0;
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
    
    if ([user.Guid isEqualToString:model_detail.userGuid]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            R_RichTextEditor_ViewController *Tvc =[[R_RichTextEditor_ViewController alloc]init];
            Tvc.source =model_detail.source;
            Tvc.model = model_detail;
            [self.navigationController pushViewController:Tvc animated:NO];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)guanZhuClick
{
    //关注
    
    if (self.temp ==EQDArticle_typeMade) {
        if ([model_MDetail.isPraised integerValue]==0) {
            [WebRequest  Articles_Add_Article_AttentionWithuserGuid:user.Guid attention:model_MDetail.userGuid And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                   model_MDetail.isPraised=@"1";
                    
                    L_guanzhu.text =@"已关注";
                    L_guanzhu.textColor = [UIColor grayColor];
                }
            }];
            
        }else
        {
            [WebRequest  Articles_Cancle_ArticleAttentionWithuserGuid:user.Guid author:model_MDetail.userGuid And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    model_MDetail.isPraised =@"0";
                    L_guanzhu.text = @"+ 关注";
                    L_guanzhu.textColor = [UIColor orangeColor];
                }
            }];
            
            
        }
    }else
    {
    if ([model_detail.isAttention integerValue]==0) {
        [WebRequest  Articles_Add_Article_AttentionWithuserGuid:user.Guid attention:model_detail.userGuid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail.isAttention =@"1";
               
                L_guanzhu.text =@"已关注";
                L_guanzhu.textColor = [UIColor grayColor];
            }
        }];
        
    }else
    {
        [WebRequest  Articles_Cancle_ArticleAttentionWithuserGuid:user.Guid author:model_detail.userGuid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail.isAttention =@"0";
                L_guanzhu.text = @"+ 关注";
                L_guanzhu.textColor = [UIColor orangeColor];
            }
        }];

        
    }
    }
}
-(void)headClick
{
    //点击头像
    PPersonCardViewController  *PVc =[[PPersonCardViewController alloc]init];
    PVc.userGuid =model_detail.userGuid;
    [self.navigationController pushViewController:PVc animated:NO];
}

-(void)setBottom{
    
    V_zan = [[EQDR_IVLView alloc]init];
   
    
    [V_bottom addSubview:V_zan];
    UITapGestureRecognizer  *tap_zan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ZanClick)];
    [V_zan.IV_img addGestureRecognizer:tap_zan];
    [V_zan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(V_bottom.mas_centerX);
        make.centerY.mas_equalTo(V_bottom.mas_centerY);
    }];
    
    float  twidth = (DEVICE_WIDTH -150)/4.0;
    V_liuyan = [[EQDR_IVLView alloc]init];
    [V_bottom addSubview:V_liuyan];
    UITapGestureRecognizer *tap_liuyan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liuYanCLick)];
    [V_liuyan.IV_img addGestureRecognizer:tap_liuyan];
  
    
    [V_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.mas_equalTo(V_bottom.mas_centerY);
        make.left.mas_equalTo(V_bottom.mas_left).mas_offset(twidth);
    }];
    
    V_zhuanfa = [[EQDR_IVLView alloc]init];
    [V_bottom addSubview:V_zhuanfa];
    UITapGestureRecognizer  *tap_zhuanfa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhuanfaCLick)];
    [V_zhuanfa addGestureRecognizer:tap_zhuanfa];
    
    [V_zhuanfa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.mas_equalTo(V_bottom.mas_centerY);
        make.right.mas_equalTo(V_bottom.mas_right).mas_offset(-twidth);
    }];
   
    if (self.temp ==EQDArticle_typeMade) {
         [V_zhuanfa setImg:@"share_cion" name:model_MDetail.forwardedCount];
          [V_liuyan setImg:@"pinglun" name:model_MDetail.commentCount];
        //剩下一个点赞的
         NSString  *imgName =@"zan_false";
        if ([model_MDetail.isPraised integerValue]==1) {
             imgName = @"zan_true";
        }
          [V_zan setImg:imgName name:model_MDetail.praiseCount];
    }else
    {
        NSString  *imgName =@"zan_false";
        if ([model_detail.isZan integerValue]==1) {
            imgName = @"zan_true";
        }
        [V_zan setImg:imgName name:model_detail.zanCount];
         [V_zhuanfa setImg:@"share_cion" name:model_detail.reprintCount];
          [V_liuyan setImg:@"pinglun" name:model_detail.commentCount];
    }
    
}
-(void)zhuanfaCLick
{
    //分享
    FB_ShareEQDViewController  *Svc =[[FB_ShareEQDViewController alloc]init];
    Svc.providesPresentationContextTransitionStyle = YES;
    Svc.definesPresentationContext = YES;
    Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    if (self.temp ==EQDArticle_typeMade) {
        //易企创
        Svc.url =[EQD_HtmlTool getEQDM_ArticleDetailWithId:model_MDetail.Id];
        Svc.Stitle =model_MDetail.title;
        Svc.text =model_MDetail.splendidContent;
        Svc.imageURL = model_MDetail.picUrl;
        Svc.articleId = model_MDetail.Id;
        Svc.type =1;
    }else
    {
    //url text title imageURL
    Svc.url =[EQD_HtmlTool getEQDR_ArticleDetailWithId:model_detail.Id];
    Svc.Stitle =model_detail.title;
    Svc.text =model_detail.textContent;
    Svc.imageURL = model_detail.homeImage;
    Svc.articleId = model_detail.Id;
        Svc.type =1;
        Svc.type2=1;
    }
    Svc.EQD_ShareType = EQD_ShareTypeLink;
    [self presentViewController:Svc animated:NO completion:nil];
  
}
-(void)liuYanCLick
{
    //留言
    EQDR_LiuYanViewController  *Lvc =[[EQDR_LiuYanViewController alloc]init];
    if (self.temp ==EQDArticle_typeMade) {
        Lvc.articleId = self.articleId;
        Lvc.commentCount = model_MDetail.commentCount;
        Lvc.temp = self.temp;
    }else
    {
    Lvc.articleId =model_detail.Id;
    Lvc.commentCount = model_detail.commentCount;
        Lvc.temp = self.temp;
    }
    [self.navigationController pushViewController:Lvc animated:NO];
 
}



-(void)ZanClick
{
 //点赞
    if (self.temp == EQDArticle_typeMade) {
        if ([model_MDetail.isPraised integerValue]==1) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在取消点赞";
            [WebRequest Makerspace_MakerArtiExtend_MakerArtiPraiseWithuserGuid:user.Guid type:@"1" itemId:self.articleId operation:@"-1" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [V_zan setImg:@"zan_false" name:[NSString stringWithFormat:@"%ld",[model_MDetail.praiseCount integerValue] -1]];
                        model_MDetail.praiseCount = [NSString stringWithFormat:@"%ld",[model_MDetail.praiseCount integerValue] -1];
                        model_MDetail.isPraised=@"0";
                    }
                });
            }];
            
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在点赞";
            [WebRequest Makerspace_MakerArtiExtend_MakerArtiPraiseWithuserGuid:user.Guid type:@"1" itemId:self.articleId operation:@"1" And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [V_zan setImg:@"zan_true" name:[NSString stringWithFormat:@"%ld",[model_MDetail.praiseCount integerValue] +1]];
                        model_MDetail.praiseCount =[NSString stringWithFormat:@"%ld",[model_MDetail.praiseCount integerValue] +1];
                        model_MDetail.isPraised=@"1";
                    }
                });
            }];
        }
        
    }else
    {
    if ([model_detail.isZan integerValue]==0) {
        [WebRequest Articles_Add_Article_ZanWitharticleId:model_detail.Id userGuid:user.Guid And:^(NSDictionary *dic) {
         if([dic[Y_STATUS] integerValue]==200)
         {
             [V_zan setImg:@"zan_true" name:[NSString stringWithFormat:@"%ld",[model_detail.zanCount integerValue] +1]];
             model_detail.zanCount =[NSString stringWithFormat:@"%ld",[model_detail.zanCount integerValue] +1];
             model_detail.isZan=@"1";
         }
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"暂不支持取消点赞";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    }
}
#pragma  mark - 举报的协议代理
-(void)getJuBaoType:(NSString *)type text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    if (self.temp ==1) {
        [WebRequest Makerspace_MakerArtiExtend_MakerArtiTipOffWithuserGuid:user.Guid itemType:@"1" itemId:self.articleId tipOffType:type theContent:text And:^(NSDictionary *dic) {
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
    }else
    {
    [WebRequest Articles_Add_Article_ReportWithuserGuid:user.Guid articleId:self.articleId reason:text reportType:type And:^(NSDictionary *dic) {
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
}





@end
