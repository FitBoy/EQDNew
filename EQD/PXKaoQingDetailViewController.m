//
//  PXKaoQingDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXKaoQingDetailViewController.h"
#import "PXQianDaoListTableViewCell.h"
#import "PXKaoQinListModel.h"
#import <Masonry.h>
#import "FBButton.h"
#import "PXKaoQin_ErWeiMaViewController.h"
@interface PXKaoQingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_model;
    UIView *V_top;
    
    NSInteger temp_section;// 0正常的签到情况  ；1 按时间正序；2 按时间倒序 ；3：已签到 ；4 未签到；
}

@end

@implementation PXKaoQingDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    if(temp_section ==1)
    {
       // 时间正序
        [WebRequest Training_Get_signDetail_OBTWithuserGuid:user.Guid siInfoId:self.model.Id type:@"0" page:@"0" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                 page =dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel  *model = [PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }else if (temp_section==2)
    {
        //时间反
        
        [WebRequest Training_Get_signDetail_OBTWithuserGuid:user.Guid siInfoId:self.model.Id type:@"1" page:@"0" And:^(NSDictionary *dic) {
             [hud hideAnimated:NO];
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                 page =dic[@"nextpage"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel  *model = [PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp_section==3)
    {
        //已签到
        
        [WebRequest Training_Get_signDetail_sOrnsWithuserGuid:user.Guid siInfoId:self.model.Id type:@"0" page:@"0" And:^(NSDictionary *dic) {
             [hud hideAnimated:NO];
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                page = dic[@"nextpage"];
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp_section==4)
    {
       ///未签到
        [WebRequest Training_Get_signDetail_sOrnsWithuserGuid:user.Guid siInfoId:self.model.Id type:@"1" page:@"0" And:^(NSDictionary *dic) {
             [hud hideAnimated:NO];
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                page = dic[@"nextpage"];
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
    [WebRequest Training_Get_signInDetailsWithuserGuid:user.Guid siInfoId:self.model.Id page:@"0" And:^(NSDictionary *dic) {
         [hud hideAnimated:NO];
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"nextpage"];
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }
}
-(void)loadOtherData{
    if(temp_section ==1)
    {
        // 时间正序
        [WebRequest Training_Get_signDetail_OBTWithuserGuid:user.Guid siInfoId:self.model.Id type:@"0" page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                     page =dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel  *model = [PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp_section==2)
    {
        //时间反
        
        [WebRequest Training_Get_signDetail_OBTWithuserGuid:user.Guid siInfoId:self.model.Id type:@"1" page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                 page =dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel  *model = [PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp_section==3)
    {
        //已签到
        [WebRequest Training_Get_signDetail_sOrnsWithuserGuid:user.Guid siInfoId:self.model.Id type:@"0" page:page And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
               
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                     page = dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
       
    }else if (temp_section==4)
    {
        ///未签到
        [WebRequest Training_Get_signDetail_sOrnsWithuserGuid:user.Guid siInfoId:self.model.Id type:@"1" page:page And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
              
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                      page = dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else
    {
    [WebRequest Training_Get_signInDetailsWithuserGuid:user.Guid siInfoId:self.model.Id page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
           
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                 page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                PXKaoQinListModel *model =[PXKaoQinListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)setTableVTop{
    V_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 100)];
    V_top.userInteractionEnabled =YES;
    UILabel *L_title = [[UILabel alloc]init];
    L_title.textAlignment = NSTextAlignmentCenter;
    [V_top addSubview:L_title];
    L_title.numberOfLines =2;
    L_title.font = [UIFont systemFontOfSize:16];
    L_title.text =self.model.theTheme;
    [L_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-30, 45));
        make.left.mas_equalTo(V_top.mas_left).mas_offset(15);
        make.top.mas_equalTo(V_top.mas_top).mas_offset(5);
    }];
    
    
    
    UILabel *L_EWM = [[UILabel alloc]init];
    [V_top addSubview:L_EWM];
    L_EWM.userInteractionEnabled =YES;
    L_EWM.text =@"签到";
    L_EWM.font = [UIFont systemFontOfSize:18];
    [L_EWM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 30));
        make.top.mas_equalTo(L_title.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(V_top.mas_left).mas_offset(20);
    }];
    UITapGestureRecognizer  *tap_EWM = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_EWMClick)];
    [L_EWM addGestureRecognizer:tap_EWM];
    
    UIImageView  *IV_EWM = [[UIImageView alloc]init];
    [V_top addSubview:IV_EWM];
    IV_EWM.userInteractionEnabled =YES;
    IV_EWM.image = [UIImage imageNamed:@"erweimalogo"];
     UITapGestureRecognizer  *tap_IVEWM = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_EWMClick)];
    [IV_EWM addGestureRecognizer:tap_IVEWM];
    
    [IV_EWM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.mas_equalTo(L_title.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(L_EWM.mas_right).mas_offset(5);
    }];
    
    
    FBButton *B_shaixuan = [FBButton buttonWithType:UIButtonTypeSystem];
    [B_shaixuan setTitle:@"筛选" titleColor: [UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [V_top addSubview:B_shaixuan];
    [B_shaixuan addTarget:self action:@selector(shaixuanCLick) forControlEvents:UIControlEventTouchUpInside];
    
    [B_shaixuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 30));
        make.right.mas_equalTo(V_top.mas_right).mas_offset(-15);
        make.top.mas_equalTo(L_title.mas_bottom).mas_offset(5);
    }];
    
    FBButton  *B_FenXi = [FBButton buttonWithType:UIButtonTypeSystem];
    [V_top addSubview:B_FenXi];
   
    [B_FenXi setTitle:@"出勤分析" titleColor: [UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [B_FenXi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 30));
        make.top.mas_equalTo(L_title.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(B_shaixuan.mas_left).mas_offset(-10);
    }];
    [B_FenXi addTarget:self action:@selector(fenxiClick) forControlEvents:UIControlEventTouchUpInside];
    V_top.backgroundColor = [UIColor brownColor];
    V_top.alpha = 0.9;

    tableV.tableHeaderView = V_top;
    
}
#pragma  mark - 出勤分析
-(void)fenxiClick{
    
}
#pragma  mark - 筛选
-(void)shaixuanCLick{
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"查看方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *tarr = @[@"未签到",@"已签到",@"按时间正序",@"按时间倒序",@"查看全部"];
    for(int i=0;i<tarr.count;i++)
    {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (i==0) {
                //未签到
                temp_section =4;
            }else if (i==1)
            {
                //已签到
                temp_section =3;
            }else if (i==2)
            {
                //按时间正序
                temp_section =1;
            }else if (i==3)
            {
                //按时间倒序
                temp_section =2;
              
            }else
            {
                temp_section =0;
            }
              [self loadRequestData];
        }]];
        
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
}

#pragma  mark - 查看签到二维码
-(void)tap_EWMClick
{
    PXKaoQin_ErWeiMaViewController *Evc = [[PXKaoQin_ErWeiMaViewController alloc]init];
    Evc.model_qiandao = self.model;
    [self.navigationController pushViewController:Evc animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"培训考勤统计与分析";
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [self setTableVTop];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    PXQianDaoListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PXQianDaoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PXKaoQinListModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}




@end
