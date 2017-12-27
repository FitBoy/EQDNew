//
//  DAYaoQingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DAYaoQingViewController.h"
#import "YQChengYuanViewController.h"
@interface DAYaoQingViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_big;
    NSMutableArray *tarr;
}

@end

@implementation DAYaoQingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest  User_getcompostWithcomid:user.companyId userGuid:user.Guid And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSArray *tarr1 = dic[Y_ITEMS];
            [tarr removeAllObjects];
            [arr_big removeAllObjects];
            if (tarr1.count) {
                for (int i=0; i<tarr1.count; i++) {
                    GangweiModel *model = [GangweiModel mj_objectWithKeyValues:tarr1[i]];
                    [tarr addObject:model];
                    [arr_big addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
            }
        }
    }];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title =@"选择岗位";
    user =[WebRequest GetUserInfo];
    arr_big = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索岗位";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_big =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchText];
        arr_big = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_big.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    GangweiModel *model = arr_big[indexPath.row];
    cell.textLabel.text = model.name;
    if ([model.dename isEqualToString:@"0"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"所属部门：%@",user.company];
  
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"所属部门：%@",model.dename];
 
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GangweiModel *model =arr_big[indexPath.row];
    YQChengYuanViewController *CYvc =[[YQChengYuanViewController alloc]init];
    CYvc.model =model;
    CYvc.name_bumen =model.dename;
    [self.navigationController pushViewController:CYvc animated:NO];
    
   
}




@end
