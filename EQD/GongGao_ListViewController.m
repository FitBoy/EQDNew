//
//  GongGao_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongGao_ListViewController.h"
#import "LLBook_OtherDetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "EQDR_labelTableViewCell.h"
#import "GongGao_AddViewController.h"
@interface GongGao_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation GongGao_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code =self.ischeker==1?@"211":@"0";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
    if (self.ischeker ==1) {
        [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"211" And:^(NSDictionary *dic) {
            
        }];
        [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"221" And:^(NSDictionary *dic) {
            
        }];
        [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"581" And:^(NSDictionary *dic) {
            
        }];
    }
    
}
-(void)loadRequestData{
    
    if (self.ischeker==1) {
        [WebRequest Notices_Get_Notice_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" notieName:self.notieName  And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }];
        
    }
    else
    {
    
    
    [WebRequest Notices_Get_Notice_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" notieName:self.notieName And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        for (int i=0; i<tarr.count; i++) {
            GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
    }
}
-(void)loadOtherData
{
    
    if (self.ischeker==1) {
        [WebRequest Notices_Get_Notice_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page notieName:self.notieName And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                
            NSDictionary *dic2 =dic[Y_ITEMS];
            
            NSArray *tarr =dic2[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page =dic2[@"page"];
            for (int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
                }
            }
        }];
        
    }
    else
    {

    [WebRequest Notices_Get_Notice_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page notieName:self.notieName And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
        
        NSDictionary *dic2 =dic[Y_ITEMS];
       
        NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                 page =dic2[@"page"];
        for (int i=0; i<tarr.count; i++) {
            GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
       
        [tableV reloadData];
            }
        }
    }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    page =@"0";
    adjustsScrollViewInsets_NO(tableV, self);
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审批",@"已同意",@"已拒绝"]];
    
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.title =[NSString stringWithFormat:@"发布的%@",self.notieName];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    if(self.ischeker ==0)
    {
        UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightCLick)];
        [self.navigationItem setRightBarButtonItem:right];
    }
    
}
-(void)rightCLick{
    GongGao_AddViewController *Avc =[[GongGao_AddViewController alloc]init];
    Avc.gongwen =self.notieName;
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongGao_ListModel *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    GongGao_ListModel *model =arr_model[indexPath.row];
    [cell setModel_gonggao:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongGao_ListModel *model =arr_model[indexPath.row];
    LLBook_OtherDetailViewController *Dvc =[[LLBook_OtherDetailViewController alloc]init];
    Dvc.Id =model.ID;
    Dvc.isLianLuoBook =2;
    Dvc.gongwen = self.notieName;
    if(segmentC.selectedSegmentIndex==0 && self.ischeker==1)
    {
        Dvc.isShenPi=@"1";
    }else
    {
        Dvc.isShenPi=@"0";
    }
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
