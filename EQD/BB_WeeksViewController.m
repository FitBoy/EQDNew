//
//  BB_WeeksViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BB_WeeksViewController.h"
#import "FBOneChooseTableViewCell.h"
@interface BB_WeeksViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
}

@end

@implementation BB_WeeksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
self.navigationItem.title =@"时间选择";
}
-(void)quedingClick
{
     NSMutableArray *tarr =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<_arr_names.count; i++) {
        if([_arr_contents[i] integerValue]==1)
        {
            [tarr addObject:_arr_names[i]];
        }
    }
        if ([self.delegate respondsToSelector:@selector(chooseArr:indexPath:)]) {
            
            [self.delegate chooseArr:tarr indexPath:self.indexPath];
        
    }
    
        [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    cell.L_left0.text =_arr_names[indexPath.row];
    if ([_arr_contents[indexPath.row] integerValue]==0) {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan"];
    }
    else
    {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_landui"];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_arr_contents[indexPath.row] integerValue]==0)
    {
        [_arr_contents replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    else
    {
        [_arr_contents replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    [tableV reloadData];
}




@end
