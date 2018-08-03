//
//  SC_ComShoucangViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_ComShoucangViewController.h"
#import "FBOneImg_yyLabelTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "WS_comDetailViewController.h"
@interface SC_ComShoucangViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
}

@end

@implementation SC_ComShoucangViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    /*
     {
     Id = 16;
     comLogo = "https://www.eqid.top:8009/image/com/46/1804085749logo.png";
     company = "\U90d1\U5dde\U6613\U4f01\U70b9\U4fe1\U606f\U79d1\U6280\U6709\U9650\U516c\U53f8";
     }
     */
    [WebRequest ComSpace_ComSpace_Collection_Get_CompanyCollectionWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page =dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                [arr_model addObject:tarr[i]];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest ComSpace_ComSpace_Collection_Get_CompanyCollectionWithcompanyId:self.comId page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page =dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                [arr_model addObject:tarr[i]];
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
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"收藏的企业";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
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
    FBOneImg_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneImg_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSDictionary *tdic = arr_model[indexPath.row];
    [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:tdic[@"comLogo"]] placeholderImage:[UIImage imageNamed:@"imageerro"] options:SDWebImageProgressiveDownload];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:tdic[@"company"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    cell.yyL_context.attributedText =name;
    [cell.yyL_context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.left.mas_equalTo(cell.IV_img.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tdic = arr_model[indexPath.row];
    WS_comDetailViewController *Dvc = [[WS_comDetailViewController alloc]init];
    Dvc.comId = tdic[@"companyId"];
    [self.navigationController pushViewController:Dvc animated:NO];
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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定取消收藏该企业" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消收藏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *tdic = arr_model[indexPath.row];
            [WebRequest  ComSpace_ComSpace_Collection_Cancel_CollectionWithuserGuid:user.Guid companyId:user.companyId collectId:tdic[@"Id"] And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"取消成功"];
                    [arr_model removeObject:tdic];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试！"];
                }
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
       
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}




@end
