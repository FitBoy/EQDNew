//
//  MyAboutUsViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "MyAboutUsViewController.h"
#import "FBWebUrlViewController.h"
#import <YYText.h>
@interface MyAboutUsViewController ()
{
    UIScrollView *scrollV;
}

@end

@implementation MyAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    
    self.navigationItem.title = @"易企点";
    NSMutableParagraphStyle  *para =[[NSMutableParagraphStyle alloc]init];
    para.lineSpacing =7;
    para.paragraphSpacingBefore=10;
    
    NSMutableAttributedString  *attrstr =[[NSMutableAttributedString alloc]initWithString:@"     郑州易企点信息科技有限公司成立于2010年，是中国工业制造企业领先的管理咨询服务机构，凭借先进的信息技术积累、对世界广泛实际的工业管理研究，易企点科技愿与客户携手合作，帮助其速进入互联网时代，成就领先的卓越互联网企业，成为行业领袖。\n      企业资源不变，如何让产出更多？易企点科技帮助领导企业在不增加成本的情况下提升绩效——通过先进互联网管理平台帮助企业实现互联互通；采用工业商学院使企业员工感知时代变化，让企业团队顺应时代发展；运用专业精细化咨询师进驻企业落地辅导，实现企业卓越绩效；\n      易企点愿意倾听、分享、贡献，和行业伙伴们一起共同辅就这条开放、合作、共赢之路。构建开放互联的卓越什业，深挖产业发展动力，催发未来发展生机与活力。\n      欲了解我们如何帮您实现企业资源最大化，敬请联系我们！\n" attributes:@{NSParagraphStyleAttributeName:para,NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    //  官网：
    NSMutableAttributedString  *phone = [[NSMutableAttributedString alloc]initWithString:@"合作手机:13303811389" attributes:@{NSParagraphStyleAttributeName:para,NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [phone yy_setTextHighlightRange:NSMakeRange(5, phone.length-5) color:EQDCOLOR backgroundColor:[UIColor grayColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"13303811389"];
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebView];
    }];
    
    [attrstr appendAttributedString:phone];
    
    NSMutableAttributedString  *eamil = [[NSMutableAttributedString alloc]initWithString:@"\n合作邮箱:727024586@qq.com \n" attributes:@{NSParagraphStyleAttributeName:para,NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    [attrstr appendAttributedString:eamil];
    
    NSMutableAttributedString  *guanwang =[[NSMutableAttributedString alloc]initWithString:@"官网:https://www.eqidd.com" attributes:@{NSParagraphStyleAttributeName:para,NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    [guanwang yy_setTextHighlightRange:NSMakeRange(3, guanwang.length-3) color:EQDCOLOR backgroundColor:[UIColor grayColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        FBWebUrlViewController  *Uvc =[[FBWebUrlViewController alloc]init];
        Uvc.url =@"https://www.eqidd.com";
        Uvc.contentTitle = @"易企点";
        [self.navigationController pushViewController:Uvc animated:NO];
    }];
    
    [attrstr appendAttributedString:guanwang];
    
    CGRect rect = [attrstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-31, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    
    YYLabel *tlabel = [[YYLabel alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, rect.size.height)];
    tlabel.numberOfLines=0;
    tlabel.attributedText = attrstr;
    scrollV =[[UIScrollView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height)];
    
    
    adjustsScrollViewInsets_NO(scrollV, self);
    [self.view addSubview:scrollV];
    [scrollV addSubview:tlabel];
    
    scrollV.contentSize = CGSizeMake(DEVICE_WIDTH, rect.size.height+30);
}




@end
