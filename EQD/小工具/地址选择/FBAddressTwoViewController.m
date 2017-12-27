//
//  FBAddressTwoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBAddressTwoViewController.h"
#import "FBAddressModel.h"
@interface FBAddressTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr_address;
    UITableView *tableV;
    UISegmentedControl *segmentC;
    UIBarButtonItem *right;
    NSIndexPath *selected_indexpath;
    NSIndexPath *selected_indexPath2;
}

@end

@implementation FBAddressTwoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Option_AreasAndWithtype:0 And:^(NSArray *arr) {
        [arr_address removeAllObjects];
        
        if (arr.count) {
            for (NSDictionary *dic1 in arr) {
                FBAddressModel *model = [FBAddressModel mj_objectWithKeyValues:dic1];
                [arr_address addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"地区";
    arr_address=[NSMutableArray arrayWithCapacity:0];
    
    segmentC = [[UISegmentedControl alloc]initWithItems:@[@"省"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    right.enabled=NO;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
    

}
-(void)chooseClick
{
    //上面的选择
    if (segmentC.selectedSegmentIndex==1) {
        
    }
    else
    {
        right.enabled=NO;
        [segmentC removeSegmentAtIndex:1 animated:NO];
        segmentC.selectedSegmentIndex=0;
        [tableV reloadData];
    }
}
-(void)quedingClick
{
    //确定
    FBAddressModel *model1 =arr_address[selected_indexpath.row];
    FBAddressModel *model2 =model1.sub[selected_indexPath2.row];
    NSArray *tarr = @[model1.name,model2.name];
    NSString *tstr = [NSString stringWithFormat:@"%@  %@",model1.name,model2.name];
    if ([self.delegate respondsToSelector:@selector(address2:indexPath:arr_address:)]) {
        [self.delegate address2:tstr indexPath:self.indexPath arr_address:tarr];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arr_address.count) {
        FBAddressModel *model = arr_address[selected_indexpath.row];
        return  segmentC.selectedSegmentIndex==0?arr_address.count:model.sub.count;
    }
    else
        
    {
        return 0;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
   
    if (segmentC.selectedSegmentIndex==0) {
         FBAddressModel *model =arr_address[indexPath.row];
        cell.textLabel.text =model.name;
    }
    else
    {
         FBAddressModel *model =arr_address[selected_indexpath.row];
        FBAddressModel *model1 =model.sub[indexPath.row];
        cell.textLabel.text =model1.name;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (segmentC.selectedSegmentIndex==0) {
        FBAddressModel *model = arr_address[indexPath.row];
        [segmentC setTitle:model.name forSegmentAtIndex:0];
        [segmentC insertSegmentWithTitle:@"市" atIndex:1 animated:NO];
        segmentC.selectedSegmentIndex=1;
        selected_indexpath = indexPath;
        [tableV reloadData];
        
    }
    else
    {
        FBAddressModel *model1 =arr_address[selected_indexpath.row];
        FBAddressModel *model2 =model1.sub[indexPath.row];
        [segmentC setTitle:model2.name forSegmentAtIndex:1];
        selected_indexPath2=indexPath;
        right.enabled=YES;
    }
}


@end
