//
//  CK_huoDongListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_huoDongListViewController.h"
#import "CK_huoDongModel.h"
#import "FBImg_label_yyLabelTableViewCell.h"
#import "FBRight_showViewController.h"
#import "S_huodongAddViewController.h"
#import "CKHD_detailViewController.h"
@interface CK_huoDongListViewController ()<FBRight_showViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
    UISegmentedControl *segmentC;
}

@end

@implementation CK_huoDongListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if(self.temp ==0)
    {
        [WebRequest Activity_Get_ActiveByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                for(int i=0;i<tarr.count;i++)
                {
                    CK_huoDongModel  *model = [CK_huoDongModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                page = dic[@"page"];
                [tableV reloadData];
            }
        }];
    }else
    {
        [WebRequest Activity_Get_ActiveByCompanyWithcompanyId:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                for(int i=0;i<tarr.count;i++)
                {
                    CK_huoDongModel  *model = [CK_huoDongModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                page = dic[@"page"];
                [tableV reloadData];
            }
        }];
    }
   
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadMoreData
{
    if (self.temp ==0) {
    [WebRequest Activity_Get_ActiveByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count == 0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            
            for(int i=0;i<tarr.count;i++)
            {
                CK_huoDongModel  *model = [CK_huoDongModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page = dic[@"page"];
            [tableV reloadData];
            }
        }
    }];
    }else
    {
        [WebRequest Activity_Get_ActiveByCompanyWithcompanyId:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count == 0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    
                    for(int i=0;i<tarr.count;i++)
                    {
                        CK_huoDongModel  *model = [CK_huoDongModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    page = dic[@"page"];
                    [tableV reloadData];
                }
            }
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布的活动列表";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page = @"0";
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=110;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"审核中",@"已通过"]];
    segmentC.frame =CGRectMake(0,DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
   
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
#pragma  mark - 更多的功能
-(void)getSlectedindex:(NSInteger)index;
{
    switch (index) {
        case 0:
        {
            //添加活动
            S_huodongAddViewController  *Avc = [[S_huodongAddViewController alloc]init];
            Avc.shenfenF = self.temp;
            [self.navigationController pushViewController:Avc animated:NO];
        }
            break;
        case 1:
        {
            //报名的活动
            
        }
            break;
        case 2:
        {
            //签到的活动
        }
            break;
            
        default:
            break;
    }
}
-(void)moreClick
{
    //更多功能
    
    FBRight_showViewController  *LYvc =[[FBRight_showViewController alloc]init];
    LYvc.delegate_right =self;
    LYvc.arr_names = @[@"添加活动",@"报名的活动",@"签到的活动"];
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController presentViewController:LYvc animated:NO completion:nil];
        
    });
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
FBImg_label_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBImg_label_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    CK_huoDongModel  *model = arr_model[indexPath.row];
    [cell setModel_huodong:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CK_huoDongModel  *model = arr_model[indexPath.row];
    CKHD_detailViewController  *Dvc = [[CKHD_detailViewController alloc]init];
    Dvc.Id = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
