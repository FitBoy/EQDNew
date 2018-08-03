//
//  SC_OtherComDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_OtherComDetailViewController.h"
#import "WS_ComDetailModel.h"
#import "FBScrollView.h"
@interface SC_OtherComDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    UITableView *tableV;
    WS_ComDetailModel *model_detail;
    float height_1;
}

@end

@implementation SC_OtherComDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest ComSpace_Get_ComSpaceInfoWithcompanyId:self.comId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [WS_ComDetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业简介";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    height_1 = 60;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 200;
    }else if (indexPath.row == 1)
    {
        return height_1;
    }else
    {
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (model_detail) {
        return 2;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            FBScrollView  *scrollV =[[FBScrollView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 200)];
            NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
            for (int i=0; i<model_detail.ComImage.count; i++) {
                Image_textModel *tmodel = model_detail.ComImage[i];
                [tarr addObject:tmodel.imgUrl];
            }
            [scrollV setArr_urls:tarr];
            [cell addSubview:scrollV];
        }
        return cell;
    }else if (indexPath.row ==1)
    {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIWebView *webV =[[UIWebView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 100)];
            height_1 = 100;
            webV.delegate =self;
            webV.scrollView.scrollEnabled = NO;
            NSString * htmlString =[NSString stringWithFormat:@"<html><body style = \"font-size:17px\">%@</body></html>",model_detail.comDesc] ;
            [webV loadHTMLString:htmlString baseURL:nil];
            cell.backgroundColor = [UIColor whiteColor];
            [cell addSubview:webV];
        }
        return cell;
    }else
    {
        return nil;
    }
  
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    height_1 = [htmlHeight floatValue] +15;
    webView.frame =CGRectMake(15, 0, DEVICE_WIDTH-30, height_1);
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
