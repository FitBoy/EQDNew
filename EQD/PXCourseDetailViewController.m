//
//  PXCourseDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXCourseDetailViewController.h"

@interface PXCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_names1;
    NSArray *arr_names2;
    NSArray *arr_names3;
    
    NSMutableArray *arr_contents1;
    NSMutableArray *arr_contents2;
    NSMutableArray *arr_contents3;
    UserModel *user;
    NSArray *arr_titles;
    
}

@end

@implementation PXCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_titles = @[@"课程信息",@"讲师信息",@"其他"];
    arr_names1 =@[];
    [WebRequest  Courses_Get_CourseByIdWithcourseId:self.courseId And:^(NSDictionary *dic) {
        
    }];
}



@end
