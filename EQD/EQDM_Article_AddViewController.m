//
//  EQDM_Article_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_Article_AddViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "FBEQDEditer_AllViewController.h"
#import "FBTextVViewController.h"
#import "ChuangKeLabelChooseViewController.h"
#import "EQDR_MyWenJiViewController.h"
@interface EQDM_Article_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBEQDEditer_AllViewControllerDlegate,FBTextVViewControllerDelegate,ChuangKeLabelChooseViewControllerDelegate,EQDR_MyWenJiViewControllerDelegate>
{
    UITableView  *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_height;
    
    NSString *editor_title;
    NSString *editor_html;
    NSString *editor_text;
    NSString *editor_imgurl;
    
    NSArray *arr_chaugnke;
    EQDR_wenjiListModel *model_wenji;
    UserModel *user;
}

@end

@implementation EQDM_Article_AddViewController
#pragma  mark - 自定义的富文本编辑框的协议代理
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl
{
    editor_html = html;
    editor_text = text;
    editor_title =title;
    editor_imgurl = imgurl;
    [arr_contents replaceObjectAtIndex:0 withObject: [NSString stringWithFormat:@"%@\n%@",title,text]];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - textV的协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 创客类别
-(void)getChuangkeLabel:(NSArray *)arr_str
{
    arr_chaugnke = arr_str;
    NSMutableString *tstring = [NSMutableString string];
    for (int i=0; i<arr_str.count; i++) {
        [tstring appendFormat:@"%@ ",arr_str[i]];
    }
    
    [arr_contents replaceObjectAtIndex:2 withObject:tstring];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 文件夹的协议代理
-(void)getWenjiModel:(EQDR_wenjiListModel*)wenjiModel
{
    model_wenji = wenjiModel;
    [arr_contents replaceObjectAtIndex:3 withObject:wenjiModel.categoryName];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    editor_imgurl=@"";
    self.navigationItem.title = @"写创文";
    user = [WebRequest GetUserInfo];
    arr_names =  [NSMutableArray arrayWithArray:@[@"写创文",@"创文亮点",@"创文类别",@"创文所在文件夹"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请选择",@"默认文件夹"]];
    arr_height = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60",@"60"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(fabuCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    model_wenji = [[EQDR_wenjiListModel alloc]init];
    model_wenji.categoryName = @"默认文件夹";
    model_wenji.Id = @"0";
    
}
-(void)fabuCLick
{
    NSInteger temp =0;
    if(!model_wenji || [arr_contents[1] isEqualToString:@"请输入"] || [arr_contents[1] isEqualToString:@"请选择"] || arr_chaugnke.count==0)
    {
        temp =1;
    }
    NSMutableString  *tstr = [NSMutableString string];
    for (int i=0; i<arr_chaugnke.count; i++) {
        if (i==arr_chaugnke.count-1) {
            [tstr appendString:arr_chaugnke[i]];
        }else
        {
        [tstr appendFormat:@"%@;",arr_chaugnke[i]];
        }
    }
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在发布";
    if (temp==0) {
    [WebRequest Makerspace_Add_MakerArticleWithuserGuid:user.Guid title:editor_title matchedTrade:tstr splendidContent:arr_contents[1] ArticleContent:editor_html categoryId:model_wenji.Id categoryName:model_wenji.categoryName picUrl:editor_imgurl source:@"0" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
        
    }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数填写不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.row] integerValue];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: \n",arr_names[indexPath.row]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:arr_contents[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [name appendAttributedString:content];
    
    
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-45, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    if (size.height >60) {
        [arr_height replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.1f",size.height+10]];
    }else
    {
        
    }
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-30);
    }];
    cell.YL_label.attributedText =name;
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row==0)
   {
       //写创文
       FBEQDEditer_AllViewController *Evc =[[FBEQDEditer_AllViewController alloc]init];
       Evc.delegate =self;
       Evc.temp =1;
       [self.navigationController pushViewController:Evc animated:NO];
       
   }else if (indexPath.row==1)
   {
       //创文亮点
       FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
       TVvc.indexpath =indexPath;
       TVvc.delegate =self;
       TVvc.contentTitle=arr_names[indexPath.row];
       TVvc.content =arr_contents[indexPath.row];
       [self.navigationController pushViewController:TVvc animated:NO];
   }else if (indexPath.row==2)
   {
       //创文类别
       ChuangKeLabelChooseViewController  *Cvc =[[ChuangKeLabelChooseViewController alloc]init];
       Cvc.delegate =self;
       [self.navigationController pushViewController:Cvc animated:NO];
       
   }
//       else if (indexPath.row==3)
//   {
//       //创文所属行业
//       FBHangYeViewController *Hvc =[[FBHangYeViewController alloc]init];
//       Hvc.delegate =self;
//       Hvc.indexPath = indexPath;
//       [self.navigationController pushViewController:Hvc animated:NO];
//
//   }
       else if (indexPath.row==3)
   {
       //创文所在的文件夹
       EQDR_MyWenJiViewController *Mvc =[[EQDR_MyWenJiViewController alloc]init];
       Mvc.delegate =self;
       Mvc.isOther = 1;
       [self.navigationController pushViewController:Mvc animated:NO];
       
   }else
   {
       
   }
}




@end
