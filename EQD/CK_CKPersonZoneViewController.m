//
//  CK_CKPersonZoneViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_CKPersonZoneViewController.h"
#import "FBHeadScrollTitleView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "FBButton.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "WS_liuYanModel.h"
#import "WS_LiuYanTableViewCell.h"
@interface CK_CKPersonZoneViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    Com_UserModel *model_user;
    UIView *head_view;
    FBHeadScrollTitleView *titleV;
    NSInteger  selected_index;
   // @"日志",@"产品",@"相册",@"留言",@"访客",@"收藏"
    NSMutableArray *arr_model_rizhi;
    NSMutableArray *arr_products;
    NSMutableArray *arr_pictures;
    NSMutableArray *arr_liuyan;
    NSString *page_liuyan;
    NSMutableArray *arr_fangke;
    NSMutableArray *arr_shoucang;
    FBButton *tbtn_liuyan;
    NSArray *arr_big;
    float scrollY;
    UserModel *user;
}

@end

@implementation CK_CKPersonZoneViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest Com_User_BusinessCardWithuserGuid:self.userGuid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue] == 200) {
            model_user = [Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            dispatch_async(dispatch_get_main_queue(), ^{
                  [self setHeadViewWithuserModel:model_user];
            });
          
        }
    }];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WebRequest Makerspacey_MakerVisitor_Add_MakerVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"创客空间" makerGuid:self.userGuid option:@"访问了您的创客空间" And:^(NSDictionary *dic) {
            
        }];
    });
}
-(void)loadRequestData{
    if (selected_index ==3) {
        [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page_liuyan = dic[@"page"];
                [arr_liuyan removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    WS_liuYanModel  *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                    [arr_liuyan addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
}
-(void)loadMoreData{
    if (selected_index ==3) {
        [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:self.userGuid page:page_liuyan And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page_liuyan = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    WS_liuYanModel  *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                    [arr_liuyan addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}

-(void)setHeadViewWithuserModel:(Com_UserModel*)tmodel{
    head_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 100)];
    head_view.userInteractionEnabled =YES;
    UIImageView *IV_image= [[UIImageView alloc]init];
    [IV_image sd_setImageWithURL:[NSURL URLWithString:tmodel.photo] placeholderImage:[UIImage imageNamed:@"eqd"]];
    [head_view addSubview:IV_image];
    [IV_image  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(head_view.mas_left).mas_offset(15);
        make.top.mas_equalTo(head_view.mas_top).mas_offset(5);
    }];
    
    FBButton  *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [head_view addSubview:tbtn];
    [tbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.mas_equalTo(head_view.mas_right).mas_offset(-15);
        make.top.mas_equalTo(head_view.mas_top).mas_offset(10);
    }];
    [tbtn setTitle:@"收藏" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:15]];
    titleV   = [[FBHeadScrollTitleView alloc]init];
    [head_view addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.mas_equalTo(head_view);
        make.bottom.mas_equalTo(head_view.mas_bottom).mas_offset(-5);
    }];
    titleV.delegate_head = self;
    [titleV setArr_titles:@[@"日志",@"产品",@"相册",@"留言",@"访客",@"收藏"]];
    [titleV setClickTapIndex:0];
    
    
    //名字
    UILabel *L_name = [[UILabel alloc]init];
    [head_view addSubview:L_name];
    [L_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(IV_image.mas_right).mas_offset(5);
        make.top.mas_equalTo(IV_image.mas_top);
        make.right.mas_equalTo(tbtn.mas_left).mas_offset(-5);
    }];
    L_name.text = tmodel.username;
    L_name.font = [UIFont systemFontOfSize:15];
    
    tableV.tableHeaderView = head_view;
    
   
    
}
-(void)getSelectedIndex:(NSInteger)index
{
    ///选中的是哪个模块
    selected_index = index;
    NSArray *tarr = arr_big[index];
    if (tarr.count==0) {
        [self loadRequestData];
    }else
    {
    [tableV reloadData];
    }
    
    if (index ==1) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [WebRequest Makerspacey_MakerVisitor_Add_MakerVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"产品列表" makerGuid:self.userGuid option:@"访问了您的产品列表" And:^(NSDictionary *dic) {
                
            }];
        });
        
      
    }
    if (index ==3) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [WebRequest Makerspacey_MakerVisitor_Add_MakerVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"留言" makerGuid:self.userGuid option:@"访问了您的创客留言" And:^(NSDictionary *dic) {
                
            }];
        });
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    scrollY =0;
    user = [WebRequest GetUserInfo];
  arr_model_rizhi = [NSMutableArray arrayWithCapacity:0];
   arr_products= [NSMutableArray arrayWithCapacity:0];
    arr_pictures= [NSMutableArray arrayWithCapacity:0];
    arr_liuyan= [NSMutableArray arrayWithCapacity:0];
    arr_fangke= [NSMutableArray arrayWithCapacity:0];
    arr_shoucang= [NSMutableArray arrayWithCapacity:0];
    arr_big = @[arr_model_rizhi,arr_products,arr_pictures,arr_liuyan,arr_fangke,arr_shoucang];
    self.navigationItem.title = @"个人的创客空间";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tbtn_liuyan = [[FBButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40)];
    [tbtn_liuyan setTitle:@"留言" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:21]];
    [tbtn_liuyan addTarget:self action:@selector(tbtnLiuyanCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tbtn_liuyan];
    tbtn_liuyan.hidden = YES;
    
}
#pragma  mark - 留言
-(void)getPresnetText:(NSString *)text
{
    [WebRequest Makerspacey_MakerLeaveMsg_Add_MakerLeaveMsgWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:@"0" makerGuid:self.userGuid parentUserGuid:@" " firstCommentId:@"0" objectId:@"0" objectType:@"0" And:^(NSDictionary *dic) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"留言成功"];
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试！"];
        }
    }];
}
#pragma  mark - 弹出留言框
-(void)tbtnLiuyanCLick
{
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.delegate =self;
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.btnName = @"发送";
    LYvc.placeHolder = @"想对他(她)说什么……";
    [self presentViewController:LYvc animated:NO completion:nil];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (selected_index) {
        case 0:
        {
           return  arr_model_rizhi.count;
        }
            break;
        case 1:
        {
            return arr_products.count;
        }
            break;
        case 2:
        {
            return arr_pictures.count;
        }
            break;
        case 3:
        {
            return arr_liuyan.count;
        }
            break;
        case 4:
        {
            return arr_fangke.count;
        }
            break;
        case 5:
        {
            return arr_shoucang.count;
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selected_index ==3) {
        WS_liuYanModel  *model =arr_liuyan[indexPath.row];
        return model.cell_height;
    }else
    {
        return 60;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selected_index ==3) {
        static NSString *cellId=@"cellID3";
        WS_LiuYanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WS_LiuYanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        WS_liuYanModel  *model =arr_liuyan[indexPath.row];
        [cell setModel_liuyan:model];
        return cell;
    }else
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < scrollY && selected_index ==3) {
        //向上滑
        tbtn_liuyan.hidden = NO;
    }else
    {
        //向下
        tbtn_liuyan.hidden = YES;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (selected_index ==3) {
        tbtn_liuyan.hidden = NO;
    }else
    {
        tbtn_liuyan.hidden = YES;
    }
}




@end
