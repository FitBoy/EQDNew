//
//  ActiveFenLeiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "ActiveFenLeiViewController.h"
#import "Option50Model.h"
@interface ActiveFenLeiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ///一级分类
    UITableView *tableV;
    ///二级分类
    UITableView *tableV2;
    NSMutableArray *arr_model;
    NSMutableArray *arr_model2;
    NSInteger temp;
    
}

@end

@implementation ActiveFenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    temp =0;
    arr_model = [NSMutableArray arrayWithCapacity:0];
    arr_model2 = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"活动分类";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, (DEVICE_WIDTH-30)/2.0, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=55;
  
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake((DEVICE_WIDTH-30)/2.0, DEVICE_TABBAR_Height, (DEVICE_WIDTH-30)/2.0, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV2, self);
    tableV2.delegate=self;
    tableV2.dataSource=self;
    [self.view addSubview:tableV2];
    tableV2.rowHeight=50;
    
    [WebRequest  Option_AreasAndWithtype:50 And:^(NSArray *arr) {
        [arr_model removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            Option50Model  *model = [Option50Model mj_objectWithKeyValues:arr[i]];
            [arr_model addObject:model];
        }
        [arr_model2 removeAllObjects];
        Option50Model *tmodel = arr_model[0];
        for (int i=0; i<tmodel.children.count; i++) {
            Option50Model *model = [Option50Model mj_objectWithKeyValues:tmodel.children[i]];
            [arr_model2 addObject:model];
        }
        [tableV reloadData];
        [tableV2 reloadData];
        
     
    }];
   
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableV == tableView) {
        return arr_model.count;
    }else
    {
        return arr_model2.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (tableView ==tableV) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        Option50Model *model = arr_model[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = model.name;
       
        
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        Option50Model *model = arr_model2[indexPath.row];
        cell.textLabel.text = model.name;
        
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV == tableView) {
        Option50Model *model = arr_model[indexPath.row];
        [arr_model2 removeAllObjects];
        for (int i=0; i<model.children.count; i++) {
            Option50Model  *tmodel = [Option50Model mj_objectWithKeyValues:model.children[i]];
            [arr_model2 addObject:tmodel];
        }
        [tableV2 reloadData];
    }else
    {
        if ([self.delegate_class respondsToSelector:@selector(getClass:WithIndexPath:)]) {
            [self.navigationController popViewControllerAnimated:NO];
            Option50Model *model = arr_model2[indexPath.row];
            [self.delegate_class getClass:model.name WithIndexPath:self.indexpath];
            
        }
    }
}






@end
