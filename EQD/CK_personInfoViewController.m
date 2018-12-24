//
//  CK_personInfoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_personInfoViewController.h"
#import "FBOne_img2TableViewCell.h"
#import <UIImageView+WebCache.h>
#import "LoadWordViewController.h"
#import "FBShowimg_moreViewController.h"
@interface CK_personInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    TeacherInfo_EQDS   *teacherInfo;
    NSArray *arr_name0;
    NSMutableArray *arr_contents0;
}

@end

@implementation   CK_personInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    [self getTeacherinfo];
    teacherInfo = [WebRequest getTeacherInfo];
    [self setTableVData];

}
-(void)setTableVData{
    arr_name0 = @[@"头像",@"助理",@"助理手机",@"个人手机",@"邮箱",@"QQ",@"微信",@"常驻城市",@"个人简介",@"主讲课程",@"课程价格/元",@"授课风格",@"研究领域",@"客户案例",@"服务过的企业",@"资质证明"];
    arr_contents0 = [NSMutableArray arrayWithArray:@[teacherInfo.headimage,teacherInfo.Assistant,teacherInfo.AssistantPhone,teacherInfo.phone,teacherInfo.email,teacherInfo.QQ,teacherInfo.wechat,teacherInfo.address,@"查看",teacherInfo.courses,teacherInfo.CooperativePrice,@"查看",teacherInfo.ResearchField,@"查看",@"查看",@"查看"]];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_name0.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row==0) {
        
        FBOne_img2TableViewCell  *cell = [[FBOne_img2TableViewCell alloc]init];
        cell.L_left0.text =arr_name0[0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:arr_contents0[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        return cell;
    }else
    {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
        if(indexPath.row==8 || indexPath.row==11 || indexPath.row==13 || indexPath.row==14 || indexPath.row==15)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text =arr_name0[indexPath.row];
        cell.detailTextLabel.text =arr_contents0[indexPath.row];
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //头像
        UIImagePickerController  *picker = [[UIImagePickerController alloc]init];
        picker.delegate =self;
        picker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:picker animated:NO completion:nil];
            });
        }
        
        
    }else if (indexPath.row ==8)
    {
        //个人简介
        LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
        Lvc.contentTitle = @"个人简介";
        Lvc.html = teacherInfo.LecturerBackground;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==13)
    {
        //客户案例
        LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
        Lvc.contentTitle = @"客户案例";
        Lvc.html = teacherInfo.CustCase;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==14)
    {
        //服务企业
        LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
        Lvc.contentTitle = @"服务企业";
        Lvc.html = teacherInfo.ServiceCom;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==11)
    {
        //授课风格
        LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
        Lvc.contentTitle = @"授课风格";
        Lvc.content = teacherInfo.TeachStyle;
        [self.navigationController pushViewController:Lvc animated:NO];
        
    }else if (indexPath.row==15)
    {
        //资质
        FBShowimg_moreViewController *Svc =[[FBShowimg_moreViewController alloc]init];
        NSMutableArray  *tarr = [NSMutableArray arrayWithArray:[teacherInfo.Qualifications componentsSeparatedByString:@";"]];
        [tarr removeLastObject];
        NSMutableArray *tarr2 =[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<tarr.count; i++) {
            NSString *tstr = tarr[i];
            [tarr2 addObject:[NSString stringWithFormat:@"%@%@",HTTP_PATH,tstr]];
        }
        Svc.arr_imgs = tarr2;
        [self.navigationController pushViewController:Svc animated:NO];
    }else
    {
        
    }
}




@end
