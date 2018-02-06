//
//  ShareQunViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ShareQunViewController.h"
#import "qunListModel.h"
#import "FBCreateQunZuTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "FBGeRenCardMessageContent.h"
#import "FBShareMessageContent.h"
@interface ShareQunViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_qun;
    NSMutableArray *tarr;
    NSInteger temp;
    //记录被选中的群的索引
    NSMutableArray *arr_qun_small;
    
    UIBarButtonItem *right;
    UserModel *user;
}

@end

@implementation ShareQunViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [arr_qun_small removeAllObjects];
}
-(void)loadRequestData{
    
    [WebRequest  User_GetGroupsWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        [arr_qun removeAllObjects];
        [tarr removeAllObjects];
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    qunListModel *model = [qunListModel mj_objectWithKeyValues:dic1];
                    [arr_qun addObject:model];
                    [tarr addObject:model];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    
    self.navigationItem.title = @"群组";
    arr_qun = [NSMutableArray arrayWithCapacity:0];
    arr_qun_small = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(fasongClick)];
    [self.navigationItem setRightBarButtonItem:right];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索群";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    adjustsScrollViewInsets_NO(tableV, self);
    temp =0;

    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_qun =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"groupname CONTAINS[cd] %@",searchText];
        arr_qun = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}
-(void)fasongClick
{
    //给群聊发消息
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"发送有延迟，若失败请重发";
    right.enabled = NO;
    for (qunListModel *model in arr_qun_small) {
        if([self.messageContent isKindOfClass:[RCTextMessage class]]|| [self.messageContent isKindOfClass:[RCVoiceMessage class]]||[self.messageContent isKindOfClass:[RCRichContentMessage class]]|| [self.messageContent isKindOfClass:[RCLocationMessage class]] || [self.messageContent isKindOfClass:[FBGeRenCardMessageContent class]]|| [self.messageContent isKindOfClass:[FBShareMessageContent class]])
        {
            [[RCIM sharedRCIM ]sendMessage:ConversationType_GROUP targetId:model.groupid content:self.messageContent pushContent:nil pushData:nil success:^(long messageId) {
               
            } error:^(RCErrorCode nErrorCode, long messageId) {
              
            }];
            
            
        }
        else
        {
            [[RCIM sharedRCIM]sendMediaMessage:ConversationType_GROUP targetId:model.groupid content:self.messageContent pushContent:nil pushData:nil progress:nil success:^(long messageId) {
            } error:^(RCErrorCode errorCode, long messageId) {
                
            } cancel:^(long messageId) {
                
            }];
            
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.label.text =@"发送有延迟，若失败请重发";
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_qun.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBCreateQunZuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBCreateQunZuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    qunListModel *model = arr_qun[indexPath.row];
    [cell.IV_headimg sd_setImageWithURL:[NSURL URLWithString:model.groupphoto] placeholderImage:[UIImage imageNamed:@"qun"]];
    cell.L_name.text = model.groupname;
    if (cell.isChoose==NO) {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan.png"];
        model.isChoose=NO;
    }
    else
    {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_landui.png"];
        model.isChoose=YES;
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        FBCreateQunZuTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    qunListModel *model = arr_qun[indexPath.row];
        if(cell.isChoose == NO)
        {
            if (temp < 5) {
            [arr_qun_small addObject:model];
            temp++;
                [tableView reloadData];
                cell.isChoose = !cell.isChoose;
            }
            else
            {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"最多选择5个群"];
            }
        }
        else
        {
            [arr_qun_small removeObject:model];
            temp--;
            [tableView reloadData];
            cell.isChoose = !cell.isChoose;
        }
        
    
    
    
}


@end
