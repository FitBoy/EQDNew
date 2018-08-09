//
//  CK_personAppViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_personAppViewController.h"
#import "R_RichTextEditor_ViewController.h"
#import "FBButton.h"
#import "FBTextVViewController.h"
#import "CK_hangyeViewController.h"
#import "CK_CKPersonZoneViewController.h"
#import "WS_LiuYanTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "FB_OnlyForLiuYanViewController.h"
@interface CK_personAppViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    UserModel *user;
    //主页
    UITableView *tableV1;
    //日志
    UITableView *tableV2;
    FBButton *tbtn2 ;
    ///产品
    UITableView *tableV3;
    NSArray *arr_names3;
    ///个人档
    UITableView *tableV4;
    NSArray *arr_names4;
    NSString *youshi_str;
    NSString *youshi_Id;
    //留言
    UITableView *tableV5;
    NSMutableArray *arr_model5;
    NSString *page5;
    NSIndexPath *indexpath5_selected;
    //访客
    UITableView *tableV6;
    //收藏
    UITableView *tableV7;
    
}

@end



@implementation CK_personAppViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    if (youshi_str.length == 0) {
        [WebRequest Makerspacey_Get_MakerAdvantageWithuserGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                dispatch_async(dispatch_get_main_queue(), ^{
                    youshi_str  = tdic[@"advantage"];
                    youshi_Id = tdic[@"Id"];
                });
               
            }
        }];
    }
}
-(void)loadRequestData{
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 多行文本
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (youshi_str.length ==0) {
        //新增
        [WebRequest Makerspacey_Add_MakerSpaceWithuserGuid:user.Guid advantage:text And:^(NSDictionary *dic) {
            MBFadeAlertView *alert= [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"添加成功"];
                 youshi_str = text;
            }else
            {
                [alert showAlertWith:@"添加失败，请重试"];
            }
        }];
    }else if([youshi_Id integerValue]!=0 &&youshi_str.length!=0)
    {
        //修改
        [WebRequest Makerspacey_Update_MakerAdvantageWithuserGuid:user.Guid advantage:text atgId:youshi_Id And:^(NSDictionary *dic) {
            MBFadeAlertView *alert= [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"修改成功"];
                youshi_str = text;
            }else
            {
                [alert showAlertWith:@"修改失败，请重试"];
            }
        }];
    }else
    {
        
    }
}
-(void)loadRequestData5{
    [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV5.mj_header endRefreshing];
        [tableV5.mj_footer endRefreshing];
        [arr_model5 removeAllObjects];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page5 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                [arr_model5 addObject:model];
            }
            [tableV5 reloadData];
        }
    }];
}
-(void)loadMoreData5{
    [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:user.Guid page:page5 And:^(NSDictionary *dic) {
        [tableV5.mj_header endRefreshing];
        [tableV5.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV5.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page5 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                [arr_model5 addObject:model];
            }
            [tableV5 reloadData];
            }
        }
    }];
}
-(void)tableOtherinit{
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.backgroundColor = [UIColor orangeColor];
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV2, self);
    tableV2.delegate=self;
    tableV2.dataSource=self;
    [self.view addSubview:tableV2];
    tableV2.rowHeight=60;
    tbtn2 = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn2 setTitle:@"写日志 + " titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:19 weight:3]];
    [tbtn2 addTarget:self action:@selector(add_rizhiClick) forControlEvents:UIControlEventTouchUpInside];
   
    arr_names3 = @[@"讲师课程"];
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV3, self);
    tableV3.delegate=self;
    tableV3.dataSource=self;
    [self.view addSubview:tableV3];
    tableV3.rowHeight=60;
    
    
    tableV4 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV4, self);
    tableV4.delegate=self;
    tableV4.dataSource=self;
    [self.view addSubview:tableV4];
    tableV4.rowHeight=60;
    youshi_str = nil;
    youshi_Id = nil;
    arr_names4 = @[@"个人信息",@"所属行业",@"个人资质",@"个人优势",@"个人相册"];
    
    arr_model5 = [NSMutableArray arrayWithCapacity:0];
    page5= @"0";
    tableV5 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV5, self);
    tableV5.delegate=self;
    tableV5.dataSource=self;
    [self.view addSubview:tableV5];
    tableV5.rowHeight=60;
    tableV5.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData5)];
    tableV5.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData5)];
    
    tableV6 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV6, self);
    tableV6.delegate=self;
    tableV6.dataSource=self;
    [self.view addSubview:tableV6];
    tableV6.rowHeight=60;

    tableV7 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV7, self);
    tableV7.delegate=self;
    tableV7.dataSource=self;
    [self.view addSubview:tableV7];
    tableV7.rowHeight=60;
    [self tableviewHidden];
    
}

-(void)tableviewHidden
{
    tableV1.hidden = YES;
    tableV2.hidden = YES;
    tableV3.hidden = YES;
    tableV4.hidden = YES;
    tableV5.hidden = YES;
    tableV6.hidden = YES;
    tableV7.hidden = YES;
}
#pragma  mark - 增加日志
-(void)add_rizhiClick
{
      R_RichTextEditor_ViewController  *Rvc = [[R_RichTextEditor_ViewController alloc]init];
     Rvc.source =@"0";
     Rvc.articleName = @"创客空间";
     Rvc.menuid =@"0";
     [self.navigationController pushViewController:Rvc animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"创客空间";
    arr_names = @[@"主页",@"个人日志",@"产品",@"个人档",@"留言",@"访客",@"收藏"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, 100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [self tableOtherinit];
    tableV1.hidden = NO;
    
  

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV ==tableView) {
        return 60;
    }else if (tableView ==tableV5)
    {
        WS_liuYanModel *Model = arr_model5[indexPath.row];
        return Model.cell_height;
    }
    else
    {
         return 60;
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==tableV) {
         return arr_names.count;
    }else if (tableV4 == tableView)
    {
        return arr_names4.count;
    }else if (tableV5 ==tableView)
    {
        return arr_model5.count;
    }
    else
    {
        return 0;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==tableV || tableV4 == tableView) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (tableV4 ==tableView) {
            cell.textLabel.text = arr_names4[indexPath.row];
        }else
        {
        cell.textLabel.text = arr_names[indexPath.row];
        }
        return cell;
    }else if (tableView ==tableV5)
    {
        static NSString *cellId=@"cellID5";
        WS_LiuYanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WS_LiuYanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        WS_liuYanModel *model = arr_model5[indexPath.row];
        [cell setModel_liuyan:model];
        FBindexTapGestureRecognizer  *tap_liuyan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick:)];
        tap_liuyan.indexPath = indexPath;
        [cell.L_contets  addGestureRecognizer:tap_liuyan];
        
        return cell;
    }
    
    else
    {
        return nil;
    }
   
}

#pragma  mark - 留言
-(void)getPresnetText:(NSString *)text
{
    WS_liuYanModel *model = arr_model5[indexpath5_selected.row];
    
    [WebRequest Makerspacey_MakerLeaveMsg_Add_MakerLeaveMsgWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:model.Id makerGuid:model.creater parentUserGuid:model.creater firstCommentId:model.Id objectId:@"0" objectType:@"0" And:^(NSDictionary *dic) {
        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"回复成功"];
            WS_liuYanModel *tmodel =   [WS_liuYanModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.childList];
            [tarr insertObject:tmodel atIndex:0];
            model.childList = tarr;
            [arr_model5 replaceObjectAtIndex:indexpath5_selected.row withObject:model];
            [tableV5 reloadData];
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试！"];
        }
    }];
}

#pragma  mark -  对内容进行再留言
-(void)tap_liuyanClick:(FBindexTapGestureRecognizer*)tap
{
    WS_liuYanModel  *model = arr_model5[tap.indexPath.row];
    indexpath5_selected = tap.indexPath;
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"回复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FB_OnlyForLiuYanViewController  *LYvc = [[FB_OnlyForLiuYanViewController alloc]init];
        LYvc.delegate =self;
        LYvc.providesPresentationContextTransitionStyle = YES;
        LYvc.definesPresentationContext = YES;
        LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        LYvc.btnName = @"留言";
        LYvc.placeHolder = @"说说您感兴趣的地方……";
        [self presentViewController:LYvc animated:NO completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}

#pragma  mark - 表头的设计
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView ==tableV2 && section ==0) {
        return tbtn2;
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==tableV2 && section ==0) {
        return 40;
    }else
    {
        return 0;
    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==tableV) {
         [self tableviewHidden];
        
        switch (indexPath.row) {
            case 0:
            {
                //主页
                tableV1.hidden = NO;
            }
                break;
            case 1:
            {
                //个人日志
                tableV2.hidden = NO;
                ///暂时跳到 个人的空间展示
                CK_CKPersonZoneViewController *Pvc= [[CK_CKPersonZoneViewController alloc]init];
                Pvc.userGuid = user.Guid;
                [self.navigationController pushViewController:Pvc animated:NO];
                
            }
                break;
            case 2:
            {
                //产品
                tableV3.hidden = NO;
            }
                break;
            case 3:
            {
                //个人档
                tableV4.hidden = NO;
            }
                break;
            case 4:
            {
                //留言
                tableV5.hidden = NO;
                if (arr_model5.count ==0) {
                    [self loadRequestData5];
                }else
                {
                    
                }
            }
                break;
            case 5:
            {
                //访客
                tableV6.hidden = NO;
            }
                break;
            case 6:
            {
                //收藏
                tableV7.hidden = NO;
            }
                break;
            default:
                break;
        }
      
    }else if (tableView == tableV1)
    {
       //主页
    }else if (tableV2 == tableView)
    {
        //日志
    }else if (tableV3 ==tableView)
    {
        //产品
    }else if (tableV4 ==tableView)
    {
        //个人档
        if(indexPath.row ==0 )
        {
            //个人信息
        }else if (indexPath.row ==1)
        {
            //所属行业
            CK_hangyeViewController *Hvc = [[CK_hangyeViewController alloc]init];
            Hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Hvc animated:NO];
        }else if (indexPath.row ==2)
        {
            //个人资质
        }else if (indexPath.row ==3)
        {
            //个人优势
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.S_maxnum = @"2000";
            TVvc.contentTitle=@"个人优势";
            TVvc.content =youshi_str;
            [self.navigationController pushViewController:TVvc animated:NO];
            
        }else if (indexPath.row ==4)
        {
            //个人相册
        }else
        {
            
        }
    }else if (tableV5 == tableView)
    {
        //留言
    }else if (tableV6 ==tableView)
    {
        //访客
    }else if (tableView == tableV7)
    {
        //收藏
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==tableV5) {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WS_liuYanModel  *model = arr_model5[indexPath.row];
        [WebRequest Makerspacey_MakerLeaveMsg_Delete_MakerLeaveMsgWithmsgId:model.Id type:@"0" userGuid:user.Guid And:^(NSDictionary *dic) {
            MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"删除成功"];
                [arr_model5 removeObject:model];
                [tableV5 reloadData];
            }else
            {
                [alert showAlertWith:@"服务器错误，请重试！"];
            }
        }];
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
