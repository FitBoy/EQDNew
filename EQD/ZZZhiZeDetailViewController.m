//
//  ZZZhiZeDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZZZhiZeDetailViewController.h"
#import "ZuZhiModel.h"
#import "GangweiModel.h"
#import "ZZDAddViewController.h"
@interface ZZZhiZeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_zuzhi;
    UserModel *user;
    UISegmentedControl *segmentC;
    ComModel *com;
    NSMutableArray *arr_titles;
    NSMutableArray *arr_gangwei;
    ZuZhiModel *selected_model;
    float width;
}

@end

@implementation ZZZhiZeDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
     [self loadGangwei];
}
-(void)loadRequestData{
    self.view.userInteractionEnabled=NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
 /*   [WebRequest Com_SelectSection_PartWithpparent:selected_model.ID And:^(NSArray *arr){
        self.view.userInteractionEnabled=YES;
        [hud hideAnimated:NO];
        [arr_zuzhi removeAllObjects];
        if (arr.count) {
            for (NSDictionary *dic1 in arr) {
                ZuZhiModel *model =[ZuZhiModel mj_objectWithKeyValues:dic1];
                [arr_zuzhi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
        
    }];*/

}
-(void)loadGangwei
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
 /*   [WebRequest Com_SelectCareer_PartWithpid:selected_model.ID And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        [arr_gangwei removeAllObjects];
        NSNumber *number =dic[Y_STATUS];
        NSArray *arr =dic[Y_ITEMS];
        if ([number integerValue]==200) {
            if (arr.count) {
                for (NSDictionary *dic1 in arr) {
                    GangweiModel *model =[GangweiModel mj_objectWithKeyValues:dic1];
                    [arr_gangwei addObject:model];
                    
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];*/
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(tableV, self);
    arr_zuzhi =[NSMutableArray arrayWithCapacity:0];
    arr_titles =[NSMutableArray arrayWithCapacity:0];
    arr_gangwei =[NSMutableArray arrayWithCapacity:0];
    user= [WebRequest GetUserInfo];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[com.name]];
    segmentC.frame = CGRectMake(0, 64, DEVICE_WIDTH, 40);
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    segmentC.selectedSegmentIndex =0;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, DEVICE_WIDTH, DEVICE_HEIGHT-104) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    
    selected_model = [[ZuZhiModel alloc]init];
    selected_model.departName = com.name;
    selected_model.departId = com.idnum;
    
    [arr_titles addObject:selected_model];
    
    width = DEVICE_WIDTH/4.0;

}
-(void)chooseClick
{
    //临时数组记录选之前的model
    NSMutableArray *tarr =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<(segmentC.selectedSegmentIndex+1); i++) {
        ZuZhiModel *model = arr_titles[i];
        [tarr addObject:model];
    }
    [segmentC removeAllSegments];
    
    
    selected_model = tarr[tarr.count-1];
    arr_titles =[NSMutableArray arrayWithArray:tarr];
    if (arr_titles.count<5) {
        segmentC.frame =CGRectMake(0, 64, DEVICE_WIDTH, 40);
    }
    else
    {
        segmentC.frame =CGRectMake(-width*(arr_titles.count-4), 64, DEVICE_WIDTH+width*(arr_titles.count-4), 40);
    }
    
    for (int i =0; i<tarr.count;i++) {
        ZuZhiModel *model1 =tarr[i];
//        [segmentC insertSegmentWithTitle:model1.dname atIndex:i animated:NO];
    }
    segmentC.selectedSegmentIndex = tarr.count-1;
    [self loadRequestData];
    [self loadGangwei];
    
}

#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_zuzhi.count;
    }
    return arr_gangwei.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section==0) {
        ZuZhiModel *model =arr_zuzhi[indexPath.row];
//        cell.textLabel.text =model.dname;
    }
    else
    {
        //岗位
        GangweiModel *model =arr_gangwei[indexPath.row];
//        cell.textLabel.text =model.careename;
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"部门";
    }
    else
    {
        return @"岗位";
    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ZuZhiModel *model = arr_zuzhi[indexPath.row];
        selected_model = model;
        if (arr_titles.count>3) {
            segmentC.frame =CGRectMake(-width*(arr_titles.count-3), 64, DEVICE_WIDTH+width*(arr_titles.count-3), 40);
        }
//        [segmentC insertSegmentWithTitle:model.dname atIndex:segmentC.selectedSegmentIndex+1 animated:NO];
        segmentC.selectedSegmentIndex+=1;
        [arr_titles addObject:model];
        
        [self loadRequestData];
        [self loadGangwei];
    }
    else
    {
        //岗位描述状态只有一种  要么添加 要么修改
        GangweiModel *model = arr_gangwei[indexPath.row];
        ZZDAddViewController *DAvc =[[ZZDAddViewController alloc]init];
        DAvc.model=model;
        [self.navigationController pushViewController:DAvc animated:NO];
    }
    
}


@end
