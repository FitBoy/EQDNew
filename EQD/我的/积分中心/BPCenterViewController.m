//
//  BPCenterViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/10.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "BPCenterViewController.h"
#import "BPDetailViewController.h"
#import "BPCenterTableViewCell.h"
#import "BPCenterHeaderFooterView.h"
#import "BPCenterTableViewCell.h"
#import <Masonry.h>
#import "BPC_qiandaoView.h"
@interface BPCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model0;
    NSMutableArray *arr_model1;
    UserModel *user;
    UIView *V_head;
    UILabel *L_scole;
    BPC_qiandaoView *BP_view;
    NSInteger  index_max;
}

@end

@implementation BPCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    //获取新手任务   日常任务
    [WebRequest BP_taskCenter_getPersonTaskWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[@"newTask"];
            for (int i=0; i<tarr.count; i++) {
                BP_renwuModel *model = [BP_renwuModel mj_objectWithKeyValues:tarr[i]];
                [arr_model0 addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
    [WebRequest BP_taskCenter_getDailyTaskFromPersonWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                BP_renwuModel *model = [BP_renwuModel mj_objectWithKeyValues:tarr[i]];
                [arr_model1 addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model0 = [NSMutableArray arrayWithCapacity:0];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    index_max = 0;
    self.navigationItem.title = @"积分中心";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"积分明细" style:UIBarButtonItemStylePlain target:self action:@selector(jifenDetailClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=75;
    tableV.sectionHeaderHeight =1;
    tableV.sectionFooterHeight =0;
    V_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 220)];
    
    UIImageView *IV_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 150)];
    IV_bg.image = [UIImage imageNamed:@"C_background"];
    IV_bg.userInteractionEnabled = YES;
    [V_head addSubview:IV_bg];
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 92, 30)];
    tlabel.font = [UIFont systemFontOfSize:15];
    tlabel.textColor = [UIColor whiteColor];
    tlabel.text = @"当前总积分：";
    [IV_bg addSubview:tlabel];
    L_scole = [[UILabel alloc]init];
    L_scole.textColor = [UIColor whiteColor];
    [IV_bg addSubview:L_scole];
    L_scole.font = [UIFont systemFontOfSize:20];
    [L_scole mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
        make.left.mas_equalTo(tlabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(tlabel.mas_centerY);
    }];
   
    BP_view = [[BPC_qiandaoView alloc]initWithFrame:CGRectMake(10, 60, DEVICE_WIDTH-20, 155)];
    BP_view.backgroundColor = [UIColor whiteColor];
    [BP_view.btn_qiandao addTarget:self action:@selector(qiandaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [V_head addSubview:BP_view];
    
    
    tableV.tableHeaderView = V_head;
    ///获取个人的积分
    [WebRequest BP_getBPFromPersonWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                L_scole.text =[NSString stringWithFormat:@"%@",dic[@"BP"]] ;
            });
          
        }
    }];
    
    
//    tableV.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
//    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [WebRequest BP_sign_GetBPsignWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr3 = dic[Y_ITEMS];
            /*
             {
             createTime = "2018-11-29 16:48:53";
             credit = 10;
             sort = 1;
             userGuid = 4f47e8c7e40541d4a2f03c3c72304252;
             }
             */
            for (int i=0; i<tarr3.count; i++) {
                NSDictionary *tdic = tarr3[i];
                if([tdic[@"sort"] integerValue] > index_max)
                {
                    index_max =[tdic[@"sort"] integerValue];
                }
            }
            
            
            NSArray *tarr2 = dic[@"rules"];
            dispatch_async(dispatch_get_main_queue(), ^{
                 [BP_view setSenvenViewWitharrScole:tarr2];
                [BP_view updateViewWithindex:index_max];
                if([dic[@"today"] integerValue]== 0)
                {
                    BP_view.btn_qiandao.enabled = YES;
                    [BP_view.btn_qiandao setTitle:@"签到" forState:UIControlStateNormal];

                    [BP_view.btn_qiandao setBackgroundColor:[UIColor colorWithRed:43/255.0 green:64/255.0 blue:173/255.0 alpha:1]];
                    [BP_view.btn_qiandao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }else
                {
                    BP_view.btn_qiandao.enabled = NO;
                    [BP_view.btn_qiandao setTitle:@"已签到" forState:UIControlStateNormal];
                    [BP_view.btn_qiandao setBackgroundColor:[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]];
                    [BP_view.btn_qiandao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            });
           
          
        
        }
    }];
    

}
-(void)qiandaoClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在签到";
    [WebRequest BP_sign_setBPsignWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [BP_view updateViewWithindex:index_max+1];
                BP_view.btn_qiandao.enabled = NO;
                [BP_view.btn_qiandao setTitle:@"已签到" forState:UIControlStateNormal];
                [BP_view.btn_qiandao setBackgroundColor:[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]];
                [BP_view.btn_qiandao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else
            {
                
            }
        });
       
    }];
}
-(void)jifenDetailClick
{
    //积分明细
    BPDetailViewController *Dvc = [[BPDetailViewController alloc]init];
    [self.navigationController pushViewController:Dvc animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *viewHeadId = @"viewHeadId";
    BPCenterHeaderFooterView  *headV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewHeadId];
    if (!headV) {
        headV = [[BPCenterHeaderFooterView alloc]initWithReuseIdentifier:viewHeadId];
    }
    if (section ==0) {
        [headV.tbtn_title setTitle:@"新手任务" forState:UIControlStateNormal];
    }else
    {
        [headV.tbtn_title setTitle:@"日常任务" forState:UIControlStateNormal];
    }
    
    return headV;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  section==0? arr_model0.count:arr_model1.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    BPCenterTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BPCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.section ==0)
    {
        BP_renwuModel *model = arr_model0[indexPath.row];
        [cell setModel_renwu:model];
    }else if (indexPath.section ==1)
    {
        BP_renwuModel *model = arr_model1[indexPath.row];
        [cell setModel_renwu:model];
    }else
    {
        
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
