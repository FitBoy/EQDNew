//
//  CK_chuangkeShoucangViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_chuangkeShoucangViewController.h"
#import "FBImg_YYlabelTableViewCell.h"
#import "CK_chuangKeModel.h"
#import <UIImageView+WebCache.h>
#import "PPersonCardViewController.h"
@interface CK_chuangkeShoucangViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString  *page;
    UserModel *user;
}

@end

@implementation CK_chuangkeShoucangViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Makerspacey_MakerCollection_Get_OtherMakerCollectWithuserGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                CK_chuangKeModel *model = [CK_chuangKeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest Makerspacey_MakerCollection_Get_OtherMakerCollectWithuserGuid:self.userGuid page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
                
            for (int i=0; i<tarr.count; i++) {
                CK_chuangKeModel *model = [CK_chuangKeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏的创客";
    user = [WebRequest GetUserInfo];
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBImg_YYlabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBImg_YYlabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    CK_chuangKeModel  *model = arr_model[indexPath.row];
    [cell.IV_head sd_setImageWithURL:[NSURL URLWithString:model.makerImg] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@【%@】\n",model.makerName,model.makerCity] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    NSMutableAttributedString *field =[[NSMutableAttributedString alloc]initWithString:@" " attributes:nil];
    NSArray *tarr = [model.ResearchField componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *field1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [field1 yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:field1.yy_rangeOfAll];
        [field appendAttributedString:field1];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@" " attributes:nil];
        [field appendAttributedString:kong];
    }
    [name appendAttributedString:field];
    name.yy_lineSpacing =6;
    cell.YL_text.attributedText = name;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CK_chuangKeModel *model = arr_model[indexPath.row];
    PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid = model.makerGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //取消收藏
        CK_chuangKeModel *model = arr_model[indexPath.row];
        [WebRequest Makerspacey_MakerCollection_Cancle_MakerCollectionWithuserGuid:user.Guid collectId:model.Id And:^(NSDictionary *dic) {
            MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"收藏成功"];
                [arr_model removeObject:model];
                [tableV reloadData];
            }else
            {
              [alert showAlertWith:dic[Y_MSG]];
            }
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}




@end
