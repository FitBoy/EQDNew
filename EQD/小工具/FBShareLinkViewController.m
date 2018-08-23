//
//  FBShareLinkViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBShareLinkViewController.h"
#import "UITextView+Tool.h"
#import "FBWorkCircleLinkTableViewCell.h"
#import "FBSearchMapViewController.h"
#import "FBWebUrlViewController.h"
#import "FBtextView.h"
@interface FBShareLinkViewController ()<UITableViewDelegate,UITableViewDataSource,FBSearchMapViewControllerDelegate>
{
    UITableView *tableV;
    NSString *place;
    UserModel *user;
    FBtextView *TF_text ;
}

@end

@implementation FBShareLinkViewController
#pragma  mark - 所在的位置
-(void)mapAddress:(NSString*)mapadress  location:(CLLocationCoordinate2D)coor2d
{
    UITableViewCell *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.textLabel.text = mapadress;
    place = mapadress;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"分享到工作圈";
    UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 120)];
    tview.userInteractionEnabled =YES;
   TF_text = [[FBtextView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 120)];
    [tview addSubview:TF_text];
    TF_text.font = [UIFont systemFontOfSize:17.0f];
    [TF_text setPlaceHoder:@"想说点什么……"];
    [TF_text becomeFirstResponder];
    [TF_text setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.tableHeaderView = tview;
    place=@" ";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(faSongClick)];
    [self.navigationItem setRightBarButtonItem:right];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(quxiaoCLick)];
    [self.navigationItem setLeftBarButtonItem:left];
}
#pragma  mark - 发送
-(void)faSongClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    NSString *message = TF_text.text.length==0?@" ":TF_text.text;
    NSString *imgurl = [self.imgUrl stringByReplacingOccurrencesOfString:HTTP_PATH withString:@""];
    NSString *tsourceTitle = nil;
    if (self.sourceTitle.length>49) {
        tsourceTitle = [self.sourceTitle substringWithRange:NSMakeRange(0, 49)];
    }else{
        tsourceTitle =self.sourceTitle;
    }
    [WebRequest WorkCircles_Forward_Add_ForwardWithcompanyId:user.companyId userGuid:user.Guid message:message location:place type:self.type sourceTitle:self.sourceTitle source:self.source sourceUrl:self.sourceUrl imageUrl:imgurl And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self dismissViewControllerAnimated:NO completion:nil];
            }
        });
    }];
}
#pragma  mark - 取消
-(void)quxiaoCLick{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==0)
    {
        if (indexPath.row==0) {
            FBWorkCircleLinkTableViewCell *cell = [[FBWorkCircleLinkTableViewCell alloc]init];
            [cell setimg:self.imgUrl name:self.sourceTitle placehoderImage:nil];
            return cell;
        }else
        {
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.textLabel.text = @"所在的位置";
            UILongPressGestureRecognizer *longpress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
            [cell addGestureRecognizer:longpress];
            return cell;
        }
    }else
    {
        return nil;
    }
    
   
}
-(void)longPress
{
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"不显示位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        place = @" ";
        UITableViewCell *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.textLabel.text = @"所在的位置";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //链接
            FBWebUrlViewController  *Wvc = [[FBWebUrlViewController alloc]init];
            Wvc.url =self.sourceUrl;
            Wvc.contentTitle = self.sourceTitle;
            [self.navigationController pushViewController:Wvc animated:NO];
        }else
        {
            //位置
            FBSearchMapViewController *SMvc =[[FBSearchMapViewController alloc]init];
            SMvc.delegate =self;
            [self.navigationController pushViewController:SMvc animated:NO];
        }
    }
}




@end
