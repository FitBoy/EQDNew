//
//  QCYDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QCYDetailViewController.h"
#import "qunListModel.h"
#import "FBTextFieldViewController.h"
#import "DerweimaViewController.h"
#import "DQunChengYuanViewController.h"
#import "DQunYaoQingViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <UIButton+AFNetworking.h>
#import "SZQunGuanLiViewController.h"
#import "LDImagePicker.h"
@interface QCYDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,LDImagePickerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_last;
    NSMutableArray *arr_big;
    qunListModel *model;
    UILabel *quitlabel;
    UISwitch *S_xiaoxi;
    UIButton *tbtn;
    UILabel *tlabel;
    UserModel *user;
}

@end

@implementation QCYDetailViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [arr_one removeObject:@"管理群"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Usre_SearchGroupWithgroupname:nil groupid:self.qunid And:^(NSDictionary *dic) {
        NSNumber *number = dic[@"status"];
        if ([number integerValue]==200) {
            NSArray *arr = dic[@"items"];
            if (arr.count) {
                NSDictionary *dic1 =arr[0];
                model = [qunListModel mj_objectWithKeyValues:dic1];
                RCGroup  *group = [[RCGroup alloc]initWithGroupId:model.groupid groupName:model.groupname portraitUri:model.groupphoto];
                [[RCIM sharedRCIM ]refreshGroupInfoCache:group withGroupId:model.groupid];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tbtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.groupphoto] placeholderImage:[UIImage imageNamed:@"quntubiao"]];
                     tlabel.text = model.groupname;
                    
                    if([user.Guid isEqualToString:model.GroupCreater])
                    {
                        [arr_one addObject:@"管理群"];
                    }
                    [tableV reloadData];
                });
            }
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"群管理";
    quitlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    quitlabel.textAlignment = NSTextAlignmentCenter;
    quitlabel.text =@"退出该群";
    arr_one = [NSMutableArray arrayWithArray:@[@"群名称",@"群二维码"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"查看群成员",@"群邀请",@"消息提醒"]];
    arr_last = [NSMutableArray arrayWithArray:@[@"退出该群"]];
    arr_big = [NSMutableArray arrayWithCapacity:0];
    [arr_big addObject:arr_one];
    [arr_big addObject:arr_two];
    [arr_big addObject:arr_last];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
    
    S_xiaoxi = [[UISwitch alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-70, 5, 70, 30)];
    [[RCIMClient sharedRCIMClient] getConversationNotificationStatus:ConversationType_GROUP targetId:self.qunid success:^(RCConversationNotificationStatus nStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (nStatus == DO_NOT_DISTURB) {
                [S_xiaoxi setOn:NO animated:YES];
            }
            else
            {
                [S_xiaoxi setOn:YES animated:YES];
            }
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [tableV reloadData];
        });
        
    } error:^(RCErrorCode status) {
        
    }];
    
    
    [S_xiaoxi addTarget:self action:@selector(switchxiaoxiClick) forControlEvents:UIControlEventValueChanged];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
   
    tbtn =btn;
    UIView *tview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_WIDTH*0.5)];
    tview.userInteractionEnabled=YES;
    btn.frame = CGRectMake(0, -DEVICE_WIDTH*0.25, DEVICE_WIDTH, DEVICE_WIDTH);
     tlabel =[[UILabel alloc]initWithFrame:CGRectMake(20, DEVICE_WIDTH*0.4, DEVICE_WIDTH-40, DEVICE_WIDTH*0.1)];
    tlabel.backgroundColor =[[UIColor whiteColor] colorWithAlphaComponent:0];
    tlabel.textColor = [UIColor whiteColor];
   
    tview.clipsToBounds=YES;
    tlabel.font =[UIFont systemFontOfSize:21];
    [tview addSubview:btn];
    [tview addSubview:tlabel];
    tableV.tableHeaderView =tview;
    [tbtn addTarget:self action:@selector(changeTupianClcik) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)changeTupianClcik
{
    LDImagePicker *picker =[LDImagePicker sharedInstance];
    picker.delegate =self;
    UIAlertController *alert =[self alertWithTitle:@"更改群头像" message:nil alertControllerStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [picker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:1];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [picker showImagePickerWithType:ImagePickerCamera InViewController:self Scale:1];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
}
-(void)imagePickerDidCancel:(LDImagePicker *)imagePicker
{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage
{
    [WebRequest User_UpdateGroupInfoWithgroupid:model.groupid groupname:model.groupname groupphoto:editedImage And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
             [tbtn setBackgroundImage:editedImage forState:UIControlStateNormal];
            [self loadRequestData];
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"未知错误";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}



-(void)switchxiaoxiClick
{
    if (S_xiaoxi.on==NO) {
        //打开消息提醒
        [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_GROUP targetId:self.qunid isBlocked:YES success:^(RCConversationNotificationStatus nStatus) {
            if (nStatus == DO_NOT_DISTURB) {
                [S_xiaoxi setOn:NO animated:YES];
            }
            else
            {
                [S_xiaoxi setOn:YES animated:YES];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        } error:nil];
        
    }
    else
    {
      //关闭消息提醒
        [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_GROUP targetId:self.qunid isBlocked:NO success:^(RCConversationNotificationStatus nStatus) {
            if (nStatus == DO_NOT_DISTURB) {
                [S_xiaoxi setOn:NO animated:YES];
            }
            else
            {
                [S_xiaoxi setOn:YES animated:YES];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
            
        } error:nil];
        
    }
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr =arr_big[section];
    return  arr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *arr = arr_big[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    if (indexPath.section==0 && indexPath.row ==0) {
        cell.detailTextLabel.text = model.groupname;
    }
    if(indexPath.section==1 && indexPath.row==2)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:S_xiaoxi];
    }
    if (indexPath.section==arr_big.count-1) {
        cell.textLabel.text =nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell addSubview:quitlabel];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                //群名称
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.indexPath = indexPath;
                TFvc.contentTitle = @"群名称";
                TFvc.content = model.groupname;
                TFvc.delegate =self;
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
                break;
            case 1:
            {
                //群二维码
                DerweimaViewController *Dvc =[[DerweimaViewController alloc]init];
                Dvc.model = model;
                [self.navigationController pushViewController:Dvc animated:NO];
            }
                break;
                case 2:
            {
                //管理群
                SZQunGuanLiViewController *GLvc =[[SZQunGuanLiViewController alloc]init];
                GLvc.model =model;
                [self.navigationController pushViewController:GLvc animated:NO];
                
                
            }
            default:
                break;
        }
    }
    else if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
            {
                //查看群成员
                DQunChengYuanViewController *Cvc =[[DQunChengYuanViewController alloc]init];
                Cvc.model =model;
                [self.navigationController pushViewController:Cvc animated:NO];
            }
                break;
            case 1:
            {
                //群邀请
                
                DQunYaoQingViewController *YQvc =[[DQunYaoQingViewController alloc]init];
                YQvc.model =model;
                [self.navigationController pushViewController:YQvc animated:NO];
            }
                break;
                
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
            {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确定退出该群？" preferredStyle:UIAlertControllerStyleActionSheet];
                [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    //退出该群
                    
                    if ([model.GroupCreater isEqualToString:user.Guid]) {
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您是群主，不能退群" preferredStyle:UIAlertControllerStyleActionSheet];
                        [alert addAction:[UIAlertAction actionWithTitle:@"是否解散该群" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud.mode = MBProgressHUDModeAnnularDeterminate;
                            hud.label.text = @"正在解散";
                            [WebRequest User_DismissgroupWithuserGuid:user.Guid Groupid:model.groupid And:^(NSDictionary *dic) {
                                NSString *msg = dic[Y_MSG];
                                NSNumber *number = dic[Y_STATUS];
                                hud.label.text =msg;
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [hud hideAnimated:NO];
                                });
                                if ([number integerValue]==200) {
                                    [self.navigationController popToRootViewControllerAnimated:NO];
                                }
                            }];

                        }]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self presentViewController:alert animated:NO completion:nil];
                        });
                        
                        
                        
                    }
                    else
                    {
                        NSString *Guid = [NSString stringWithFormat:@";%@",user.Guid];
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeAnnularDeterminate;
                        hud.label.text = @"正在退群";
                        [WebRequest  User_QuitgroupWithuserGuid:Guid Groupid:model.groupid GroupName:model.groupname And:^(NSDictionary *dic) {
                            NSString *msg =dic[Y_MSG];
                            NSNumber *number = dic[Y_STATUS];
                            hud.label.text =msg;
                            if ([number integerValue]==200) {
                                [self.navigationController popToRootViewControllerAnimated:NO];
                                
                            }
                        }];
                        
                    }
              

                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];
                });
                
                
                
                
                
            }
                break;
            default:
                break;
        }
    }
}

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
   [WebRequest User_UpdateGroupInfoWithgroupid:model.groupid groupname:content groupphoto:nil And:^(NSDictionary *dic) {
       hud.label.text = dic[Y_MSG];
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [hud hideAnimated:NO];
           [self loadRequestData];
       });
       
   }];
    
}


@end
