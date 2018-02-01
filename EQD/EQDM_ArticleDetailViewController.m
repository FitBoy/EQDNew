//
//  EQDM_ArticleDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_ArticleDetailViewController.h"
#import "EQDM_ArticleModel.h"
#import <Masonry.h>
@interface EQDM_ArticleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    EQDM_ArticleModel *model_detail;
}

@end

@implementation EQDM_ArticleDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)loadRequestData{
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"详情";
 
    UILabel *tlabel = [[UILabel alloc]init];
    tlabel.numberOfLines =0;
    tlabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tlabel];
   
    [WebRequest Makerspace_Get_MakerArticleDetailWitharticleId:self.articleId userGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [EQDM_ArticleModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSString  *tstr = [NSString stringWithFormat:@"<html><body>%@</body></html>",model_detail.ArticleContent];
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[tstr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            [attrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, attrStr.length)];
            CGSize  size = [attrStr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            dispatch_async(dispatch_get_main_queue(), ^{
                [tlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-30, size.height+5));
                    make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
                    make.top.mas_equalTo(self.view.mas_top).mas_offset(DEVICE_TABBAR_Height);
                }];
                   tlabel.attributedText = attrStr;
            });
         
            
        }
    }];
}



@end
