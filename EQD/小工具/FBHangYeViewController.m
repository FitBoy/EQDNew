//
//  FBHangYeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBHangYeViewController.h"
#import "FBHnagYeModel.h"
@interface FBHangYeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_hangye;
    UISegmentedControl *segMC;
    NSIndexPath *slelectd_indexPath;
     NSIndexPath *slelectd_indexPath_one;
    NSIndexPath *selected_two;
    UIBarButtonItem *right;
}

@end

@implementation FBHangYeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
   [WebRequest Option_AreasAndWithtype:2 And:^(NSArray *arr) {
    
        if (arr.count) {
            for (NSDictionary *dic1 in arr) {
                FBHnagYeModel *model = [FBHnagYeModel mj_objectWithKeyValues:dic1];
                [arr_hangye addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"行业分类";
    adjustsScrollViewInsets_NO(tableV, self);
    right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    arr_hangye = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=45;
    
    segMC =[[UISegmentedControl alloc]initWithItems:@[@"大类行业"]];
    [self.view addSubview:segMC];
    segMC.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 30);
    segMC.selectedSegmentIndex=0;
    
    [segMC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    right.enabled=NO;
    
}
-(void)chooseClick
{
    if (segMC.selectedSegmentIndex==0) {
        [segMC removeSegmentAtIndex:2 animated:YES];
        [segMC removeSegmentAtIndex:1 animated:YES];
        right.enabled=NO;
        [tableV reloadData];
    }
    else if(segMC.selectedSegmentIndex==1)
    {
        [segMC removeSegmentAtIndex:2 animated:YES];
        [tableV reloadData];
        right.enabled=NO;
    }
   else
   {
       right.enabled=YES;
   }
}
-(void)quedingClick
{
    //确定
    
    FBHnagYeModel *model =arr_hangye[slelectd_indexPath.row];
    FBHnagYeModel *model1 =model.children[slelectd_indexPath_one.row];
    FBHnagYeModel *model2 =model1.children[selected_two.row];
    
    NSString *hangye =[NSString stringWithFormat:@"%@-%@",model2.name,model2.code];
    if ([self.delegate respondsToSelector:@selector(hangye:Withindexpath:)]) {
        [self.delegate hangye:hangye Withindexpath:self.indexPath];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (segMC.selectedSegmentIndex==0) {
        return arr_hangye.count;
    }
  else if (segMC.selectedSegmentIndex==1) {
        FBHnagYeModel *model = arr_hangye[slelectd_indexPath.row];
        return model.children.count;
    }
    else
    {
        FBHnagYeModel *model = arr_hangye[slelectd_indexPath.row];
        FBHnagYeModel *model1 = model.children[slelectd_indexPath_one.row];
        return model1.children.count;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FBHnagYeModel *model =arr_hangye[indexPath.row];
    if (segMC.selectedSegmentIndex==0) {
        cell.textLabel.text =model.name;
    }
    else if (segMC.selectedSegmentIndex==1) {
        FBHnagYeModel *model =arr_hangye[slelectd_indexPath.row];
        FBHnagYeModel *model1 =model.children[indexPath.row];
        cell.textLabel.text= model1.name;
    }
    else
    {
        FBHnagYeModel *model =arr_hangye[slelectd_indexPath.row];
        FBHnagYeModel *model1 =model.children[slelectd_indexPath_one.row];
        FBHnagYeModel *model2 =model1.children[indexPath.row];
        cell.textLabel.text = model2.name;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (segMC.selectedSegmentIndex==0) {
        FBHnagYeModel *model =arr_hangye[indexPath.row];
        [segMC setTitle:model.name forSegmentAtIndex:0];
        [segMC insertSegmentWithTitle:@"中级分类" atIndex:1 animated:YES];
        slelectd_indexPath = indexPath;
        segMC.selectedSegmentIndex = 1;
        [tableV reloadData];
    }
   else if(segMC.selectedSegmentIndex ==1)
   {
       FBHnagYeModel *model =arr_hangye[slelectd_indexPath.row];
       FBHnagYeModel *model1 =model.children[indexPath.row];
       [segMC setTitle:model1.name forSegmentAtIndex:1];
       [segMC insertSegmentWithTitle:@"小级分类" atIndex:2 animated:YES];
       slelectd_indexPath_one = indexPath;
       segMC.selectedSegmentIndex = 2;
       [tableV reloadData];
   }
    else
    {
        FBHnagYeModel *model =arr_hangye[slelectd_indexPath.row];
        FBHnagYeModel *model1 =model.children[slelectd_indexPath_one.row];
        FBHnagYeModel *model2 =model1.children[indexPath.row];
        [segMC setTitle:model2.name forSegmentAtIndex:2];
        segMC.selectedSegmentIndex = 2;
        selected_two =indexPath;
        [tableV reloadData];
        right.enabled=YES;
    }
}

@end
