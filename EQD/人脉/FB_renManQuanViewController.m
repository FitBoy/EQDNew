//
//  FB_renManQuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_renManQuanViewController.h"
#import "MaiMaiModel.h"
#import "MaiMai_TableViewCell.h"
#import "PPersonCardViewController.h"
#import "FBindexTapGestureRecognizer.h"
#import "FB_OnlyForLiuYanViewController.h"
@interface FB_renManQuanViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel  *user;
    UISegmentedControl *segmentC;
    MaiMaiModel  *model_selected;
}

@end

@implementation FB_renManQuanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    //@[@"前同事",@"校友",@"老乡",@"同行"]
    switch (segmentC.selectedSegmentIndex) {
        case 0:
        {
            //前同事
            [WebRequest HumanVein_Get_FormerColleagueWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    page= dic[@"page"];
                    [arr_model removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                   
                    
                    [tableV reloadData];
                }
            }];
        }
            break;
        case 1:
        {
           //校友
            [WebRequest HumanVein_Get_AlumnusWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    page= dic[@"page"];
                    [arr_model removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
        case 2:
        {
            //老乡
            [WebRequest HumanVein_Get_HomeTownWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    page= dic[@"page"];
                    [arr_model removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
        case 3:
        {
           //同行
            [WebRequest HumanVein_Get_PeerWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    page= dic[@"page"];
                    [arr_model removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
            
        default:
            break;
    }
    
}
-(void)loadMoreData{
    switch (segmentC.selectedSegmentIndex) {
        case 0:
        {
            //前同事
            [WebRequest HumanVein_Get_FormerColleagueWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    if (tarr.count ==0) {
                        [tableV.mj_footer endRefreshingWithNoMoreData];
                    }else
                    {
                    page= dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                    }
                }
            }];
        }
            break;
        case 1:
        {
            //校友
            [WebRequest HumanVein_Get_AlumnusWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    if (tarr.count ==0) {
                        [tableV.mj_footer endRefreshingWithNoMoreData];
                    }else
                    {
                    page= dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                    }
                }
            }];
        }
            break;
        case 2:
        {
            //老乡
            [WebRequest HumanVein_Get_HomeTownWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    if (tarr.count ==0) {
                        [tableV.mj_footer endRefreshingWithNoMoreData];
                    }else
                    {
                    page= dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                    }
                }
            }];
        }
            break;
        case 3:
        {
            //同行
            [WebRequest HumanVein_Get_PeerWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    if (tarr.count==0) {
                        [tableV.mj_footer endRefreshingWithNoMoreData];
                    }else
                    {
                    page= dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        MaiMaiModel *model = [MaiMaiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                    }
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"人脉";
    user = [WebRequest GetUserInfo];
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"前同事",@"校友",@"老乡",@"同行"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 45);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    segmentC.tintColor = EQDCOLOR;
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+45, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-45) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=80;
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
    MaiMai_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MaiMai_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    MaiMaiModel *Model = arr_model[indexPath.row];
    [cell setModel_maimai:Model];
    cell.B_add.indexpath = indexPath;
    [cell.B_add addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    FBindexTapGestureRecognizer  *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick:)];
    tap_head.indexPath = indexPath;
    [cell.IV_head addGestureRecognizer:tap_head];
    return cell;
}
-(void)tap_headClick:(FBindexTapGestureRecognizer*)tap{
    MaiMaiModel *model = arr_model[tap.indexPath.row];
    PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid = model.userGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}
-(void)addFriend:(FBButton*)tbtn
{
    model_selected= arr_model[tbtn.indexpath.row];
    
    FB_OnlyForLiuYanViewController *LYvc = [[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.delegate = self;
    LYvc.btnName = @"加好友";
    LYvc.placeHolder = @"请输入验证信息";
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:LYvc animated:NO completion:nil];
    
}
#pragma  mark - 加好友
-(void)getPresnetText:(NSString *)text
{
    if (text.length ==0) {
        text=@" ";
    }
    
    [WebRequest User_AddFriendWithuserid:user.Guid friendid:model_selected.userGuid content:text And:^(NSDictionary *dic) {
         MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"申请成功,等待对方同意"];
            [arr_model removeObject:model_selected];
            [tableV reloadData];
        }else
        {
            [alert showAlertWith:dic[Y_MSG]];
        }
    }];
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
