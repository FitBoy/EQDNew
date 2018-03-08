//
//  EQDS_CourseDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_CourseDetailViewController.h"
#import "PX_courseManageModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "EQDS_VideoModel.h"
@interface EQDS_CourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    PX_courseManageModel *model_detail;
    NSMutableArray *arr_model;
    UserModel *user;
    float  row_2;
}

@end

@implementation EQDS_CourseDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Lectures_course_Get_LectureCourse_ByIdWithcourseId:self.courseId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [PX_courseManageModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            model_detail.cell_height =60;
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    [WebRequest Lectures_course_Get_CourseVideoWithcourseId:self.courseId page:@"0" And:^(NSDictionary *dic) {
        
    }];
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    row_2 =1;

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return model_detail.cell_height;
        }else
        {
            return row_2;
        }
    }else
    {
        return 60;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *tarr = @[@"课程信息",@"相关视频"];
    
    return tarr[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return model_detail==nil?0:2 ;
    }else
    {
        return arr_model.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0)
    {
    static NSString *cellId=@"cellID0";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        if (indexPath.row==0) {
        NSMutableAttributedString  *thetheme =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_detail.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]}];
        thetheme.yy_alignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *courseType = [[NSMutableAttributedString alloc]initWithString:@""];
        NSArray *tarr = [model_detail.courseType componentsSeparatedByString:@","];
        for (int i=0; i<tarr.count; i++) {
            NSMutableAttributedString  *courseType2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            [courseType2 yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:courseType2.yy_rangeOfAll];
            [courseType2 yy_setTextHighlightRange:courseType2.yy_rangeOfAll color:[UIColor orangeColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
            }];
            
            [courseType appendAttributedString:courseType2];
            NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
            [courseType appendAttributedString:kong];
        }
            NSMutableAttributedString *kong1 = [[NSMutableAttributedString alloc]initWithString:@"\n"];
            [courseType appendAttributedString:kong1];
        courseType.yy_alignment = NSTextAlignmentCenter;
        
            [thetheme appendAttributedString:courseType];
            
        NSMutableAttributedString  *NameTime = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@\n",model_detail.lectureName,model_detail.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            NameTime.yy_alignment =NSTextAlignmentRight;
        [thetheme appendAttributedString:NameTime];
        
        NSMutableAttributedString *courseObjecter = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"授课对象%@",model_detail.courseObjecter] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        [thetheme appendAttributedString:courseObjecter];
        NSMutableAttributedString *courseTarget = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n课程目标:%@",model_detail.courseTarget] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        [thetheme appendAttributedString:courseTarget];
        
        NSMutableAttributedString *courseBackground = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n课程背景：%@",model_detail.courseBackground] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        
        [thetheme appendAttributedString:courseBackground];
        NSMutableAttributedString *priceTimes = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n参考价格：%@元/天    课程时长： %@天 (%ld小时)",model_detail.coursePrice,model_detail.courseTimes,[model_detail.courseTimes integerValue]*6] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        
        [thetheme appendAttributedString:priceTimes];
        thetheme.yy_lineSpacing =6;
        CGSize size = [thetheme boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model_detail.cell_height = size.height+10;
            
        cell.YL_label.attributedText = thetheme;
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height +10);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            
        }else
        {
            NSString * htmlString = [NSString stringWithFormat:@"<html><body style = \"font-size:17px\">课程大纲：%@ </body></html>",model_detail.courseOutlint];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            CGSize size2 = [attrStr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            row_2 = size2.height+10;
            cell.YL_label.attributedText =attrStr;
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size2.height +10);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
        }
    return cell;
        
    }else
    {
        static NSString *cellId=@"cellID1";
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




@end
