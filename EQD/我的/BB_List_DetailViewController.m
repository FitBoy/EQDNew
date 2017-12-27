//
//  BB_List_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BB_List_DetailViewController.h"
#import "FBBanBieTableViewCell.h"
@interface BB_List_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_banBie;
    UserModel *user;
}

@end

@implementation BB_List_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Get_RuleShiftWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        [arr_banBie removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                BanbieModel *model =[BanbieModel mj_objectWithKeyValues:tarr[i]];
                [arr_banBie addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =[NSString stringWithFormat:@"%@班别列表",user.company];
    arr_banBie =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=140;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_banBie.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBBanBieTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBBanBieTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    BanbieModel *model =arr_banBie[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanbieModel *model =arr_banBie[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(model:indexPath:)]) {
        [self.delegate model:model indexPath:self.indexPath];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}




@end
