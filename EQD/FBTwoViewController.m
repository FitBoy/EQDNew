//
//  FBTwoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwoViewController.h"
#import "TXLFriendShengQingViewController.h"
#import "TXLQunLiaoViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "FBLocationPickerViewController.h"
#import "TAddFriendViewController.h"
#import "BMChineseSort.h"
#import <UIImageView+AFNetworking.h>
#import "TwoTongShi_ViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "FBTimeDayViewController.h"

#import "FBOne_img1TableViewCell.h"
#import "HaoYouModel.h"
#import "Two_BiaoQian_ViewController.h"
#import "PPersonCardViewController.h"
#import "FBindexTapGestureRecognizer.h"
#import "RedTipTableViewCell.h"
#import "UISearchBar+ToolDone.h"
#import <UIButton+WebCache.h>
@interface FBTwoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *tarr;
    UISearchBar *searchBar;
    
    UILabel *L_haoyou;
    NSInteger num_friend;
    
    //排序后的索引与数组
    NSArray  *arr_index;
    NSArray  *arr_name;
    UserModel *user;
    ///显示小红点的数据记录
    NSMutableArray *arr_type;
    NSMutableArray *arr_code;
    
}


@end

@implementation FBTwoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self messageRecieved];
    [self loadRequestData];
}

-(void)messageRecieved
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0"]];

            NSArray *tarr = dic[Y_ITEMS];
            NSInteger  code_two = 0;
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 = tarr[i];
                if ([dic2[@"code"] integerValue]==200) {
                    //通讯录
                    code_two= code_two+[dic2[@"count"] integerValue];
                }
            }
            [arr_code replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",code_two]];
            self.tabBarItem.badgeValue = [self changeWithnumber:code_two];
            [tableV reloadData];
            
        }
    }];
    
}
-(void)loadRequestData{
    
    [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
        [arr_two removeAllObjects];
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                    RCUserInfo  *info = [[RCUserInfo alloc]initWithUserId:model.Guid name:model.upname portrait:model.iphoto];
                    [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:model.Guid];
                    [arr_two addObject:model];
                }
                
                
                arr_index = [BMChineseSort IndexWithArray:arr_two Key:@"upname"];
                arr_name = [BMChineseSort sortObjectArray:arr_two Key:@"upname"];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV.mj_header endRefreshing];
                [tableV reloadData];
            });
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    } else {
        // Fallback on earlier versions
    }
    user =[WebRequest GetUserInfo];
   self.navigationItem.title = @"通讯录";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(kuaijiefangshi)];
    
    [self.navigationItem setRightBarButtonItem:right];
    self.view.backgroundColor =[UIColor whiteColor];
    
    //,@[@"gzh.png",@"企业圈"]
    arr_one=[NSMutableArray arrayWithArray:@[@[@"ease_new_friends_icon.png",@"添加好友"],@[@"mytask.png",@"同事"],@[@"yanzheng.png",@"新的好友"],@[@"ease_groups_icon.png",@"群聊"],@[@"biaoqian.png",@"标签"]]];
    
    arr_two =[NSMutableArray arrayWithCapacity:0];
    tarr =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, CGRectGetMinY(self.tabBarController.tabBar.frame)-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    adjustsScrollViewInsets_NO(tableV, self);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageRecieved) name:Z_FB_message_received object:nil];
    
}



#pragma  mark - 表的数据源

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return arr_index;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_index.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_one.count;
    }
    NSArray *arr = arr_name[section-1];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        static NSString *cellId=@"cellID";
        RedTipTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[RedTipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.font =[UIFont systemFontOfSize:18];
        }
        if ([arr_code[indexPath.row] integerValue]>0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text = arr_code[indexPath.row];
        }else
        {
            cell.L_RedTip.hidden=YES;
        }
       
        NSArray *arr =arr_one[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:arr[0]];
        cell.textLabel.text =arr[1];
        return cell;
        
    }
    else
    {
        static NSString *cellId2=@"cellID2";
        FBOne_img1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId2];
        if (!cell) {
            cell = [[FBOne_img1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.B_img.indexpath = indexPath;
        [cell.B_img addTarget:self action:@selector(tapheadClick:) forControlEvents:UIControlEventTouchUpInside];
        
       
        NSArray *arr =arr_name[indexPath.section-1];
        HaoYouModel *model =arr[indexPath.row];
        FBindexpathLongPressGestureRecognizer  *longpress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressClick:)];
        longpress.indexPath=indexPath;
        [cell addGestureRecognizer:longpress];
        
        [cell setModel:model];
        [cell.B_img sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img_header] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"no_login_head"]];
       
        
    return cell;
    }
    
}

-(void)tapheadClick:(FBButton*)indexTap
{
    NSArray *arr =arr_name[indexTap.indexpath.section-1];
    HaoYouModel *model =arr[indexTap.indexpath.row];
    PPersonCardViewController *pvc =[[PPersonCardViewController alloc]init];
    pvc.userGuid =model.Guid;
    pvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pvc animated:NO];
}

-(void)longpressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    NSArray *arr =arr_name[longpress.indexPath.section-1];
    HaoYouModel *model =arr[longpress.indexPath.row];
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"拨打电话：%@",model.uname]style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.uname];
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.view addSubview:callWebView];
        });
       
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"添加标签"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除好友"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:nil message:@"确定删除该好友" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *arr=arr_name[longpress.indexPath.section-1];
            HaoYouModel *model = arr[longpress.indexPath.row];
            [WebRequest User_Friend_DeleteWithuserGuid:user.Guid friendGuid:model.Guid  And:^(NSDictionary *dic) {
                NSNumber *number = dic[@"status"];
                if ([number integerValue]==200) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        [self loadRequestData];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"删除好友成功";
                        
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });

                    });
                    
                    
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"删除好友失败，请重试";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });

                    });
                                    }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
            }];

        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert2 animated:NO completion:nil];
        
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma  mark - 表的协议代理

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if (section==0) {
        return nil;
    }
    return arr_index[section-1];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view endEditing:YES];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"添加好友");
                TAddFriendViewController *AFvc =[[TAddFriendViewController alloc]init];
                AFvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:AFvc animated:NO];
                
                
            }
                break;
            case 1:
            {
                NSLog(@"同事");
                if([user.companyId integerValue]==0)
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"你不在任何企业，暂无同事";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }else
                {
                TwoTongShi_ViewController *TSvc =[[TwoTongShi_ViewController alloc]init];
                TSvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:TSvc animated:NO];
                }
               
            }
                break;
            case 2:
            {
                NSLog(@"好友申请");
                [arr_type removeObject:@"200"];
                [USERDEFAULTS setObject:arr_type forKey:Y_type];
                [USERDEFAULTS synchronize];
                TXLFriendShengQingViewController *FSvc =[[TXLFriendShengQingViewController alloc]init];
                FSvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:FSvc animated:NO];
                
            }
                break;
                
            case 3:
            {
                NSLog(@"群聊");
                TXLQunLiaoViewController *QLvc =[[TXLQunLiaoViewController alloc]init];
                QLvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:QLvc animated:NO];
            }
                break;
            case 4:
            {
                //标签
                Two_BiaoQian_ViewController *BQvc =[[Two_BiaoQian_ViewController alloc]init];
                BQvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:BQvc animated:NO];
                
            }
                break;
            case 5:
            {
                NSLog(@"企业圈");
            }
                break;
                
            default:
                break;
        }
    }
    
    else
    {
        NSArray *arr =arr_name[indexPath.section-1];
        HaoYouModel *model =arr[indexPath.row];
        
        FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.Guid];
        oneTooneChat.navigationItem.title =model.upname;
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.Guid  name:model.upname portrait:model.iphoto];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.Guid];
        oneTooneChat.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:oneTooneChat animated:NO];
    }
    
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        //删除好友
        
        
        UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:nil message:@"确定删除该好友" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *arr=arr_name[indexPath.section-1];
            HaoYouModel *model = arr[indexPath.row];
            [WebRequest User_Friend_DeleteWithuserGuid:user.Guid friendGuid:model.Guid  And:^(NSDictionary *dic) {
                NSNumber *number = dic[@"status"];
                if ([number integerValue]==200) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"删除好友成功";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        [self loadRequestData];
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });
                        
                    });
                    
                    
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"删除好友失败，请重试";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });
                        
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
            }];
            
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert2 animated:NO completion:nil];

        
       
        
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return NO;
    }
    return YES;
}



@end
