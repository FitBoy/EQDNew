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
    float  currentX;
    EQDR_IVLView  *V_zan;
    EQDR_IVLView  *V_liuyan;
    EQDR_IVLView  *V_zhuanfa;
    FBButton  *B_guanZhu ;
    
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
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y-currentX >0) {
//        self.navigationController.navigationBar.frame = CGRectMake(0, -DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_TABBAR_Height);
//        V_bottom.hidden=NO;
//        scrollView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_TABBAR_Height-50);
//        currentX =scrollView.contentOffset.y;
//    }else
//    {
//
//        V_bottom.hidden=YES;
//        scrollView.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_TABBAR_Height);
//        currentX =scrollView.contentOffset.y;
//    }
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}

-(void)loadRequestData{
    
    [WebRequest Articles_Get_Article_ByIdWitharticleId:self.articleId userGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [EQDR_articleListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [webview_Detail loadHTMLString:[NSString stringWithFormat:@"<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" > <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\"></head><body><h2 style=\" text-align:center\"> %@</h2><small style=\"color:#C0C0C0\"> %@ 阅读 • %@ 评论 • %@ 转发</small><small style=\"color:#C0C0C0; float:right\" >%@</small><br> %@ </body></html>", model_detail.title,model_detail.browseCount,model_detail.commentCount,model_detail.reprintCount,model_detail.createTime, model_detail.content] baseURL:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTop];
                [self setBottom];
            });
         
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    currentX =0;
    user = [WebRequest GetUserInfo];
    webview_Detail= [[UIWebView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-50-kBottomSafeHeight)];
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

-(void)test{
/*  [WebRequest Articles_Get_Article_ByIdWitharticleId:self.articleId userGuid:user.Guid And:^(NSDictionary *dic) {
        NSLog(@"111111111==%@",dic);
    }];
 */
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test];
    });
}

-(void)setTop{
   
    FBButton *B_head = [FBButton buttonWithType:UIButtonTypeSystem];
    [V_top addSubview:B_head];
    [B_head addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    [B_head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(V_top.mas_centerX);
        make.centerY.mas_equalTo(V_top.mas_centerY);
    }];
    [B_head sd_setBackgroundImageWithURL:[NSURL URLWithString:model_detail.iphoto] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    
    B_guanZhu = [FBButton buttonWithType:UIButtonTypeSystem];
    [V_top addSubview:B_guanZhu];
    [B_guanZhu addTarget:self action:@selector(guanZhuClick) forControlEvents:UIControlEventTouchUpInside];
    
if( [model_detail.isAttention integerValue]==0)
{
    [B_guanZhu setTitle:@"+ 关注" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:[UIFont systemFontOfSize:15]];
}else
{
    
  [B_guanZhu setTitle:@"已关注" titleColor:[UIColor darkGrayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
}
    [B_guanZhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerY.mas_equalTo(V_top.mas_centerY);
        make.left.mas_equalTo(B_head.mas_right).mas_offset(5);
    }];
    
    
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
            }else if (i==1)
            {
             //分享
                FB_ShareEQDViewController  *Svc =[[FB_ShareEQDViewController alloc]init];
                Svc.providesPresentationContextTransitionStyle = YES;
                Svc.definesPresentationContext = YES;
                Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                Svc.EQD_ShareType = EQD_ShareTypeText;
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
    if ([model_detail.isAttention integerValue]==0) {
        [WebRequest  Articles_Add_Article_AttentionWithuserGuid:user.Guid attention:model_detail.userGuid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail.isAttention =@"1";
               
                [B_guanZhu setTitle:@"已关注" titleColor:[UIColor darkGrayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
            }
        }];
        
    }else
    {
        [WebRequest  Articles_Cancle_ArticleAttentionWithuserGuid:user.Guid author:model_detail.userGuid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail.isAttention =@"0";
                [B_guanZhu setTitle:@"+ 关注" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:[UIFont systemFontOfSize:15]];
            }
        }];

        
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
    NSString  *imgName =@"zan_false";
    if ([model_detail.isZan integerValue]==1) {
        imgName = @"zan_true";
    }
    
    [V_zan setImg:imgName name:model_detail.zanCount];
    
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
    [V_liuyan setImg:@"pinglun" name:model_detail.commentCount];
    
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
    [V_zhuanfa setImg:@"share_cion" name:model_detail.reprintCount];
    
    
}
-(void)zhuanfaCLick
{
    //转发
  
}
-(void)liuYanCLick
{
    //留言
    EQDR_LiuYanViewController  *Lvc =[[EQDR_LiuYanViewController alloc]init];
    Lvc.articleId =model_detail.Id;
    Lvc.commentCount = model_detail.commentCount;
    [self.navigationController pushViewController:Lvc animated:NO];
 
}



-(void)ZanClick
{
 //点赞
    if ([model_detail.isZan integerValue]==0) {
        [WebRequest Articles_Add_Article_ZanWitharticleId:model_detail.Id userGuid:user.Guid And:^(NSDictionary *dic) {
         if([dic[Y_STATUS] integerValue]==200)
         {
             [V_zan setImg:@"zan_true" name:[NSString stringWithFormat:@"%ld",[model_detail.zanCount integerValue] +1]];
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
#pragma  mark - 举报的协议代理
-(void)getJuBaoType:(NSString *)type text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
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





@end
