//
//  FB_shuXiangViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_shuXiangViewController.h"
#import "FBOneChooseTableViewCell.h"
#import "OptionModel.h"
@interface FB_shuXiangViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation FB_shuXiangViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Option_AreasAndWithtype:21 And:^(NSArray *arr) {
        for (int i=0; i<arr.count; i++) {
            OptionModel  *model = [OptionModel mj_objectWithKeyValues:arr[i]];
            model.isChoose =NO;
            [arr_model addObject:model];
        }
       
        OptionModel  *tmodel = [[OptionModel alloc]init];
        tmodel.name = @"不限";
        tmodel.isChoose =NO;
        [arr_model addObject:tmodel];
        [tableV reloadData];
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title_;
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
   


}
-(void)quedingClick
{
    if([self.delegate_shuxiang respondsToSelector:@selector(getShuXiangArr:indexpath:)])
    {
        
        [self.navigationController popViewControllerAnimated:NO];
        NSMutableArray  *tarr = [NSMutableArray arrayWithCapacity:0];
        
        for (int i=0; i<arr_model.count; i++) {
            OptionModel  *Model = arr_model[i];
            if (Model.isChoose !=NO) {
                [tarr addObject:Model.name];
            }else
            {
                
            }
        }
        
        [self.delegate_shuxiang getShuXiangArr:tarr indexpath:self.indexpath];
        
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    
   OptionModel  *model = arr_model[indexPath.row];
    if (model.isChoose == NO) {
        cell.IV_choose.image = [UIImage imageNamed:@"shequ_tluntan"];
    }else
    {
        cell.IV_choose.image = [UIImage imageNamed:@"shequ_landui"];
    }
    cell.L_left0.text= model.name;
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionModel  *model = arr_model[indexPath.row];
    model.isChoose = !model.isChoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




@end
