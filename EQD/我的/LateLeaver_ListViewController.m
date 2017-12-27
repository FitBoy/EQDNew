//
//  LateLeaver_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LateLeaver_ListViewController.h"
#import "LateLeaver_AddViewController.h"
#import "LateLeaver_DetailViewController.h"
@interface LateLeaver_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation LateLeaver_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString  *code =nil;
    if (self.isShenpi==0) {
        code =@"262";
    }else if (self.isShenpi==3)
    {
        code = @"282";
    }else if (self.isShenpi==1)
    {
        code =@"260";
    }else if (self.isShenpi==4)
    {
        code =@"280";
    }else if (self.isShenpi==2)
    {
        code=@"261";
    }else if (self.isShenpi==5)
    {
        code=@"281";
    }
    else
    {
    }
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    if (self.isShenpi==1) {
        [WebRequest Sickleaves_Get_SickleaveByLeaderWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        }];

    }else if (self.isShenpi==2)
    {
        [WebRequest Sickleaves_Get_Sickleave_ByHRWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];

        }];
        
    }else if (self.isShenpi==3)
    {
        [WebRequest Sickleaves_Get_MissClock_ByCreaterWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
    
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        }];
    }else if (self.isShenpi==4)
    {
        [WebRequest Sickleaves_Get_MissClock_ByLeaderWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {

            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];

        }];
    }else if (self.isShenpi==5)
    {
        [WebRequest Sickleaves_Get_MissClock_ByHRWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
 
        }];
    }
    else
    {
    [WebRequest Sickleaves_Get_SickLeaveByUserWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
        [arr_model removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        for (int i=0; i<tarr.count; i++) {
            LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
    }
    
}
-(void)loadOtherData
{
    if (self.isShenpi==1) {
        [WebRequest Sickleaves_Get_SickleaveByLeaderWithuserGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            
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
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                    [tableV reloadData];
                }
                
            }
          
        }];
        
    }else if (self.isShenpi==2)
    {
        [WebRequest Sickleaves_Get_Sickleave_ByHRWithuserGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
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
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                    
                    [tableV reloadData];
                }
            }
         
        }];
        
    }else if (self.isShenpi==3)
    {
        //申请人的漏打卡列表
        [WebRequest Sickleaves_Get_MissClock_ByCreaterWithuserGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex]  And:^(NSDictionary *dic) {
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
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                   
                    [tableV reloadData];
                }
            }
           
        }];
    }else if (self.isShenpi==4)
    {
        [WebRequest Sickleaves_Get_MissClock_ByLeaderWithuserGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
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
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                  
                    [tableV reloadData];
                }
            }
           
        }];
    }else if (self.isShenpi==5)
    {
        [WebRequest Sickleaves_Get_MissClock_ByHRWithuserGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
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
                LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                  
                    [tableV reloadData];
                }
            }
            
        }];
    }
    
    else
    {
    [WebRequest Sickleaves_Get_SickLeaveByUserWithuserGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
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
            LaterModel *model =[LaterModel mj_objectWithKeyValues:tarr[i]];
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
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =self.isShenpi<3?@"迟到早退列表":@"漏打卡列表";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审核",@"已审核"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    LaterModel *model =arr_model[indexPath.row];
    cell.textLabel.text =self.isShenpi<3?[NSString stringWithFormat:@"要消的迟到早退日期:%@",model.date]:[NSString stringWithFormat:@"要消的漏打卡日期:%@",model.date];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   LaterModel *model =arr_model[indexPath.row];
    LateLeaver_DetailViewController *Dvc =[[LateLeaver_DetailViewController alloc]init];
    if (self.isShenpi==1 && segmentC.selectedSegmentIndex==0) {
        Dvc.isShenPi=1;
    }else if (self.isShenpi==2 && segmentC.selectedSegmentIndex==0 )
    {
        Dvc.isShenPi =2;
    }else if (self.isShenpi==3)
    {
        Dvc.isShenPi = 3;
    }else if (self.isShenpi==4)
    {
        Dvc.isShenPi= segmentC.selectedSegmentIndex==0?4:3;
    }else if (self.isShenpi==5)
    {
        Dvc.isShenPi =segmentC.selectedSegmentIndex==0?5:3;
    }
    else
    {
        Dvc.isShenPi=0;
    }
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}

-(void)addClick
{
   
    LateLeaver_AddViewController *avc =[[LateLeaver_AddViewController alloc]init];
    avc.isLou=self.isShenpi<3?0:1;
    [self.navigationController pushViewController:avc animated:NO];
}



@end
