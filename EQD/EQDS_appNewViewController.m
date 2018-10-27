//
//  EQDS_appNewViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_appNewViewController.h"
#import "FBScrollView.h"
#import "FBButton.h"
#import "CK_personAppViewController.h"
#import "S_tableHeadView.h"
#import "eQDS_teacherAndSearchModel.h"
#import "FBimage_name_text_btnTableViewCell.h"
#import "S_teacherSearchViewController.h"
#import "S_courseSearchViewController.h"
#import "S_NeedSearchViewController.h"
#import "EQDS_CourseModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "EQDS_BaseModel.h"
#import "EQDR_ShouYeViewController.h"
#import "S_huodongHomeViewController.h"
#import "app_headView.h"
@interface EQDS_appNewViewController ()<app_headViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    
    
    UIView  *V_tableHead;
    app_headView *V_headFooter;
    UserModel *user;
    NSArray *arr_headTitle;
    
    NSMutableArray *arr_teacherTuijian ;
    NSMutableArray *arr_needTuijian;
    NSMutableArray *arr_courseTuijian;
    
    NSMutableArray *arr_teacherHuoyue;
    NSMutableArray *arr_needNew;
    NSMutableArray *arr_courseNew;
    NSMutableArray *arr_articleNew;
    
}
@end

@implementation EQDS_appNewViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadRequestData];
 
}
#pragma  mark - 头部的 点击事件
-(void)appHeadSelectedIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            //找课程
            S_courseSearchViewController  *Svc = [[S_courseSearchViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:NO];
        }
            break;
        case 1:
        {
            //找讲师
            S_teacherSearchViewController  *Svc = [[S_teacherSearchViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:NO];
        }
            break;
        case 2:
        {
            //找需求
            S_NeedSearchViewController *NSvc = [[S_NeedSearchViewController alloc]init];
            
            [self.navigationController pushViewController:NSvc animated:NO];
        }
            break;
        case 4:
        {
            ///看文章  跳转到易企阅
            EQDR_ShouYeViewController *SYvc = [[EQDR_ShouYeViewController alloc]init];
            [self.navigationController pushViewController:SYvc animated:NO];
            
        }
            break;
        case 3:
        {
            //找活动
            S_huodongHomeViewController *Hvc = [[S_huodongHomeViewController alloc]init];
            [self.navigationController pushViewController:Hvc animated:NO];
        }
            break;
            
        default:
            break;
    }
}
-(void)arr_modelinit{
     arr_teacherTuijian=[NSMutableArray arrayWithCapacity:0] ;
   arr_needTuijian=[NSMutableArray arrayWithCapacity:0] ;
   arr_courseTuijian=[NSMutableArray arrayWithCapacity:0] ;
    
    arr_teacherHuoyue=[NSMutableArray arrayWithCapacity:0] ;
    arr_needNew=[NSMutableArray arrayWithCapacity:0] ;
    arr_courseNew=[NSMutableArray arrayWithCapacity:0] ;
    arr_articleNew=[NSMutableArray arrayWithCapacity:0] ;
    
}

-(void)loadRequestData{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
 
    //代表http访问返回的数量
    //这里模仿的http请求block块都是在同一线程（主线程）执行返回的，所以对这个变量的访问不存在资源竞争问题，故不需要枷锁处理
    //如果网络请求在不同线程返回，要对这个变量进行枷锁处理，不然很会有资源竞争危险
    __block NSInteger httpFinishCount = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        ///获取推荐的讲师
        [WebRequest Lectures_recommend_Get_LectureRecommendWithtype:@"0" And:^(NSDictionary *dic) {
            
            if (++httpFinishCount == arr_headTitle.count) {
                dispatch_semaphore_signal(sem);
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshingWithNoMoreData];
            [arr_teacherTuijian removeAllObjects];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    eQDS_teacherAndSearchModel  *model = [eQDS_teacherAndSearchModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_teacherTuijian addObject:model];
                }
                
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        ///推荐的需求
        if (++httpFinishCount == arr_headTitle.count) {
            dispatch_semaphore_signal(sem);
        }
       ///推荐的课程
        [WebRequest Lectures_course_Get_LectCourse_ByRecommendAnd:^(NSDictionary *dic) {
            if (++httpFinishCount == arr_headTitle.count) {
                dispatch_semaphore_signal(sem);
            }
            [tableV.mj_footer endRefreshingWithNoMoreData];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_courseTuijian removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_CourseModel  *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_courseTuijian addObject:model];
                }
                 [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
    ///活跃的讲师
        [WebRequest Makerspacey_MakerArticle_Get_ActiveMakerWithpage:@"0" And:^(NSDictionary *dic) {
            if (++httpFinishCount == arr_headTitle.count) {
                dispatch_semaphore_signal(sem);
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_teacherHuoyue removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_teacherHuoyue addObject:model];
                }
                  [tableV reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        //最新的需求
        [WebRequest Training_Trains_Get_TrainingByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            if (++httpFinishCount == arr_headTitle.count) {
                dispatch_semaphore_signal(sem);
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_needNew removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_needNew addObject:model];
                    }
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
                
            }
        }];
        ///最新的课程
        [WebRequest Lectures_course_Get_CourseByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_courseNew removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_CourseModel *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_courseNew addObject:model];
                }
                 [tableV reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        ///最新的文章
        [WebRequest Articles_LectureArticle_Get_ArticlesByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_articleNew removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_BaseModel  *model = [EQDS_BaseModel mj_objectWithKeyValues:tarr[i]];
                    [arr_articleNew addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        //demo testUsingSemaphore方法是在主线程调用的，不直接调用遍历执行，而是嵌套了一个异步，是为了避免主线程阻塞
//        NSLog(@"start all http dispatch in thread: %@", [NSThread currentThread]);
     /*   [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
          
            
           [self httpRequest:nil param:@{commandKey : obj} completion:^(id response) {
                //全部请求返回才触发signal
                if (++httpFinishCount == commandCount) {
                    dispatch_semaphore_signal(sem);
                }
            }];
        }];*/
        //如果全部请求没有返回则该线程会一直阻塞
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//        NSLog(@"all http request done! end thread: %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"UI update in main thread!");
            [tableV reloadData];
        });
    });
    
   
    
    
   
    
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"金师库";
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.backgroundColor = [UIColor whiteColor];
    [self arr_modelinit];
  
    V_tableHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200+50)];
    V_tableHead.userInteractionEnabled = YES;
    V_tableHead.backgroundColor = [UIColor whiteColor];
    FBScrollView  *ScrollV = [[FBScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    [ScrollV setArr_urls:@[@"www.eqidd.com"]];
    [V_tableHead addSubview:ScrollV];
    
    
    V_headFooter = [[app_headView alloc]init];
    V_headFooter.delegate_appHead  =self;
    [V_tableHead addSubview:V_headFooter];
//     GNmodel img  name
    NSArray *theadArr = @[
                          @{
                              @"img":@"c_kecheng",
                              @"name":@"找课程"
                              },
                          @{
                              @"img":@"c_teacher",
                              @"name":@"找讲师"
                              },
                          @{
                              @"img":@"c_need",
                              @"name":@"找需求"
                              },
                          @{
                              @"img":@"c_huodong",
                              @"name":@"找活动"
                              },
                          @{
                              @"img":@"c_article",
                              @"name":@"新闻洞察"
                              }
                          ];
    NSMutableArray *tarrModel=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<theadArr.count; i++) {
        GNmodel *tmodel = [GNmodel mj_objectWithKeyValues:theadArr[i]];
        [tarrModel addObject:tmodel];
    }
    
   float height =  [V_headFooter  resetFrameWithArrModels:tarrModel];
    V_headFooter.frame = CGRectMake(0, 210, DEVICE_WIDTH, height);
    V_tableHead.frame = CGRectMake(0, 0, DEVICE_WIDTH, 210+height);
    tableV.tableHeaderView = V_tableHead;
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"me_focu"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    [self.navigationItem setRightBarButtonItem:right];

    arr_headTitle = @[
                      @{
                          @"name":@"推荐讲师",
                          @"hidden":@(YES)
                          },
                      @{
                          @"name":@"推荐需求",
                          @"hidden":@(YES)
                          },
                      @{
                          @"name":@"推荐课程",
                          @"hidden":@(YES)
                          },
                      @{
                          @"name":@"活跃讲师",
                          @"hidden":@(YES)
                          },
                      @{
                          @"name":@"最新需求",
                          @"hidden":@(YES)
                          },
                      @{
                          @"name":@"最新课程",
                          @"hidden":@(YES)
                          },
                      @{
                          @"name":@"最新文章",
                          @"hidden":@(YES)
                          },
                      
                      ];
    
    [self loadRequestData];

    
}
-(void)rightClick
{
    //创客空间
    CK_personAppViewController  *PZvc = [[CK_personAppViewController alloc]init];
    [self.navigationController pushViewController:PZvc animated:NO];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *footerId = @"footerId";
    S_tableHeadView *headV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerId];
    if (!headV) {
        headV = [[S_tableHeadView alloc]initWithReuseIdentifier:footerId];
        headV.tintColor = [UIColor whiteColor];
    }
    
    NSDictionary *tdic = arr_headTitle[section];
    NSString *name = tdic[@"name"];
    NSNumber *number = tdic[@"hidden"];
    BOOL  hidden = [number boolValue];
    [headV setname:name btnHidden:hidden];
    headV.B_more.temp = section;
    [headV.B_more addTarget:self action:@selector(headTitleMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    return headV;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_headTitle.count;
}
#pragma  mark - 与上面的冲突了，这个舍弃
-(void)headTitleMoreClick:(FBButton*)tbtn
{
    switch (tbtn.temp) {
        case 3:
        {
            //最新需求
        }
            break;
        case 4:
        {
            //最新课程
        }
            break;
        case 5:
        {
            //最新文章
        }
            break;
        default:
            break;
    }
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            eQDS_teacherAndSearchModel *model = arr_teacherTuijian[indexPath.row];
            return model.cell_height;
        }
            break;
            case 1:
        {
            return 0;
        }
            break;
            case 2:
        {
            EQDS_CourseModel *model = arr_courseTuijian[indexPath.row];
            return model.cell_height;
        }
            break;
            case 3:
        {
            EQDS_teacherInfoModel  *model = arr_teacherHuoyue[indexPath.row];
            return model.cellHeight;
        }
            break;
            case 4:
        {
            PXNeedModel *model = arr_needNew[indexPath.row];
            return model.cellHeight;
        }
            break;
            case 5:
        {
            EQDS_CourseModel *model = arr_courseNew[indexPath.row];
            return model.cell_height;
        }
            break;
            case 6:
        {
            EQDS_BaseModel *model = arr_articleNew[indexPath.row];
            return model.cellHeight;
        }
        default:
            return 0;
            break;
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return arr_teacherTuijian.count;
        }
            break;
        case 1:
        {
            return arr_needTuijian.count;
        }
            break;
            case 2:
        {
            return  arr_courseTuijian.count;
        }
            break;
            case 3:
        {
            return arr_teacherHuoyue.count;
        }
            break;
        case 4:
        {
            return arr_needNew.count;
        }
            break;
        case 5:
        {
            return arr_courseNew.count;
        }
            break;
        case 6:
        {
            return arr_articleNew.count;
        }
            break;
        default:
            return 0;
            break;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            //推荐的讲师
            static NSString *cellId=@"cellID";
            FBimage_name_text_btnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBimage_name_text_btnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            eQDS_teacherAndSearchModel  *model = arr_teacherTuijian[indexPath.row];
            [cell setModel_teacher:model];
            return cell;
        }
            break;
        case 1:
        {
            //推荐的需求
            return nil;
        }
            break;
        case 2:
        {
            //推荐的课程
            static NSString *cellId=@"cellID2";
           EQDR_labelTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_CourseModel  *model = arr_courseTuijian[indexPath.row];
            NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
            name.yy_lineSpacing =6;
            
            cell.YL_label.attributedText = name;
            CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            model.cell_height = size.height +15;
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            
            
            return cell;
        }
            break;
        case 3:
        {
            //活跃的讲师
            
            static NSString *cellId=@"cellID3";
            FBimage_name_text_btnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBimage_name_text_btnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            EQDS_teacherInfoModel *model = arr_teacherHuoyue[indexPath.row];
            [cell setModel_info:model];
            
            return cell;
        }
            break;
        case 4:
        {
            //最新的需求
            static NSString *cellId=@"cellID4";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            PXNeedModel  *model =arr_needNew[indexPath.row];
            [cell setModel_need2:model];
            return cell;
        }
            break;
        case 5:
        {
            //最新的课程
            static NSString *cellId=@"cellID5";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_CourseModel *model = arr_courseNew[indexPath.row];
            NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
            time.yy_alignment = NSTextAlignmentRight;
            [name appendAttributedString:time];
            name.yy_lineSpacing =6;
            CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            cell.YL_label.attributedText = name;
            model.cell_height = size.height+15;
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.height.mas_equalTo(size.height+10);
            }];
            return cell;
            
        }
            break;
        case 6:
        {
            //最新的文章
            
            static NSString *cellId=@"cellID6";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_BaseModel *model = arr_articleNew[indexPath.row];
            NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:4]}];
            name.yy_lineSpacing =6;
            cell.YL_label.attributedText = name;
            CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            model.cellHeight = size.height +20;
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
