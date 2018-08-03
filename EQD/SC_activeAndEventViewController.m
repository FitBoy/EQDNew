//
//  SC_activeAndEventViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_activeAndEventViewController.h"
#import "Image_textModel.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import "FBWebUrlViewController.h"
#import "EQD_HtmlTool.h"
@interface SC_activeAndEventViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation SC_activeAndEventViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.temp ==0) {
        ///领导活动
        
        [WebRequest ComSpace_ComSpaceActivities_Get_ComSpaceActivitiesWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue] ==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page = dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    Image_textModel *model = [Image_textModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            
            }
        }];
    }else if (self.temp ==1)
    {
        //先进事迹
        
        [WebRequest ComSpace_ComSpace_Event_Get_ComSpaceEventWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue] ==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page = dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    Image_textModel *model = [Image_textModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                
            }
        }];
    }
}
-(void)loadOtherData{
    if (self.temp ==0) {
        [WebRequest ComSpace_ComSpaceActivities_Get_ComSpaceActivitiesWithcompanyId:self.comId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue] ==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    Image_textModel *model = [Image_textModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
                
            }
        }];
    }else if(self.temp ==1)
    {
        [WebRequest ComSpace_ComSpace_Event_Get_ComSpaceEventWithcompanyId:self.comId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue] ==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    Image_textModel *model = [Image_textModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
                
            }
        }];
    }else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    page = @"0";
    self.navigationItem.title = self.temp ==0? @"领导活动":@"先进事迹";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    Image_textModel *model =arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Image_textModel  *model =arr_model[indexPath.row];
    
    NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
//    contents.yy_alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    time.yy_alignment = NSTextAlignmentRight;
    [contents appendAttributedString:time];
    contents.yy_lineSpacing =6;
    cell.YL_content.attributedText = contents;
    CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-45, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height =size.height +20;
    [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-30);
    }];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Image_textModel *model =arr_model[indexPath.row];
    if (self.temp ==1) {
        FBWebUrlViewController  *Wvc = [[FBWebUrlViewController alloc]init];
        Wvc.url = [EQD_HtmlTool getEventDetailWithId:model.Id];
        Wvc.contentTitle = @"先进事迹";
        [self.navigationController pushViewController:Wvc animated:NO];
    }else
    {
    FBWebUrlViewController  *Wvc = [[FBWebUrlViewController alloc]init];
    Wvc.url = [EQD_HtmlTool getActiveFromLingdaoWithId:model.Id];
    Wvc.contentTitle = @"领导活动";
    [self.navigationController pushViewController:Wvc animated:NO];
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
        //s删除
        Image_textModel *model =arr_model[indexPath.row];
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"您确定删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            if(self.temp ==0)
            {
                //领导活动
                [WebRequest ComSpace_ComSpaceActivities_Delete_ComSpaceActivitiesWithuserGuid:user.Guid companyId:user.companyId activitiesId:model.Id And:^(NSDictionary *dic) {
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model removeObject:model];
                        [tableV reloadData];
                    }else
                    {
                        MBFadeAlertView *alert2 = [[MBFadeAlertView alloc]init];
                        [alert2 showAlertWith:@"未知错误，请重试"];
                    }
                }];
            }else if (self.temp ==1)
            {
                //先进事迹
                [WebRequest ComSpace_ComSpace_Event_Delete_ComSpaceEventWithuserGuid:user.Guid companyId:user.companyId eventId:model.Id And:^(NSDictionary *dic) {
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model removeObject:model];
                        [tableV reloadData];
                    }else
                    {
                        MBFadeAlertView *alert2 = [[MBFadeAlertView alloc]init];
                        [alert2 showAlertWith:@"未知错误，请重试"];
                    }
                }];
            }else
            {
                
            }
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
