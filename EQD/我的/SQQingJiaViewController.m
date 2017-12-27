//
//  SQQingJiaViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQQingJiaViewController.h"
#import "QJ_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
@interface SQQingJiaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString  *selected_page;
    NSMutableArray *arr_qingjia;
}

@end

@implementation SQQingJiaViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"102" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    [WebRequest Get_Leave_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_qingjia removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            selected_page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    QingJiaListModel *model =[QingJiaListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_qingjia addObject:model];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
        
        
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Get_Leave_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:selected_page type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            
            NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                selected_page =dic2[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    QingJiaListModel *model =[QingJiaListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_qingjia addObject:model];
                }
            }
            [tableV reloadData];
        }
      
        
      

        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_qingjia =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"请假申请";
    adjustsScrollViewInsets_NO(tableV, self);
    segmentC = [[UISegmentedControl alloc]initWithItems:@[@"审批中",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentC];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    selected_page =@"0";
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    

    
}
-(void)addClick
{
    if ([user.companyId integerValue]!=0) {
        SQQingJiaAddViewController *QJvc =[[SQQingJiaAddViewController alloc]init];
        [self.navigationController pushViewController:QJvc animated:NO];
 
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"您不在企业，无法进行该操作";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
-(void)chooseClick
{
    //选择
    selected_page =@"0";
    [self loadRequestData];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_qingjia.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    QingJiaListModel *model =arr_qingjia[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QingJiaListModel *model =arr_qingjia[indexPath.row];
    QJ_DetailViewController *Dvc =[[QJ_DetailViewController alloc]init];
    Dvc.model=model;
    Dvc.isshenpi=1;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
