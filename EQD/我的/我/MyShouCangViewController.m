//
//  MyShouCangViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MyShouCangViewController.h"
#import "FBTextvImgViewController.h"
#import "IVLabeltableHeadView.h"
#import "FBindexTapGestureRecognizer.h"
#import "MyShouCangModel.h"
#import "FBButton.h"
#import "MyShouCangTableViewCell.h"
#import "FBSearchMapViewController.h"
#import "MakeVoiceNoticeController.h"
#import "FBShowimg_moreViewController.h"
#import "FBShowImg_TextViewController.h"
#import "ShouCangGroupViewController.h"
#import <AVKit/AVKit.h>
#import "FBindexpathLongPressGestureRecognizer.h"
#import "UISearchBar+ToolDone.h"
#import "FB_CollectionLinkTableViewCell.h"
#import "EQDR_Article_DetailViewController.h"
#import "GongZuoQunModel.h"
#import "GZQ_PingLunViewController.h"
@interface MyShouCangViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextvImgViewControllerDelegate,FBSearchMapViewControllerDelegate,MakeVoiceNoticeControllerDelegate,UISearchBarDelegate,ShouCangGroupViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
    NSString *group;
    NSString *searchText;
    
    
}

@end

@implementation MyShouCangViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadRequestData];
}
-(void)loadRequestData{
    
    searchText=nil;
    [WebRequest  Collection_Get_collectionsWithowner:user.Guid group:group page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                MyShouCangModel  *model =[MyShouCangModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
             page = dic[@"nextpage"];
        }
       
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
}
-(void)loadOtherData{
    if (searchText==nil) {
        [WebRequest  Collection_Get_collectionsWithowner:user.Guid group:group page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                for (int i=0; i<tarr.count; i++) {
                    MyShouCangModel  *model =[MyShouCangModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                page = dic[@"nextpage"];
                          [tableV reloadData];
            }
            
            }
           
      
            
        }];
    }
    else
    {
        [WebRequest Collection_Search_collectionWithowner:user.Guid ccontent:searchText type:@"0" page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr =dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                for (int i=0; i<tarr.count; i++) {
                    MyShouCangModel *model =[MyShouCangModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                page =dic[@"nextpage"];
                   [tableV reloadData];
                }
            }
           
           
            
        }];
        
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    group =@"0";
    searchText=nil;
//    self.navigationItem.title =@"我的收藏";
    user = [WebRequest GetUserInfo];
    page=@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"全部收藏" titleColor:EQDCOLOR backgroundColor:nil font:[UIFont systemFontOfSize:17]];
    
    [tbtn addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView =tbtn;
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"]  style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    [searchBar setTextFieldInputAccessoryView];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
     [self loadRequestData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchText =searchBar.text;
    [WebRequest  Collection_Search_collectionWithowner:user.Guid ccontent:searchBar.text type:@"0" page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr =dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                MyShouCangModel *model =[MyShouCangModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page =dic[@"nextpage"];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
       
    }];
    
}
-(void)chooseClick
{
    //我的收藏的分组管理
    ShouCangGroupViewController   *Gvc =[[ShouCangGroupViewController alloc]init];
    Gvc.delegate =self;
    [self.navigationController pushViewController:Gvc animated:NO];
}
#pragma mark - 收藏分组的协议代理

-(void)shoucangGroupWithmodel:(ShouCang_GroupModel *)model shoucang:(MyShouCangModel *)model2
{
    group =model.Id;
     [self loadRequestData];
    FBButton *tbtn =(FBButton*)self.navigationItem.titleView;
    [tbtn setTitle:model.name forState:UIControlStateNormal];
    if (model2) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在移动";
        [WebRequest  Collection_Move_collectionGroupWithowner:user.Guid collections:model2.Collection.Id groupid:model.Id And:^(NSDictionary *dic) {
          hud.label.text= dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                 [self loadRequestData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
        
    }
}
-(void)addClick{
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:nil message:@"添加收藏的类型" preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray  *tarr =@[@"图文",@"位置",@"语音"];
    for(int i=0;i<tarr.count;i++)
    {
    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (i==0) {
            //图文
            FBTextvImgViewController  *TIvc = [[FBTextvImgViewController alloc]init];
            TIvc.contentTitle = @"添加收藏";
            TIvc.delegate = self;
            TIvc.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.navigationController pushViewController:TIvc animated:NO];
        }else if (i==1)
        {
            //位置
            FBSearchMapViewController *SVc =[[FBSearchMapViewController alloc]init];
            SVc.delegate =self;
            [self.navigationController pushViewController:SVc animated:NO];
        }else
        {
            //语音
            MakeVoiceNoticeController  *Mvc =[[MakeVoiceNoticeController alloc]init];
            Mvc.delegate =self;
            [self.navigationController pushViewController:Mvc animated:NO];
            
        }
    }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
}
#pragma  mark - 表的数据源
/*-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_model.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString  *headfooter = @"headfooterId";
   IVLabeltableHeadView *tview=[tableV dequeueReusableHeaderFooterViewWithIdentifier:headfooter];
    if (!tview) {
        
        tview = [[IVLabeltableHeadView alloc]initWithReuseIdentifier:headfooter];
        tview.userInteractionEnabled=YES;
    }
    FBindexTapGestureRecognizer  *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionTapClick:)];
    tap.index = section;
    [tview addGestureRecognizer:tap];
    return tview;
}
-(void)sectionTapClick:(FBindexTapGestureRecognizer*)tap
{
    
}*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        MyShouCangModel *model =arr_model[indexPath.row];
    if ([model.Collection.type integerValue]>9) {
        return 120;
    }else
    {
    float width =(DEVICE_WIDTH-40)/3.0;

    if ([model.Collection.type integerValue]==5 || [model.Collection.type integerValue]==6) {
        return 40+40+25;
    }else if ([model.Collection.type integerValue]==2)
    {
        CGSize size = [model.Collection.content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        return 40+size.height+30;
    }else
    {
    
    return width+65;
    }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      MyShouCangModel *model =arr_model[indexPath.row];
    
    if ([model.Collection.type integerValue] >9) {
        static NSString *cellId=@"cellID1";
        FB_CollectionLinkTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FB_CollectionLinkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell setModel2:model];
        FBindexpathLongPressGestureRecognizer  *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
        longPress.indexPath =indexPath;
        [cell addGestureRecognizer:longPress];
        return cell;
        
    }else
    {
    
    
    
    static NSString *cellId=@"cellID";
    MyShouCangTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MyShouCangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
  
    [cell setModel:model];
    FBindexpathLongPressGestureRecognizer  *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath =indexPath;
    [cell addGestureRecognizer:longPress];
    
    return cell;
    }
}

-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longPress
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr=@[@"移动至分组",@"删除"];
    for(int i=0;i<tarr.count;i++)
    {
    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MyShouCangModel *model =arr_model[longPress.indexPath.row];
        if (i==0) {
            ShouCangGroupViewController  *Svc =[[ShouCangGroupViewController alloc]init];
            Svc.delegate =self;
            Svc.model =model;
            [self.navigationController pushViewController:Svc animated:NO];
            
        }else if (i==1)
        {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Collection_Del_collectionsWithowner:user.Guid collections:model.Collection.Id And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
        }else
        {
        }
    }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyShouCangModel  *model =arr_model[indexPath.row];
    if ([model.Collection.type integerValue]==1) {
        FBShowimg_moreViewController  *Mvc =[[FBShowimg_moreViewController alloc]init];
        Mvc.arr_imgs = model.Collection.arr_urls;
        [self.navigationController pushViewController:Mvc animated:NO];
    }else if ([model.Collection.type integerValue]==2 || [model.Collection.type integerValue]==3 || [model.Collection.type integerValue]==4 || [model.Collection.type integerValue]==7 ||[model.Collection.type integerValue]==8 || [model.Collection.type integerValue]==9)
    {
        FBShowImg_TextViewController  *ITvc =[[FBShowImg_TextViewController alloc]init];
        ITvc.contents=model.Collection.content;
        ITvc.contentTitle = model.Collection.title;
        ITvc.arr_imgs = model.Collection.arr_urls;
        [self.navigationController pushViewController:ITvc animated:NO];
    }else if ([model.Collection.type integerValue]==5)
    {
        //语音
        AVPlayerViewController  *Pvc =[[AVPlayerViewController alloc]init];
        AVPlayer  *player = [AVPlayer playerWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]]];
        [player play];
        Pvc.player =player;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController presentViewController:Pvc animated:NO completion:nil];
        });
    }else if ([model.Collection.type integerValue]==6)
    {
        //位置
        FBSearchMapViewController  *Mvc =[[FBSearchMapViewController alloc]init];
        NSArray *tarr = [model.Collection.position componentsSeparatedByString:@","];
        Mvc.coor2d = CLLocationCoordinate2DMake([tarr[0] doubleValue], [tarr[1] doubleValue]);
        
        [self.navigationController pushViewController:Mvc animated:NO];
    }else if ([model.Collection.type integerValue]==10)
    {
        //易企阅
        EQDR_Article_DetailViewController *Dvc =[[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId = model.Collection.dataid;
        [self.navigationController pushViewController:Dvc animated:NO];
        
        
    }else if ([model.Collection.type integerValue]==0)
    {
        //工作圈
        NSArray  *tarr1 =[model.Collection.url componentsSeparatedByString:@"?"];
        NSString *tstr1 = tarr1[1];
        NSArray *tarr2 =[tstr1 componentsSeparatedByString:@"&"];
        NSString *tstr2  = tarr2[0];
        NSArray *tarr3 = [tstr2 componentsSeparatedByString:@"="];
        NSString *Id = tarr3[1];
       
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在加载";
            [WebRequest Get_WorkCircle_ByIdWithworkCircleId:Id userGuid:user.Guid And:^(NSDictionary *dic) {
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    
                    GongZuoQunModel *model = [GongZuoQunModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        GZQ_PingLunViewController  *PLvc = [[GZQ_PingLunViewController alloc]init];
                        PLvc.model = model;
                        [self.navigationController pushViewController:PLvc animated:NO];
                    });
                    
                }else
                {
                    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                    [alert showAlertWith:@"该文件已被删除"];
                }
            }];
    }
    else
    {
        
    }
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        MyShouCangModel *model =arr_model[indexPath.row];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest Collection_Del_collectionsWithowner:user.Guid collections:model.Collection.Id And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeObject:model];
                [tableV reloadData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma  mark - 自定义的协议代理
-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在添加";
    if (text.length==0 && imgArr.count!=0) {
        [WebRequest Collection_Add_collectionWithowner:user.Guid imgArr:imgArr tel:user.uname sourceOwner:user.Guid source:@"我的收藏"  And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            
        }];
    }else if (text.length!=0 && imgArr.count==0)
    {
        [WebRequest Collection_Add_collectionWithowner:user.Guid title:@"我的收藏" ccontent:text tel:user.uname sourceOwner:user.Guid source:@"我的收藏"  And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
        }];
        
    }else if (text.length!=0&&imgArr.count!=0)
    {
        [WebRequest Collection_Add_collectionWithowner:user.Guid type:imgArr.count==1?@"3":@"4" title:@"我的收藏" ccontent:text imgArr:imgArr tel:user.uname  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
        }];
    }
    else
    {
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
}
///获取录音的data流 mp3格式的
-(void)getvoiceData:(NSData *)data time:(NSString *)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在添加";
    [WebRequest Collection_Add_collectionWithowner:user.Guid data:data tel:user.uname ccontent:time sourceOwner:user.Guid source:@"我的收藏"  And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}
-(void)mapAddress:(NSString *)mapadress location:(CLLocationCoordinate2D)coor2d
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在收藏地址";
    NSString *tstr = [NSString stringWithFormat:@"%f,%f",coor2d.latitude,coor2d.longitude];
    
    [WebRequest Collection_Add_collectionWithowner:user.Guid position:tstr  ccontent:mapadress sourceOwner:user.Guid  source:@"我的收藏"  And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
    
    
   
}

@end
