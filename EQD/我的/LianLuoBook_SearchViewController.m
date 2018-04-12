//
//  LianLuoBook_SearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LianLuoBook_SearchViewController.h"
#import "UISearchBar+ToolDone.h"
#import "FBFour_imgTableViewCell.h"
@interface LianLuoBook_SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    UISearchBar *searchBar;
    NSMutableArray *arr_model;
}

@end

@implementation LianLuoBook_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    arr_model =[NSMutableArray arrayWithCapacity:0];
   adjustsScrollViewInsets_NO(tableV, self);
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"手机号/易企点号/姓名";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
#pragma  mark - 表的数据源
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    if (searchBar.text.length==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"输入内容不能为空";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    [WebRequest LiaisonBooks_Get_Usre_BySearchWithpara:searchBar.text And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        [arr_model removeAllObjects];
        for (int i=0; i<tarr.count; i++) {
            Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        [tableV reloadData];
    }];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_imgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_imgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    Com_UserModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_UserModel *model =arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(lianluoModel:indexpath:)]) {
        [self.delegate lianluoModel:model indexpath:self.indexPath];
    }
    [self.navigationController popViewControllerAnimated:NO];
}




@end
