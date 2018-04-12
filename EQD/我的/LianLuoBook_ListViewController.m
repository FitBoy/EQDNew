//
//  LianLuoBook_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LianLuoBook_ListViewController.h"
#import "LianLuo_Book_AddViewController.h"
#import "LianLuoBook_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface LianLuoBook_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation LianLuoBook_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code =self.isShenPi==1?@"231":@"232";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    if (self.isShenPi==1) {
        
        [WebRequest LiaisonBooks_Get_LiaisonBook_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LianLuoBook_ListModel *model =[LianLuoBook_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        }];
        
        
    }else
    {
    [WebRequest LiaisonBooks_Get_LiaisonBook_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        for (int i=0; i<tarr.count; i++) {
            LianLuoBook_ListModel *model =[LianLuoBook_ListModel mj_objectWithKeyValues:tarr[i]];
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
    
    if (self.isShenPi==1) {
        [WebRequest LiaisonBooks_Get_LiaisonBook_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                
            NSDictionary *dic2 =dic[Y_ITEMS];
          
            NSArray *tarr =dic2[@"list"];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                  page =dic2[@"page"];
            for (int i=0; i<tarr.count; i++) {
                LianLuoBook_ListModel *model =[LianLuoBook_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
          
           
            [tableV reloadData];
            }
           
            }
        }];
        
        
    }else
    {
    [WebRequest LiaisonBooks_Get_LiaisonBook_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2 =dic[Y_ITEMS];
       
        NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                 page =dic2[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    LianLuoBook_ListModel *model =[LianLuoBook_ListModel mj_objectWithKeyValues:tarr[i]];
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
    page =@"0";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"联络书列表";
    user =[WebRequest GetUserInfo];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审批",@"已同意",@"已拒绝"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}

-(void)addClick
{
    //新增联络书
    LianLuo_Book_AddViewController *Avc =[[LianLuo_Book_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LianLuoBook_ListModel *model =arr_model[indexPath.row];
    cell.L_left0.text =[NSString stringWithFormat:@"主题:%@",model.liasionBookTheme];
    cell.L_left1.text =[NSString stringWithFormat:@"被联络人:%@",model.objectName];
    cell.L_right1.text = model.createTime;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LianLuoBook_ListModel *model =arr_model[indexPath.row];
    LianLuoBook_DetailViewController *Dvc =[[LianLuoBook_DetailViewController alloc]init];
    Dvc.model =model;
    if(self.isShenPi==1 && segmentC.selectedSegmentIndex==0)
    {
        Dvc.isShenPi=1;
    }
    [self.navigationController pushViewController:Dvc animated:NO];
    
}


@end
