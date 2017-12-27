//
//  FBBuMenChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBuMenChooseViewController.h"
@interface FBBuMenChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation FBBuMenChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_SelectPostWithdepartId:self.departId companyId:self.comId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                GangweiModel *model =[GangweiModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
        }
        [tableV reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"岗位选择";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
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
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    GangweiModel  *model =arr_model[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GangweiModel *model =arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getGangWei:)]) {
        [self.delegate getGangWei:model];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    
}



@end
