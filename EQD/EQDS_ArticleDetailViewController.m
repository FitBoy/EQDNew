//
//  EQDS_ArticleDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_ArticleDetailViewController.h"
#import "EQDS_articleModel.h"
@interface EQDS_ArticleDetailViewController ()
{
    UILabel *L_html;
    UIScrollView *S_scrollV;
}

@end

@implementation EQDS_ArticleDetailViewController

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文章的详情";
    S_scrollV  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight)];
    [self.view addSubview:S_scrollV];
    L_html = [[UILabel alloc]init];
    L_html.numberOfLines=0;
    [S_scrollV addSubview:L_html];
    S_scrollV.showsVerticalScrollIndicator = NO;
    S_scrollV.showsHorizontalScrollIndicator =NO;
   
    [self getDetail];
}
-(void)getDetail{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    [WebRequest Lectures_article_Get_LectureArticle_ByIdWithlectureArticleId:self.Id And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        if ([dic[Y_STATUS] integerValue]==200) {
            EQDS_articleModel  *model = [EQDS_articleModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSString * htmlString = [NSString stringWithFormat:@"<html><body style = \"font-size:17px\"><h2  style = \"text-align:center\">%@</h2><p style = \"text-align:right;font-size:13px;color:gray\">作者:%@  %@  浏览次数:%@</p> %@ </body></html>",model.title,model.staffName,model.createTime,model.browseCount,model.content];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            CGSize size = [attrStr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            L_html.frame = CGRectMake(15, 0, DEVICE_WIDTH-30, size.height+10);
            dispatch_async(dispatch_get_main_queue(), ^{
                S_scrollV.contentSize= CGSizeMake(DEVICE_WIDTH, size.height+12);
                
               L_html.attributedText = attrStr;
            });
        }else
        {
            L_html.frame = CGRectMake(15, 0, DEVICE_WIDTH-30, 100);
            L_html.text = @"网络错误";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:NO];
            });
        }
    }];
}



@end
