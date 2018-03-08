//
//  EQDS_AddArticleViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_AddArticleViewController.h"
#import <Masonry.h>
#import "FBButton.h"
#import "FBEQDEditer_AllViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
@interface EQDS_AddArticleViewController ()<FBEQDEditer_AllViewControllerDlegate,FB_PXLeiBieChooseViewControllerdelegate>
{
    NSString *title_;
    NSString *html_;
    NSString *text_;
    NSString *imgurl_;
    NSArray *arr_leibie;
    FBButton  *tbtn1;
    FBButton  *tbtn2;
    UserModel *user;
}
@end

@implementation EQDS_AddArticleViewController
#pragma  mark - 富文本的协议代理
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl stringData:(NSData *)data
{
    title_= title;
    html_ = html;
    text_ =text;
    imgurl_ =imgurl;
    [tbtn1 setTitle:@"已填写" forState:UIControlStateNormal];
}
#pragma  mark - 文章类别
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel *> *)arr_teachers
{
    arr_leibie =arr_teachers;
    [tbtn2 setTitle:@"已选择" forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"发布讲师文章";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(fabuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    [self setViewinit];
}
-(void)setViewinit{
    UIView  *tview = [[UIView alloc]init];
    tview.userInteractionEnabled =YES;
    [self.view addSubview:tview];
    [tview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 110));
    }];
    tview.layer.borderWidth =1;
    tview.layer.borderColor = EQDCOLOR.CGColor;
    tbtn1 =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn1 setTitle:@"写文章" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [tview addSubview:tbtn1];
    [tbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.top.mas_equalTo(tview.mas_top).mas_offset(10);
        make.centerX.mas_equalTo(tview.mas_centerX);
    }];
    [tbtn1 addTarget:self action:@selector(editorClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
  tbtn2 =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn2 setTitle:@"选择文章类别" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [tview addSubview:tbtn2];
    [tbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.bottom.mas_equalTo(tview.mas_bottom).mas_offset(-10);
        make.centerX.mas_equalTo(tview.mas_centerX);
    }];
    
       [tbtn2 addTarget:self action:@selector(leibieCLick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)fabuClick
{
    NSMutableString  *Tstr = [NSMutableString string];
    
    for (int i=0; i<arr_leibie.count; i++) {
        FBAddressModel  *model = arr_leibie[i];
        if (i==arr_leibie.count-1) {
            [Tstr appendString:model.name];
        }else
        {
            [Tstr appendFormat:@"%@,",model.name];
        }
       
    }
    if (title_ && arr_leibie.count) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发布";
        [WebRequest Lectures_article_Add_LectureArticleWithuserGuid:user.Guid title:title_ content:text_ homeImage:imgurl_ label:Tstr companyId:user.companyId textContent:text_ And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                     [self.navigationController popViewControllerAnimated:NO];
                });
               
            }
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"填写的参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }

}
-(void)editorClick{
    FBEQDEditer_AllViewController *Avc = [[FBEQDEditer_AllViewController alloc]init];
    Avc.delegate =self;
    Avc.temp = 2;
    [self.navigationController pushViewController:Avc animated:NO];
}
-(void)leibieCLick
{
    FB_PXLeiBieChooseViewController  *Pvc =[[FB_PXLeiBieChooseViewController alloc]init];
    Pvc.delegate =self;
    Pvc.arr_chosemodel = arr_leibie;
    [self.navigationController pushViewController:Pvc animated:NO];
}



@end
