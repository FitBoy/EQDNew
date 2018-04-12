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
@interface LLBook_OtherDetailViewController ()
{
    LianLuoBook_ListModel *model_deltail;
    YYLabel *YYL_contents;
    UIScrollView *ScrollV;
    UIView *V_red;
    GongGao_ListModel *model_detail2;
}

@end

@implementation LLBook_OtherDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.isLianLuoBook==1) {
        //通知
        [WebRequest  Newss_Get_Notice_ByIdWithnewsId:self.model_TG.ID And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail2 =[GongGao_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]] ;
                NSMutableAttributedString  *title =[[NSMutableAttributedString alloc]initWithString:model_detail2.newsName attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:30]}];
                title.yy_alignment =NSTextAlignmentCenter;
                
                NSMutableAttributedString  *time =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n%@发 [%@] %@",model_detail2.createName,[model_detail2.createTime  substringWithRange:NSMakeRange(0, 4)],model_detail2.newsCode] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
                time.yy_alignment =NSTextAlignmentCenter;
                [title appendAttributedString:time];
                
                CGSize  tsize =[title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                V_red.frame =CGRectMake(0, tsize.height+9, DEVICE_WIDTH-30, 5);
                
                NSMutableAttributedString  *contentTitle=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n《%@》",model_detail2.newsTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
                contentTitle.yy_alignment =NSTextAlignmentCenter;
                
                [title appendAttributedString:contentTitle];
                
                NSMutableAttributedString *content =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n%@",model_detail2.newsContent] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                [title appendAttributedString:content];
                
                NSMutableAttributedString *createTime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_detail2.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                createTime.yy_alignment =NSTextAlignmentRight;
                [title appendAttributedString:createTime];
                
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

        
    }else if(self.isLianLuoBook==2)
    {
        //公告
        
        [WebRequest Notices_Get_Notice_ByIdWithnoticeId:self.model_TG.ID And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail2 =[GongGao_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]] ;
                NSMutableAttributedString  *title =[[NSMutableAttributedString alloc]initWithString:model_detail2.noticeName attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:30]}];
                title.yy_alignment =NSTextAlignmentCenter;
                
                NSMutableAttributedString  *time =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n%@   [%@] %@",model_detail2.createrName,[model_detail2.createTime  substringWithRange:NSMakeRange(0, 4)],model_detail2.noticeCode] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
                time.yy_alignment =NSTextAlignmentCenter;
                
                [title appendAttributedString:time];
                title.yy_lineSpacing =5;
                CGSize  tsize =[title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                V_red.frame =CGRectMake(0, tsize.height+9, DEVICE_WIDTH-30, 5);
                
                NSMutableAttributedString  *contentTitle=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n《%@》",model_detail2.noticeTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
                contentTitle.yy_alignment =NSTextAlignmentCenter;
                
                [title appendAttributedString:contentTitle];
                
                NSMutableAttributedString *content =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n\n%@",model_detail2.noticeContent] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                [title appendAttributedString:content];
                
                NSMutableAttributedString *createTime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_detail2.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
                createTime.yy_alignment =NSTextAlignmentRight;
                [title appendAttributedString:createTime];
                
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
            
            CGSize  tsize =[title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            V_red.frame =CGRectMake(0, tsize.height+9, DEVICE_WIDTH-30, 5);
            
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
    if (self.isLianLuoBook==1) {
        self.navigationItem.title =@"通知";
    }else if (self.isLianLuoBook==2)
    {
        self.navigationItem.title=@"公告";
    }else
    {
        self.navigationItem.title =@"企业联络书"; 
    }
   
    ScrollV =[[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:ScrollV];
    YYL_contents =[[YYLabel alloc]init];
    YYL_contents.numberOfLines=0;
    [ScrollV addSubview:YYL_contents];
    V_red =[[UIView alloc]init];
    V_red.backgroundColor =[UIColor redColor];
    V_red.layer.shadowOffset =CGSizeMake(1, 3);
    V_red.layer.shadowColor=[UIColor blackColor].CGColor;
    V_red.layer.shadowOpacity=0.8;
    V_red.layer.shadowRadius=1;
    [YYL_contents addSubview:V_red];
    if (self.isLianLuoBook==0) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发消息" style:UIBarButtonItemStylePlain target:self action:@selector(SendClick)];
        [self.navigationItem setRightBarButtonItem:right];
    }
    
    
}
-(void)SendClick
{
    PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model_deltail.creater;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}


@end
