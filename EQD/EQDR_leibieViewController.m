//
//  EQDR_leibieViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_leibieViewController.h"
#import "FBHnagYeModel.h"
#import "UISearchBar+ToolDone.h"
@interface EQDR_leibieViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_json;
    NSMutableArray *arr_selected;
    NSMutableArray *arr_data;
    UISearchBar * searchBar;
}

@end

@implementation EQDR_leibieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_data = [NSMutableArray arrayWithCapacity:0];
    arr_selected = [NSMutableArray arrayWithArray:self.arr_se_hangye];
    arr_json = [NSMutableArray arrayWithCapacity:0];
    [WebRequest  Option_AreasAndWithtype:2 And:^(NSArray *arr) {
        [arr_json removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            FBHnagYeModel  *model = [FBHnagYeModel mj_objectWithKeyValues:arr[i]];
            for (int i=0; i<model.children.count; i++) {
              FBHnagYeModel  *model1 = [FBHnagYeModel mj_objectWithKeyValues:model.children[i]];
                for (int i=0; i<model1.children.count; i++) {
                    FBHnagYeModel  *model2 = [FBHnagYeModel mj_objectWithKeyValues:model1.children[i]];
                    [arr_json addObject:model2];
                }
            }
        }
        searchBar.userInteractionEnabled =YES;
    }];
    
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height-40, DEVICE_WIDTH-200, 40)];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索行业";
    [searchBar becomeFirstResponder];
    [searchBar setTextFieldInputAccessoryView];
    searchBar.userInteractionEnabled=NO;
    self.navigationItem.titleView = searchBar;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quDingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=30;
    

   
}
-(void)quDingClick
{
    if ([self.delegate respondsToSelector:@selector(getSelectedarr:)]) {
        [self.delegate getSelectedarr:arr_selected];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        [arr_data  removeAllObjects];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchText];
        arr_data = [NSMutableArray arrayWithArray:[arr_json filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==1?@"可选择的行业":@"已选择的行业";
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==1? arr_data.count:arr_selected.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    if(indexPath.section==1)
    {
        FBHnagYeModel *model =arr_data[indexPath.row];
        cell.textLabel.text = model.name;
    }else
    {
        FBHnagYeModel *model =arr_selected[indexPath.row];
        cell.textLabel.text =model.name;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
         FBHnagYeModel *model =arr_data[indexPath.row];
        if (arr_selected.count>4) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"最多选择5种行业";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else
        {
        [arr_selected addObject:model];
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    }else
    {
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return indexPath.section==0? UITableViewCellEditingStyleDelete:UITableViewCellEditingStyleNone;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FBHnagYeModel *model =arr_selected[indexPath.row];
        [arr_selected removeObject:model];
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}






@end
