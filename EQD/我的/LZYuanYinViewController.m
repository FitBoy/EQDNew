//
//  LZYuanYinViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LZYuanYinViewController.h"
#import "LZMainModel.h"
#import "FBindexTapGestureRecognizer.h"
@interface LZYuanYinViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_lizhi;
    UISegmentedControl *segmentC;
    NSMutableArray *tarr;
    NSIndexPath *selected_IP1;
    NSIndexPath *selected_IP0;
    UIBarButtonItem *right;
    NSString *tstr;
}

@end

@implementation LZYuanYinViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Option_AreasAndWithtype:26 And:^(NSArray *arr) {
        [tarr removeAllObjects];
        if (arr.count) {
            for (int i=0; i<arr.count; i++) {
                LZMainModel *model =[LZMainModel mj_objectWithKeyValues:arr[i]];
            [tarr addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            arr_lizhi =tarr;
            [tableV reloadData];
        });
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tarr =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
    tableV.contentInset=UIEdgeInsetsMake(15, 0, 0, 0);
    self.navigationItem.title =@"离职原因";
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"请选择"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    [self.view addSubview:segmentC];
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    
    
     right=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    right.enabled =NO;
    
}
-(void)chooseClick
{
    if (segmentC.selectedSegmentIndex==0) {
        right.enabled=NO;
        [segmentC removeAllSegments];
        [segmentC insertSegmentWithTitle:@"请选择" atIndex:0 animated:NO];
        arr_lizhi = tarr;
        [tableV reloadData];
        segmentC.selectedSegmentIndex=0;
    }
    else
    {
        segmentC.selectedSegmentIndex=1;
    }
}
-(void)quedingClick
{
    
    if ([self.delegate respondsToSelector:@selector(reason:indexpath:)]) {
        LZMainModel *model =tarr[selected_IP0.row];
        NSMutableString *reason =[NSMutableString stringWithString:model.name];
        if (selected_IP0.row==tarr.count-1) {
            [reason appendFormat:@"-%@",tstr];
        }
        else
        {
            LZMainModel *model2 =model.subdivision[selected_IP1.row];
            [reason appendFormat:@"-%@",model2.name];
        }
        [self.delegate reason:reason indexpath:self.indexpath];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    
    
}
#pragma  mark - 表的数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_lizhi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    LZMainModel *model = arr_lizhi[indexPath.row];
    cell.textLabel.text =model.name;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZMainModel *model = arr_lizhi[indexPath.row];
    if (segmentC.selectedSegmentIndex==0) {
        right.enabled=NO;
       [segmentC setTitle:model.name forSegmentAtIndex:0];
        [segmentC insertSegmentWithTitle:@"具体原因" atIndex:1 animated:NO];
        segmentC.selectedSegmentIndex=1;
        LZMainModel *model =tarr[indexPath.row];
        arr_lizhi =model.subdivision;
        selected_IP0=indexPath;
        [tableV reloadData];
    }
    else
    {
        right.enabled=YES;
        [segmentC setTitle:model.name forSegmentAtIndex:1];
        selected_IP1=indexPath;
        
        if (selected_IP0.row ==tarr.count-1) {
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入其他原因" preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
              textField.placeholder=@"其他原因";
            }];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              if(alert.textFields[0].text.length!=0)
              {
                  UITableViewCell *cell =[tableV cellForRowAtIndexPath:indexPath];
                  cell.textLabel.text =alert.textFields[0].text;
                  tstr =alert.textFields[0].text;
                  [segmentC setTitle:alert.textFields[0].text forSegmentAtIndex:1];
                  right.enabled=YES;

              }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"输入内容不能为空";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }]];
            
            
            [self presentViewController:alert animated:NO completion:nil];
            
        }
        else
        {
            
        }
    }
    
    
    
}




@end
