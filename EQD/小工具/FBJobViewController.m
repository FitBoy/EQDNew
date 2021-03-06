//
//  FBJobViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBJobViewController.h"

@interface FBJobViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_job;
    UISegmentedControl *segmentC;
    NSIndexPath *indexpath_one;
    NSIndexPath *indexPath_two;
    UIBarButtonItem *right;
    
}

@end

@implementation FBJobViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Option_AreasAndWithtype:1 And:^(NSArray *arr) {
        if (arr.count) {
            for (NSDictionary *dic1 in arr) {
                JobModel *model = [JobModel mj_objectWithKeyValues:dic1];
                [arr_job addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }

    }];
    
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_job =[NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title = @"岗位类型";
    segmentC=[[UISegmentedControl alloc]initWithItems:@[@"一级分类"]];
    [self.view addSubview:segmentC];
    segmentC.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClik)];
    right.enabled=NO;
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClik
{
    //确定
    JobModel *model = arr_job[indexpath_one.row];
    JobModel *model2 =model.sub[indexPath_two.row];
    AllModel  *amodel = [[AllModel alloc]init];
    amodel.name = model.name;
    amodel.code=model.code;
    
    amodel.child_name =model2.name;
    amodel.child_code =model2.code;
    if ([self.delegate respondsToSelector:@selector(model:indexPath:)]) {
        [self.delegate model:amodel indexPath:self.indexPath];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
-(void)chooseClick
{
    if (segmentC.selectedSegmentIndex==0) {
        [segmentC removeSegmentAtIndex:1 animated:NO];
        [segmentC setTitle:@"一级分类" forSegmentAtIndex:0];
        right.enabled=NO;
        [tableV reloadData];
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(segmentC.selectedSegmentIndex==0)
    {
        return arr_job.count;
    }
   else
   {
       JobModel *model =arr_job[section];
       return model.sub.count;
   }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if(segmentC.selectedSegmentIndex==0)
    {
        JobModel *model = arr_job[indexPath.row];
        indexpath_one = indexPath;
        cell.textLabel.text =model.name;
    }
    else
    {
       JobModel *model = arr_job[indexpath_one.row];
        JobModel *model1 =model.sub[indexPath.row];
        cell.textLabel.text = model1.name;
        
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (segmentC.selectedSegmentIndex==0) {
        JobModel *model = arr_job[indexPath.row];
        [segmentC setTitle:model.name forSegmentAtIndex:0];
        [segmentC insertSegmentWithTitle:@"二级分类" atIndex:1 animated:NO];
        indexpath_one=indexPath;
        segmentC.selectedSegmentIndex=1;
        right.enabled=NO;
        [tableV reloadData];
    }
    else
    {
        JobModel *model = arr_job[indexpath_one.row];
        JobModel *model1 =model.sub[indexPath.row];
        [segmentC setTitle:model1.name forSegmentAtIndex:1];
        indexPath_two =indexPath;
        right.enabled=YES;
    }
}



@end
