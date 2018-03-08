//
//  EQDS_addVideoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_addVideoViewController.h"
#import "FBTextField.h"
#import "FBButton.h"
#import "FBOne_img2TableViewCell.h"
#import <UIImageView+WebCache.h>
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBShowimg_moreViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
@interface EQDS_addVideoViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FB_PXLeiBieChooseViewControllerdelegate>
{
    UIView *V_url;
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    FBTextField  *TFvc;
    UserModel *user;
    NSString *player;
    NSString *videoId ;
    NSArray *arr_leibie;
    NSString *videoTime;
}

@end

@implementation EQDS_addVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"发布视频";
    arr_names = @[@"视频链接",@"视频标题",@"视频封面",@"视频分类",@"视频描述"];
    
    [self settableV];
    [self settview];
    tableV.hidden =YES;
    

}
-(void) settview{
    V_url = [[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+10, DEVICE_WIDTH, 80)];
    V_url.userInteractionEnabled =YES;
    [self.view addSubview:V_url];
   TFvc = [[FBTextField alloc]initWithFrame:CGRectMake(0, 5, DEVICE_WIDTH-50, 40)];
    TFvc.placeholder = @"把优酷视频的网址粘贴在这里";
    [V_url addSubview:TFvc];
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, DEVICE_WIDTH, 30)];
    tlabel.textColor = [UIColor grayColor];
    tlabel.font = [UIFont systemFontOfSize:13];
    tlabel.numberOfLines =0;
    tlabel.text = @"目前仅支持优酷视频的网页链接，后续会相应的增加";
    [V_url addSubview:tlabel];
    FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    tbtn.frame = CGRectMake(DEVICE_WIDTH-50, 5, 45, 40);
    [tbtn setTitle:@"确定" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:16]];
    [tbtn addTarget:self action:@selector(quedingCLick) forControlEvents:UIControlEventTouchUpInside];
    [V_url addSubview:tbtn];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FBButton  *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"发布视频" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:18]];
    [tbtn addTarget:self action:@selector(fabuCLilck) forControlEvents:UIControlEventTouchUpInside];
    
    return tbtn;
}
///发布视频
-(void)fabuCLilck{
    //@[@"视频连接",@"视频标题",@"视频封面",@"视频分类",@"视频描述"];
    if([arr_contents[3] isEqualToString:@"最多选5种"]){
        arr_contents[3] = @" ";
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在发布";
    [WebRequest  Lectures_Add_LectureVideosWithuserGuid:user.Guid videoUrl:arr_contents[0] lable:arr_contents[3] describe:arr_contents[4] player:player ID:videoId title:arr_contents[1] bigThumbnail:arr_contents[2] videoTime:videoTime And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
       
        
    }];
}
-(void)quedingCLick
{
    //确定
    [WebRequest Lectures_video_ParsingvideoWithvideoUrl:TFvc.text And:^(NSDictionary *dic) {
        [self.view endEditing:YES];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            arr_contents = [NSMutableArray arrayWithArray:@[TFvc.text,tdic[@"title"],tdic[@"thumbnail"],@"最多选5种",tdic[@"description"]]];
            player = tdic[@"player"];
            videoId = tdic[@"id"];
            videoTime = tdic[@"duration"];
            tableV.hidden =NO;
            [tableV bringSubviewToFront:self.view];
            [tableV reloadData];
            V_url.hidden =YES;
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"未知错误,请重试";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];
  
    
    
}
-(void)settableV{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        FBOne_img2TableViewCell  *cell = [[FBOne_img2TableViewCell alloc]init];
        cell.L_left0.text =arr_names[indexPath.row];
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:arr_contents[indexPath.row]]];
        return cell;
    }else
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row==0 || indexPath.row==1)
  {
      FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
      TFvc.delegate =self;
      TFvc.indexPath =indexPath;
      TFvc.content =arr_contents[indexPath.row];
      TFvc.contentTitle =arr_names[indexPath.row];
      [self.navigationController pushViewController:TFvc animated:NO];
  }else if(indexPath.row==2){
      //视频封面
      FBShowimg_moreViewController  *Svc =[[FBShowimg_moreViewController alloc]init];
      Svc.arr_imgs = @[arr_contents[2]];
      Svc.index =0;
      [self.navigationController pushViewController:Svc animated:NO];
  }else if (indexPath.row ==3)
  {
      //视频分类
      FB_PXLeiBieChooseViewController *Pvc =[[FB_PXLeiBieChooseViewController alloc]init];
      Pvc.delegate =self;
      Pvc.arr_chosemodel = arr_leibie;
      [self.navigationController pushViewController:Pvc animated:NO];
  }else if (indexPath.row==4)
  {
      //视频描述
      FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
      TVvc.indexpath =indexPath;
      TVvc.delegate =self;
      TVvc.contentTitle=arr_names[indexPath.row];
      TVvc.content =arr_contents[indexPath.row];
      [self.navigationController pushViewController:TVvc animated:NO];
  }
}
#pragma  mark - 视频分类的协议代理
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel *> *)arr_teachers
{
    arr_leibie = arr_teachers;
    NSMutableString *Tstr = [NSMutableString string];
    
    for (int i=0; i<arr_teachers.count; i++) {
        FBAddressModel *model = arr_teachers[i];
        if (i==arr_teachers.count-1) {
            [Tstr appendString:model.name];
        }else
        {
            [Tstr appendFormat:@"%@,",model.name];
        }
    }
    [arr_contents  replaceObjectAtIndex:3 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark - TFvc的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        [arr_contents replaceObjectAtIndex:1 withObject:content];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma  mark - TVvc 的协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
