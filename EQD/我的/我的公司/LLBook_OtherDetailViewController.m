//
//  LLBook_OtherDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LLBook_OtherDetailViewController.h"
#import <YYText.h>
#import "PPersonCardViewController.h"
#import "FBTwoButtonView.h"
#import "FB_OnlyForLiuYanViewController.h"
@interface LLBook_OtherDetailViewController ()<FB_OnlyForLiuYanViewControllerDlegate>
{
    LianLuoBook_ListModel *model_deltail;
    YYLabel *YYL_contents;
    UIScrollView *ScrollV;
    GongGao_ListModel *model_detail2;
    UserModel *user;
    float  height_;
    FBTwoButtonView  *twoView;
}

@end

@implementation LLBook_OtherDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if(self.isLianLuoBook==2)
    {
        //公告
        
        [WebRequest Notices_Get_Notice_ByIdWithnoticeId:self.Id And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail2 =[GongGao_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]] ;
                NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@\n",user.company,self.gongwen] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor redColor]}];
                title.yy_alignment = NSTextAlignmentCenter;
                
               
                
                NSMutableAttributedString  *time =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@   [%@]  %@号  签发人:【%@】\n ",model_detail2.simpleCompanyName,[model_detail2.createTime  substringWithRange:NSMakeRange(0, 4)],model_detail2.noticeCode,model_detail2.checkerName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
                time.yy_alignment =NSTextAlignmentCenter;
//                [time yy_setTextUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:[NSNumber numberWithFloat:2] color:[UIColor redColor]] range:time.yy_rangeOfAll];
                [title appendAttributedString:time];
              
                
                NSMutableAttributedString  *contentTitle=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"《%@》\n",model_detail2.noticeTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
                contentTitle.yy_alignment =NSTextAlignmentCenter;
                
                [title appendAttributedString:contentTitle];
                
                title.yy_lineSpacing = 12;
                NSString  *tstr = model_detail2.department;
                if ([model_detail2.objectType integerValue]==0) {
                    tstr = @"全体员工";
                }
                NSMutableAttributedString  *other = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"致：%@\n",tstr] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                other.yy_lineSpacing =6;
                [title appendAttributedString:other];
                NSMutableAttributedString *content =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"      %@\n ",model_detail2.noticeContent] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                content.yy_lineSpacing =6;
                [title appendAttributedString:content];
                NSMutableAttributedString  *noticeName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n特此%@",model_detail2.noticeName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                noticeName.yy_alignment = NSTextAlignmentRight;
                
                [title appendAttributedString:noticeName];
                NSMutableAttributedString *createTime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_detail2.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
                createTime.yy_alignment =NSTextAlignmentRight;
                [title appendAttributedString:createTime];
                
                YYL_contents.attributedText =title;
                title.yy_lineSpacing =12;
                CGSize  size =[title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                YYL_contents.frame =CGRectMake(15, 0, DEVICE_WIDTH-30, size.height+20);
                
                if (size.height+20>DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-height_) {
                    
                    ScrollV.contentSize=CGSizeMake(DEVICE_WIDTH, size.height+30+height_);
                }else
                {
                    ScrollV.contentSize =CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight+height_);
                }
            }

            
        }];

    }else
    {
    
    [WebRequest LiaisonBooks_Get_LiaisonBook_ByIdWithId:self.model.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_deltail =[LianLuoBook_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]] ;
            NSMutableAttributedString  *title =[[NSMutableAttributedString alloc]initWithString:model_deltail.liaisonBookName attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:30]}];
            title.yy_alignment =NSTextAlignmentCenter;
            
            NSMutableAttributedString  *time =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n%@  [%@] %@",model_deltail.createrName,[model_deltail.createTime  substringWithRange:NSMakeRange(0, 4)],model_deltail.liaisonBookCode] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            time.yy_alignment =NSTextAlignmentCenter;
            
            [title appendAttributedString:time];
                        
            NSMutableAttributedString  *contentTitle=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n《%@》",model_deltail.liaisonBookTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
            contentTitle.yy_alignment =NSTextAlignmentCenter;
            
            [title appendAttributedString:contentTitle];
            
            NSMutableAttributedString *content =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n%@",model_deltail.liaisonBookContent] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            [title appendAttributedString:content];
            
            NSMutableAttributedString *createTime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_deltail.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            createTime.yy_alignment =NSTextAlignmentRight;
            [title appendAttributedString:createTime];
            title.yy_lineSpacing = 5;
            YYL_contents.attributedText =title;
            CGSize  size =[title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            YYL_contents.frame =CGRectMake(15, 0, DEVICE_WIDTH-30, size.height+20);
            if (size.height+20>DEVICE_HEIGHT-64) {
                ScrollV.contentSize=CGSizeMake(DEVICE_WIDTH, size.height+30);
            }else
            {
                ScrollV.contentSize =CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT-64);
            }
        }
        
    }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest  GetUserInfo];
    height_ =[self.isShenPi integerValue]==1?50:0;
    
   
     if (self.isLianLuoBook==2)
    {
        self.navigationItem.title=self.gongwen;
    }else
    {
        self.navigationItem.title =@"企业联络书"; 
    }
   
    ScrollV =[[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:ScrollV];
    YYL_contents =[[YYLabel alloc]init];
    YYL_contents.numberOfLines=0;
    [ScrollV addSubview:YYL_contents];
  
    if (self.isLianLuoBook==0) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发消息" style:UIBarButtonItemStylePlain target:self action:@selector(SendClick)];
        [self.navigationItem setRightBarButtonItem:right];
    }
    if([self.isShenPi integerValue]==1)
    {
        twoView = [[FBTwoButtonView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-50-kBottomSafeHeight, DEVICE_WIDTH, 50)];
        [self.view addSubview:twoView];
        [twoView setleftname:@"拒绝" rightname:@"同意"];
        [twoView.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [twoView.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        
        [twoView bringSubviewToFront:ScrollV];
    }else
    {
        
    }
    
}
#pragma  mark - 拒绝的原因
-(void)getPresnetText:(NSString*)text
{
    if (self.isLianLuoBook ==2) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在拒绝";
        [WebRequest Notices_Set_Notice_CheckWithnoticeId:self.Id userGuid:user.Guid message:@" " type:@"2" notieName:self.gongwen And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if([dic[Y_STATUS] integerValue]==200)
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
            
        }];
    }
}
-(void)leftClick
{
    //拒绝
    FB_OnlyForLiuYanViewController  *LYvc = [[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.btnName = @"拒绝";
    LYvc.placeHolder = @"请输入拒绝原因";
    LYvc.delegate =self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController presentViewController:LYvc animated:NO completion:nil];
    });
}
-(void)rightClick{
    //同意
    if (self.isLianLuoBook ==2) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在同意";
        [WebRequest Notices_Set_Notice_CheckWithnoticeId:self.Id userGuid:user.Guid message:@" " type:@"1" notieName:self.gongwen And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if([dic[Y_STATUS] integerValue]==200)
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
         
        }];
    }
    
}
-(void)SendClick
{
    PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model_deltail.creater;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}


@end
