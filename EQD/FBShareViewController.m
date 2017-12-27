//
//  FBShareViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBShareViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "FBCreateQunZuTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "FBFriendViewController.h"
#import "ShareQunViewController.h"
#import "qunListModel.h"
#import "ShareQunChengYuanViewController.h"
#import "FBMutableChoose_TongShiViewController.h"
#import "FBGeRenCardMessageContent.h"
@interface FBShareViewController ()<UITableViewDelegate,UITableViewDataSource,FBMutableChoose_TongShiViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    //RCConversation
    NSArray *arr_friends;
    NSInteger temp;
    NSMutableArray *tarr;
    UIBarButtonItem *right;
    //被选中的索引值
    NSMutableArray *arr_friends_small;
    UserModel *user;
    
}

@end

@implementation FBShareViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    right.enabled =YES;
}
-(void)loadRequestData{
    
    
    [WebRequest User_GetGroupsWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                [tarr removeAllObjects];
                for (NSDictionary *dic1 in arr) {
                    qunListModel *model = [qunListModel mj_objectWithKeyValues:dic1];
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
    self.navigationItem.title = @"发送给";
    right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(fasongClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(fanhuiClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    tarr = [NSMutableArray arrayWithCapacity:0];
    arr_names = [NSMutableArray arrayWithArray:@[@"好友",@"同事",@"群组",@"群成员"]];
   arr_friends = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    arr_friends_small = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
   
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    temp = 0;
}
-(void)fasongClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在发送";
    for (RCConversation *model in arr_friends_small) {
        if([self.messageContent isKindOfClass:[RCTextMessage class]] || [self.messageContent isKindOfClass:[RCVoiceMessage class]] || [self.messageContent isKindOfClass:[RCRichContentMessage class]]|| [self.messageContent isKindOfClass:[RCLocationMessage class]] ||[self.messageContent isKindOfClass:[FBGeRenCardMessageContent class]])
            
        {
           
            [[RCIM sharedRCIM ]sendMessage:model.conversationType targetId:model.targetId content:self.messageContent pushContent:nil pushData:nil success:^(long messageId) {
                
                } error:^(RCErrorCode nErrorCode, long messageId) {
               }];
            
            
        }
        else
        {
            [[RCIM sharedRCIM]sendMediaMessage:model.conversationType targetId:model.targetId content:self.messageContent pushContent:nil pushData:nil progress:nil success:^(long messageId) {
                           } error:^(RCErrorCode errorCode, long messageId) {
            } cancel:^(long messageId) {
          
            }];
            
            
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.label.text =@"发送有延迟，若失败请重发";
            [hud hideAnimated:NO];
            [self dismissViewControllerAnimated:NO completion:nil];
        });
        
    }
    

   
    
}
-(void)fanhuiClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 4;
    }
    else
    {
        return arr_friends.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = arr_names[indexPath.row];
        return cell;
    }
    else
    {
        static NSString *cellid2 = @"cellID2";
        FBCreateQunZuTableViewCell *cell2 =[tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell2) {
            cell2 = [[FBCreateQunZuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
       RCConversation *model = arr_friends[indexPath.row];
        
        if (cell2.isChoose==NO) {
            cell2.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan.png"];
            }
        else
        {
            cell2.IV_choose.image=[UIImage imageNamed:@"shequ_landui.png"];
        }

        if (model.conversationType ==ConversationType_PRIVATE) {
        RCUserInfo *user= [[RCIM sharedRCIM] getUserInfoCache:model.targetId];
            if (user.portraitUri!=nil) {
                [cell2.IV_headimg setImageWithURL:[NSURL URLWithString:user.portraitUri]];
            }
            cell2.L_name.text = user.name;
            
        }
        else
        {
            
            
            NSPredicate *predicate =[NSPredicate predicateWithFormat:@"groupid CONTAINS[cd] %@",model.targetId];
            NSArray *arr = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
            
            if (arr.count) {
                qunListModel *model1 =arr[0];
                cell2.L_name.text = model1.groupname;
                [cell2.IV_headimg setImageWithURL:[NSURL URLWithString:model1.groupphoto] placeholderImage:[UIImage imageNamed:@"qun"]];
            }
            
        }
        return cell2;
    }
    
    
}

#pragma  mark - 表的协议代理
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    else
    {
        return @"最近联系人";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 20;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        FBCreateQunZuTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        RCConversation *model = arr_friends[indexPath.row];

        if(cell.isChoose == NO)
        {
            if (temp < 5) {
                [arr_friends_small addObject:model];
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
            [arr_friends_small removeObject:model];
            temp--;
            [tableView reloadData];
            cell.isChoose = !cell.isChoose;
        }
        
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                //好友
                FBFriendViewController *Fvc =[[FBFriendViewController alloc]init];
                Fvc.messageContent = self.messageContent;
                [self.navigationController pushViewController:Fvc animated:NO];
                
            }
                break;
            case 1:
            {
                //同事
                FBMutableChoose_TongShiViewController *TSvc =[[FBMutableChoose_TongShiViewController alloc]init];
                TSvc.delegate =self;
                TSvc.indePath =indexPath;
                [self.navigationController pushViewController:TSvc animated:NO];
                
            }
                break;
            case 2:
            {
                //群组
                ShareQunViewController  *SQvc =[[ShareQunViewController alloc]init];
                SQvc.messageContent =self.messageContent;
                [self.navigationController pushViewController:SQvc animated:NO];
            }
                break;
                case 3:
            {
                //群成员
                ShareQunChengYuanViewController *QCvc =[[ShareQunChengYuanViewController alloc]init];
                QCvc.MessageContent = self.messageContent;
                [self.navigationController pushViewController:QCvc animated:NO];
                
            }
                break;
            default:
                break;
        }
    }
    
    
}

#pragma  mark - delegate 自定义
-(void)mutableChooseArr:(NSArray*)chooses  tarr:(NSArray*)tarr indexPath:(NSIndexPath*)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"发送有延迟，若失败请重发";
    for (Com_UserModel *model in chooses) {
        
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.userGuid  name:model.username portrait:model.photo];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.userGuid];
        
        if([self.messageContent isKindOfClass:[RCTextMessage class]]|| [self.messageContent isKindOfClass:[RCVoiceMessage class]]||[self.messageContent isKindOfClass:[RCRichContentMessage class]]|| [self.messageContent isKindOfClass:[RCLocationMessage class]] ||[self.messageContent isKindOfClass:[FBGeRenCardMessageContent class]])
        {
            [[RCIM sharedRCIM ]sendMessage:ConversationType_PRIVATE targetId:model.userGuid content:self.messageContent pushContent:nil pushData:nil success:^(long messageId) {
            } error:^(RCErrorCode nErrorCode, long messageId) {
            }];
            
            
        }
        else if([self.messageContent isKindOfClass:[RCFileMessage class]]  || [self.messageContent isKindOfClass:[RCImageMessage class]])
        {
            [[RCIM sharedRCIM]sendMediaMessage:ConversationType_PRIVATE targetId:model.userGuid content:self.messageContent pushContent:nil pushData:nil progress:nil success:^(long messageId) {
            } error:^(RCErrorCode errorCode, long messageId) {
            } cancel:^(long messageId) {
                
            }];
            
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"不支持此类型的转发";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    });
    
    
}

@end
