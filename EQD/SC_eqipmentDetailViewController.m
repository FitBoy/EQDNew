//
//  SC_eqipmentDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_eqipmentDetailViewController.h"
#import "WS_equipmentModel.h"
#import "FBScrollView.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
@interface SC_eqipmentDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    UITableView *tableV;
    WS_equipmentModel *model_detail;
    float height_1;
    float height_2;
}

@end

@implementation SC_eqipmentDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest ComSpace_ComSpaceEquipment_Get_ComSpaceEquipmentByIdWithequipmentIdWithequipmentId:self.equipmentId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [WS_equipmentModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    height_2 = [htmlHeight floatValue]+15;
    webView.frame =CGRectMake(15, 0, DEVICE_WIDTH-30, height_2);
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设备详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    height_1 = 60;
    height_2 = 60;

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 200;
    }else if(indexPath.row ==1)
    {
        return height_1;
    }else if (indexPath.row ==2)
    {
        return height_2;
    }else
    {
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (model_detail) {
        return 3;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0)
    {
    static NSString *cellId=@"cellID0";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        FBScrollView *scrollV  =[[FBScrollView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 200)];
        [scrollV setArr_urls:model_detail.images];
        [cell addSubview:scrollV];
    }
    return cell;
    }else if (indexPath.row ==1)
    {
        static NSString *cellId=@"cellID1";
        FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"设备名称：%@\n设备厂商：%@\n购买日期：%@",model_detail.EquipmentName,model_detail.Manufactor,model_detail.DateOfPurchase] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
        name.yy_lineSpacing =6;
        cell.YL_content.attributedText = name;
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        height_1 = size.height+15;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
    }else if (indexPath.row ==2)
    {
        static NSString *cellId=@"cellID2";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIWebView *webV =[[UIWebView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 100)];
            webV.delegate =self;
            webV.scrollView.scrollEnabled =NO;
            NSString * htmlString =[NSString stringWithFormat:@"<html><body style = \"font-size:17px\"> %@</body></html>",model_detail.EquipmentMsg];
            [webV loadHTMLString:htmlString baseURL:nil];
            [cell addSubview:webV];
            height_2 =100;
            
        }
        return cell;
    }else
    {
        return nil;
    }
}


#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
