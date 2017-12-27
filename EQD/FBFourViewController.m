//
//  FBFourViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#import "FBFourViewController.h"
#import "WebRequest.h"
#import "TFAQViewController.h"
#import "FBScrollView.h"
#import "FGongZuoQuanViewController.h"
#import "FBWifiManager.h"
#import "F_ComZoneViewController.h"
#import "RedTipTableViewCell.h"
#import "TrumModel.h"
#import "TZGG_listViewController.h"
#import "Com_ImgModel.h"
#import "FBindexTapGestureRecognizer.h"
#import "FBWebUrlViewController.h"
@interface FBFourViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_all;
    dispatch_source_t  timer;
    dispatch_source_t  timer1;
    FBScrollView *scrollView;
    UserModel *user;
    UILabel *titleLabel1;
    UILabel *titleLabel2;
    
    NSMutableArray *arr_model;
    NSMutableArray *arr_url;
    
    NSMutableArray *arr_code;
}


@end

@implementation FBFourViewController

-(void)laba_Init{
    
    [WebRequest trumpet_Get_trumpetWithuserGuid:user.Guid comid:user.companyId And:^(NSDictionary *dic) {
        TrumModel *model =[TrumModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        NSString *content1 =[model.content substringWithRange:NSMakeRange(0, model.content.length/2)];
        NSString *content2 =[model.content substringWithRange:NSMakeRange(model.content.length/2+1, model.content.length-1-model.content.length/2)];
        CGSize size1 =[content1 boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGSize size2 =[content2 boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        
        titleLabel1.frame =CGRectMake(25, DEVICE_TABBAR_Height, size1.width, 25);
        titleLabel2.frame =CGRectMake(size1.width+25, DEVICE_TABBAR_Height, size2.width, 25);
        titleLabel1.text = content1;
        titleLabel2.text =content2;
        //全局并发队列
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //主队列；属于串行队列
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //定时循环执行事件
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (timer) {
                [[NSRunLoop mainRunLoop]run];
                dispatch_async(mainQueue, ^{
                    CGRect rect1 =titleLabel1.frame;
                    CGRect rect2 =titleLabel2.frame;
                    rect1.origin.x=rect1.origin.x-2;
                    rect2.origin.x=rect2.origin.x-2;
                    if (rect1.origin.x<-size1.width) {
                        rect1.origin.x = size2.width;
                    }
                    if (rect2.origin.x<-size2.width) {
                        rect2.origin.x=size1.width;
                    }
                    titleLabel1.frame = rect1;
                    titleLabel2.frame =rect2;
                });
            }else
            {
                dispatch_source_cancel(timer);
            }
            
        });
        dispatch_source_set_cancel_handler(timer, ^{
            NSLog(@"Cancel Handler");
        });
        dispatch_resume(timer);
        
    }];
    
    
   
}

-(void)initLabel12
{
    UIButton *shengyingBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    shengyingBtn.frame =CGRectMake(0,DEVICE_TABBAR_Height, 25, 25);
    [shengyingBtn setBackgroundColor:[UIColor whiteColor]];
    [shengyingBtn setBackgroundImage:[UIImage imageNamed:@"eqd_voice"] forState:UIControlStateNormal];
    
    __block UILabel *ttitleLabel1 =[[UILabel alloc]init];
    ttitleLabel1.font =[UIFont systemFontOfSize:15];
    ttitleLabel1.textColor = [UIColor redColor];
    ttitleLabel1.textAlignment=NSTextAlignmentCenter;
    __block  UILabel *ttitleLabel2 =[[UILabel alloc]init];
    ttitleLabel2.font =[UIFont systemFontOfSize:15];
    ttitleLabel2.textColor = [UIColor redColor];
    ttitleLabel2.textAlignment=NSTextAlignmentCenter;
    titleLabel1 =ttitleLabel1;
    titleLabel2 =ttitleLabel2;
    [self.view addSubview:titleLabel1];
    [self.view addSubview:titleLabel2];
    [self.view addSubview:shengyingBtn];
    [shengyingBtn bringSubviewToFront:self.view];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recived];
    [self laba_Init];
    [self loadRequestData];
}
-(void)message_recived
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray  *tarr = dic[Y_ITEMS];
            NSInteger  code_four = 0;
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0"]];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==210 ||[dic2[@"code"] integerValue]==220 ) {
                    [arr_code replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_code[1] integerValue]+[dic2[@"count"] integerValue]]];
                    code_four =code_four +[dic2[@"count"] integerValue];
                }else
                {
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
                self.tabBarItem.badgeValue =[self changeWithnumber:code_four];
            });
            
        }
    }];
    
}
-(void)loadRequestData{
    
    [WebRequest ComImage_Get_ComImageWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        [arr_url removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            Com_ImgModel *model =[Com_ImgModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
            [arr_url addObject:model.imageUrl];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
             [scrollView setArr_urls:arr_url];
            //定时循环执行事件
            __block int total =0;
                timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
                dispatch_source_set_timer(timer1, DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
                dispatch_source_set_event_handler(timer1, ^{
                    if (timer1) {
                        [scrollView.scrollV setContentOffset:CGPointMake(scrollView.frame.size.width*total, 0) animated:YES];
                        scrollView.pageControl.currentPage=total;
                        total++;
                        if (total==arr_url.count) {
                            total=0;
                        }
                    }else
                    {
                        dispatch_source_cancel(timer1);
                    }
                });
                dispatch_source_set_cancel_handler(timer1, ^{
                    NSLog(@"Cancel Handler");
                    dispatch_source_cancel(timer1);
                });
                dispatch_resume(timer1);
            
            for (int i=0; i<scrollView.arr_imageView.count; i++) {
                FBindexTapGestureRecognizer *tap =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
                FBIndexpathImageView  *tview =scrollView.arr_imageView[i];
                tap.index =tview.index;
                [tview addGestureRecognizer:tap];
            }
        });
       
    }];
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    Com_ImgModel *model =arr_model[tap.index];
    FBWebUrlViewController *Wvc =[[FBWebUrlViewController alloc]init];
    Wvc.url =model.Url;
    Wvc.contentTitle =model.title;
    Wvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Wvc animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   arr_url=[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"功能列表";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    
    user=[WebRequest GetUserInfo];
    [self initLabel12];
    //滚动图
    
    scrollView =[[FBScrollView alloc]initWithFrame:CGRectMake(15, 25+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, (DEVICE_WIDTH-30)/2.0)];
   
    [self.view addSubview:scrollView];

    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(kuaijiefangshi)];
    [self.navigationItem setRightBarButtonItem:right];
    ///@[@"qiye.png",@"企业空间"],,@[@"peixuns.png",@"企业商学院"],@[@"kech.png",@"企业看板"],@[@"rongyuqiang.png",@"荣誉墙"],@[@"lejuandan.png",@"乐捐单"],@[@"jifen.png",@"积分榜"],@[@"gere.png",@"驾驶舱"] @[@"eqd_friend",@"客户圈"],
    arr_all =[NSMutableArray arrayWithArray:@[@[@"gongzuo.png",@"工作圈"],@[@"ggao.png",@"通知-公告"]]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,25+DEVICE_TABBAR_Height+(DEVICE_WIDTH-30)/2.0, DEVICE_WIDTH, CGRectGetMinY(self.tabBarController.tabBar.frame)-DEVICE_TABBAR_Height-25-(DEVICE_WIDTH-30)/2.0) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
//    tableV.tableHeaderView =scrollView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recived) name:Z_FB_message_received object:nil];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_all.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTipTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *arr =arr_all[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:arr[0]];
    cell.textLabel.text=arr[1];
    if ([arr_code[indexPath.row] integerValue]>0) {
        cell.L_RedTip.hidden=NO;
        cell.L_RedTip.text =arr_code[indexPath.row];
    }else
    {
        cell.L_RedTip.hidden=YES;
    }
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            if([user.authen integerValue]==1)
            {
            NSLog(@"工作圈");
            FGongZuoQuanViewController *GZvc =[[FGongZuoQuanViewController alloc]init];
            GZvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:GZvc animated:NO];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"您未实名认证，不能查看";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
        }
            break;
        case 1:
        {
            if([user.companyId integerValue]>0)
            {
             NSLog(@"公告");
            TZGG_listViewController  *Lvc =[[TZGG_listViewController alloc]init];
            Lvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:Lvc animated:NO];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"您未加入企业，不能查看";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
        }
            break;
       
        case 3:
        {
            NSLog(@"企业商学院");
        }
            break;
        case 4:
        {
            NSLog(@"企业看板");
        }
            break;
        case 5:
        {
            NSLog(@"荣誉墙");
        }
            break;
        case 6:
        {
            NSLog(@"乐捐单");
        }
            break;
        case 7:
        {
            NSLog(@"积分榜");
        }
            break;
        case 8:
        {
            NSLog(@"驾驶舱");
        }
            break;
            
        default:
            break;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (timer) {
        dispatch_source_cancel(timer);
    }
    if (timer1) {
         dispatch_source_cancel(timer1);
    }
    
   
}
@end
