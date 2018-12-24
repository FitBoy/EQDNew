//
//  Com_searchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/20.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "Com_searchViewController.h"
#import "Com_searchTableViewCell.h"
#import "FBTwoButtonView.h"
#import "FBAddressTwoViewController.h"
#import "FBHangYeViewController.h"
#import "WS_comDetailViewController.h"
@interface Com_searchViewController ()<FBHangYeViewControllerDelegate,FBAddressTwoViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    
    //搜索的参数
    NSString *para;
    NSString *adress;
    NSString * hangye_;
    NSString *isAuthen;
    
    // 侧边
    UITableView *tableV1;
    NSMutableArray *arr_names;
    FBTwoButtonView *twoBtn;
    
}

@end

@implementation Com_searchViewController
#pragma  mark - 行业
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    hangye_ = tarr[0];
    [arr_names replaceObjectAtIndex:indexpath.row withObject:tarr[0]];
    [tableV1 reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark - 地区
-(void)address2:(NSString*)address indexPath:(NSIndexPath*)indexpath arr_address:(NSArray*)arr_address
{
    if (arr_address.count>0) {
        adress = arr_address[1];
        [arr_names replaceObjectAtIndex:indexpath.row withObject:arr_address[1]];
        [tableV1 reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}

-(void)loadRequestData{
    [WebRequest Com_searchComWithpage:@"0" para:para adress:adress hangye:hangye_ isAuthen:isAuthen And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count < 12) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            [arr_model removeAllObjects];
            page =dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                Com_searchModel *model = [Com_searchModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData
{
    [WebRequest Com_searchComWithpage:page para:para adress:adress hangye:hangye_ isAuthen:isAuthen And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            page =dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                Com_searchModel *model = [Com_searchModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)setParaInit
{
    arr_names = [NSMutableArray arrayWithArray:@[@"所在地",@"所属行业",@"企业认证",@" "]];
    para =@" ";
    adress =@" ";
    hangye_ =@" ";
    isAuthen = @"-1";
}
#pragma  mark - 点击搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    para = searchBar.text;
    [self loadRequestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业搜索";
    [self setParaInit];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7+40, DEVICE_WIDTH, DEVICE_HEIGHT-kNavBarHAbove7-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=75;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    ///侧边弹出框
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-220, kNavBarHAbove7+5, 200,60*9 ) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=50;
    tableV1.hidden = YES;
    tableV1.sectionHeaderHeight = 1;
    tableV1.sectionFooterHeight =1;
    
    //底部栏
    twoBtn = [[FBTwoButtonView alloc]init];
    [twoBtn setleftname:@"重置" rightname:@"确定"];
    [twoBtn.B_left addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    
    [twoBtn.B_right addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventTouchUpInside];
    
  [self loadRequestData];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(com_shaiXuanClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)chongzhi
{
    [self setParaInit];
    [tableV1 reloadData];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tableV1.hidden =YES;
    [self.view endEditing:YES];
}

-(void)com_shaiXuanClick
{
    tableV1.hidden = !tableV1.hidden;
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableV1 ==tableView) {
        return 50;
    }else
    {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableV1 ==tableView)
    {
        return arr_names.count;
    }else
    {
    return arr_model.count;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView ==tableV1) {
        return twoBtn;
    }else
    {
        return nil;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableV == tableView) {
        static NSString *cellId=@"cellID";
        Com_searchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[Com_searchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        Com_searchModel *model =arr_model[indexPath.row];
        [cell setModel_com:model];
        
        return cell;
    }else
    {
        static NSString *cellid1 = @"cellId1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = arr_names[indexPath.row];
        return cell;
        
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (tableView ==tableV) {
        Com_searchModel *model =arr_model[indexPath.row];
        
        WS_comDetailViewController *Wvc =[[WS_comDetailViewController alloc]init];
        Wvc.comId =model.Id;
        [self.navigationController pushViewController:Wvc animated:NO];
    }else
    {
        switch (indexPath.row) {
            case 0:
            {
                //所在地
                FBAddressTwoViewController  *Avc = [[FBAddressTwoViewController alloc]init];
                Avc.indexPath =indexPath;
                Avc.delegate = self;
                [self.navigationController pushViewController:Avc animated:NO];
                
            }
                break;
                case 1:
            {
                //所属行业
                FBHangYeViewController *Hvc = [[FBHangYeViewController alloc]init];
                Hvc.delegate =self;
                Hvc.indexPath =indexPath;
                [self.navigationController pushViewController:Hvc animated:NO];
                
            }
                break;
                case 2:
            {
                UIAlertController  *alert  = [[UIAlertController alloc]init];
                
                NSArray *tarr = @[@"不限",@"已认证",@"未认证"];
                for (int i=0; i<tarr.count; i++) {
                    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (i==0) {
                            isAuthen =@"-1";
                        }else if (i==1)
                        {
                            isAuthen =@"1";
                        }else
                        {
                            isAuthen =@"0";
                        }
                        [arr_names replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                        [tableV1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }]];
                }
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];

                });
            }
                break;
                
            default:
                break;
        }
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
