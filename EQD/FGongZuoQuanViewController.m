//
//  FGongZuoQuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define height_img  ([UIScreen mainScreen].bounds.size.width-50)/3.0
#import "FGongZuoQuanViewController.h"
#import "FBGongZuo_img_textTableViewCell.h"
#import "FBTextvImgViewController.h"
#import <UIImageView+WebCache.h>
#import "NSString+FBString.h"
#import "FBindexTapGestureRecognizer.h"
#import "PPersonCardViewController.h"
#import "FBImgShowViewController.h"
#import "GZQ_ZanViewController.h"
#import "GZQ_PingLunViewController.h"
#import "GZQ_top_headView.h"
#import "UITextField+Tool.h"
#import "FBButton.h"
#import "LDImagePicker.h"
@interface FGongZuoQuanViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextvImgViewControllerDelegate,UITextFieldDelegate,GZQ_PingLunViewControllerDelegate,LDImagePickerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_gongzuoquan;
    UserModel *user;
    NSString *Str_ID;
    UITextField *TF_text;
    UIView *V_bottom;
    FBButton *B_fasong;
    GZQ_top_headView *top_view;
    NSIndexPath *indexPath_pinglun;
}

@end

@implementation FGongZuoQuanViewController
-(void)imagePickerDidCancel:(LDImagePicker *)imagePicker
{
    
}
#pragma mark - 评论详情做的操作
///删除
-(void)deleteModelWithindexpath:(NSIndexPath*)indexPath
{
    GongZuoQunModel *model =arr_gongzuoquan[indexPath.row];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在删除";
   
    [WebRequest Delete_WorkCircleWithworkCircleId:model.Id userGuid:user.Guid And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            hud.label.text =@"删除成功";
            [arr_gongzuoquan removeObjectAtIndex:indexPath.row];
            [tableV reloadData];
        }
        else
        {
            hud.label.text =@"服务器错误";
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
    
}
///点赞
-(void)zanwithIndexPath:(NSIndexPath*)indexPath
{
    GongZuoQunModel *model =arr_gongzuoquan[indexPath.row];
    FBGongZuo_img_textTableViewCell *cell =[tableV cellForRowAtIndexPath:indexPath];
    [cell updateZan_numWithuserphoto:user.iphoto Andmodel:model];
}
//留言
-(void)liuyanWithIndexpath:(NSIndexPath*)indexPath Withnumber:(NSString*)number
{
    FBGongZuo_img_textTableViewCell *cell =[tableV cellForRowAtIndexPath:indexPath];
    cell.L_liuyan.text =number;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)loadRequestData{
    
   
    [WebRequest Get_WorkCircle_ByCompanyWithcompanyId:user.companyId userGuid:user.Guid ID:@"0" And:^(NSDictionary *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        });
       if([dic[Y_STATUS] integerValue]==200)
       {
        [arr_gongzuoquan removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
//        [USERDEFAULTS setObject:tarr forKey:@"F_gongzuoquanData"];
//        [USERDEFAULTS synchronize];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                GongZuoQunModel *model =[GongZuoQunModel mj_objectWithKeyValues:tarr[i]];
                [arr_gongzuoquan addObject:model];
                if (i==tarr.count-1) {
                    Str_ID =model.Id;
                }
            }
        }
       }
            [tableV reloadData];
        
    }];
}
-(void)loadOtherData
{
   
    [WebRequest Get_WorkCircle_ByCompanyWithcompanyId:user.companyId userGuid:user.Guid ID:Str_ID And:^(NSDictionary *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        });
       NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count==0){
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else {
            for (int i=0; i<tarr.count; i++) {
                GongZuoQunModel *model =[GongZuoQunModel mj_objectWithKeyValues:tarr[i]];
                [arr_gongzuoquan addObject:model];
                if (i==tarr.count-1) {
                    Str_ID =model.Id;
                }
            }
            [tableV reloadData];
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Str_ID=@"0";
     arr_gongzuoquan =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
        self.navigationItem.title =@"工作圈";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [tableV.mj_header beginRefreshing];
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addtuWenClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    V_bottom =[[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 40)];
    [self.view addSubview:V_bottom];
    V_bottom.backgroundColor =[UIColor lightGrayColor];
    V_bottom.userInteractionEnabled=YES;
    TF_text =[[UITextField alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-100, 30)];
    TF_text.borderStyle = UITextBorderStyleRoundedRect;
    [V_bottom addSubview:TF_text];
    TF_text.placeholder=@"我也说一句……";
    B_fasong =[FBButton buttonWithType:UIButtonTypeSystem];
    [V_bottom addSubview:B_fasong];
    B_fasong.enabled=YES;
    B_fasong.frame =CGRectMake(DEVICE_WIDTH-75, 5, 60, 30);
    [B_fasong setTitle:@"发送" titleColor:EQDCOLOR backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
    [B_fasong addTarget:self action:@selector(fasongClick) forControlEvents:UIControlEventTouchUpInside];
    
    TF_text.delegate =self;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [TF_text setTextFieldInputAccessoryView];
    // 键盘将出现事件监听
    [center addObserver:self selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    // 键盘将隐藏事件监听
    [center addObserver:self selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
    
    ///为表添加头部
    top_view =[[GZQ_top_headView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_WIDTH*0.5+40)];
    tableV.tableHeaderView =top_view;
    [top_view setArr_contents:@[user.workImage,user.iphoto,user.username,user.Signature]];
    UITapGestureRecognizer *tap_view_head =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_view_headClick)];
    [top_view.IV_head addGestureRecognizer:tap_view_head];
    
    UITapGestureRecognizer *tap_view_bg =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_view_bgClick)];
    [top_view.IV_bg addGestureRecognizer:tap_view_bg];
    
    UITapGestureRecognizer *tap_two =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taptwoClick:)];
    UIView *tview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    tview.userInteractionEnabled=YES;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:tview];
    [tview addGestureRecognizer:tap_two];
    [self.navigationItem setRightBarButtonItems:@[right,item1]];
    
    
}
-(void)taptwoClick:(UITapGestureRecognizer*)tap
{
    
        [tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma  mark - 背景图 与头像的点击

-(void)tap_view_bgClick
{
    //点击背景图
    LDImagePicker *picker =[LDImagePicker sharedInstance];
    picker.delegate =self;
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction: [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [picker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:0.5];
    }]];
    [alert addAction: [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [picker showImagePickerWithType:ImagePickerCamera InViewController:self Scale:0.5];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage
{
    top_view.IV_bg.image =editedImage;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest  WorkCircles_Update_WorkImageWithuserGuid:user.Guid user:user.uname img:editedImage And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSMutableDictionary *dic2 =[NSMutableDictionary dictionaryWithDictionary:[USERDEFAULTS objectForKey:Y_USERINFO]];
            [dic2 setObject:[NSString stringWithFormat:@"%@%@",HTTP_PATH,dic[Y_ITEMS]] forKey:@"workImage"];
            [USERDEFAULTS setObject:dic2 forKey:Y_USERINFO];
            [USERDEFAULTS synchronize];
        }
    }];
    
    
    
}
-(void)tap_view_headClick
{
    //点击头像
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =user.Guid;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}
//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    CGRect  rect =V_bottom.frame;
    rect.origin.y = DEVICE_HEIGHT-40-height;
    V_bottom.frame =rect;
    
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    V_bottom.frame =CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 40);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    V_bottom.frame =CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 40);
}
-(void)fasongClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在评论";
    GongZuoQunModel *model =arr_gongzuoquan[indexPath_pinglun.row];
  
    
    [WebRequest Add_WorkCircle_CommentWithcompanyId:user.companyId userGuid:user.Guid message:TF_text.text workCircleId:model.Id parentId:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =@"评论成功";
            TF_text.text=nil;
            [self.view endEditing:YES];
            FBGongZuo_img_textTableViewCell *cell =[tableV cellForRowAtIndexPath:indexPath_pinglun];
            [cell updateliuyan];
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
}
-(void)addtuWenClick
{
    FBTextvImgViewController  *TIvc =[[FBTextvImgViewController alloc]init];
    TIvc.delegate =self;
    TIvc.contentTitle =@"工作心情";
    TIvc.indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.navigationController pushViewController:TIvc animated:NO];
    
}
#pragma  mark - 发表工作圈
-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在发布";
    NSString  *address = [USERDEFAULTS objectForKey:Y_AMAP_address];
    if(address.length==0)
    {
        address=@" ";
    }
    
    
    [WebRequest Add_WorkCircleWithcompanyId:user.companyId userGuid:user.Guid message:text name:user.uname location:address imgarr:imgArr And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            hud.label.text=@"发布成功";
            [self loadRequestData];
        }
        else
        {
            hud.label.text = @"发布失败，未知错误";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [tableV reloadData];
        });
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongZuoQunModel *model =arr_gongzuoquan[indexPath.row];
    if (model.contents.length==0 &&model.imgurls.count>0) {
        if (model.imgurls.count==1) {
            CGSize size =[model.imgurls[0] getsizefromURL];
            if(size.width>size.height)
            {
            return 105+(DEVICE_WIDTH-30)*3/4*size.height/size.width+24;
            }
            else
            {
                return 115+(DEVICE_WIDTH-30)*3/4+24;
            }
        }
        else
        {
        return 110+height_img+24;
        }
    }
   else if (model.contents.length!=0 && model.imgurls.count>0) {
          CGSize size =[model.contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 75) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
      
       if (model.imgurls.count==1) {
           CGSize size2 =[model.imgurls[0] getsizefromURL];
           if (size2.width>size2.height) {
               return 110+(DEVICE_WIDTH-30)*3/4*size2.height/size2.width+size.height+24;
           }
           else
           {
               return 120+(DEVICE_WIDTH-30)*3/4.0+24+size.height;
           }
                  }
       else
       {
        return 110+size.height+height_img+24;
       }
    }
    else if(model.contents.length!=0 &&model.imgurls.count==0)
    {
        CGSize size =[model.contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 75) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        return 105+size.height+24;
    }
    else
    {
        return 95+24;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_gongzuoquan.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GongZuoQunModel *model =arr_gongzuoquan[indexPath.row];
    static NSString *cellid=@"cellidimg_text";
    FBGongZuo_img_textTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell =[[FBGongZuo_img_textTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.accessoryType =UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setModel:model];
    FBindexTapGestureRecognizer *tap =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClcikCell:)];
    tap.index=indexPath.row;
    [cell.IV_head addGestureRecognizer:tap];
    
    FBindexTapGestureRecognizer *tap1 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClcikCell:)];
    tap1.index=indexPath.row;
    [cell.L_left0 addGestureRecognizer:tap1];
    
    ///给图片增加点击事件
    FBindexTapGestureRecognizer *tap_img1 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClickCell:)];
    tap_img1.index =indexPath.row;
    tap_img1.selected_obj=0;
    [cell.IV_img1 addGestureRecognizer:tap_img1];
    
    FBindexTapGestureRecognizer *tap_img2 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClickCell:)];
    tap_img2.index =indexPath.row;
    tap_img2.selected_obj=1;
    [cell.IV_img2 addGestureRecognizer:tap_img2];
    
    FBindexTapGestureRecognizer *tap_img3 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClickCell:)];
    tap_img3.index =indexPath.row;
    tap_img3.selected_obj=2;
    [cell.IV_img3 addGestureRecognizer:tap_img3];

    
    ///给点赞的人增加点击事件
    FBindexTapGestureRecognizer  *tap_zan1 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    tap_zan1.index =indexPath.row;
    [cell.IV_zan1 addGestureRecognizer:tap_zan1];
    
    FBindexTapGestureRecognizer  *tap_zan2 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    tap_zan2.index =indexPath.row;
    [cell.IV_zan2 addGestureRecognizer:tap_zan2];
    
    FBindexTapGestureRecognizer  *tap_zan3 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    tap_zan3.index =indexPath.row;
    [cell.IV_zan3 addGestureRecognizer:tap_zan3];
    FBindexTapGestureRecognizer  *tap_zan4 =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(zanCLickcell:)];
    tap_zan4.index =indexPath.row;
    [cell.IV_zan4 addGestureRecognizer:tap_zan4];
    
    ///点赞
    FBindexTapGestureRecognizer *tap_zan =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(dianzanClickCell:)];
    tap_zan.index =indexPath.row;
    [cell.IV_zan addGestureRecognizer:tap_zan];
    
    ///评论
    FBindexTapGestureRecognizer *tap_pinglun =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(pingLunClickCell:)];
    tap_pinglun.index =indexPath.row;
    [cell.IV_liuyan addGestureRecognizer:tap_pinglun];
    ///收藏 分享按钮
    FBindexTapGestureRecognizer  *tap_share = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_ShareClick:)];
    tap_share.indexPath =indexPath;
    [cell.IV_right0 addGestureRecognizer:tap_share];
    return cell;
}
-(void)tap_ShareClick:(FBindexTapGestureRecognizer*)tap
{
    //收藏
     GongZuoQunModel *model =arr_gongzuoquan[tap.indexPath.row];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"收藏"];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(i==0)
            {
                NSString *source = @"工作圈";
                //收藏
                if (model.Message.length==0 && model.GZQ_newImages.count!=0) {
                    //图片
                    NSMutableString *tstr =[NSMutableString string];
                    for (int i=0; i<model.GZQ_newImages.count; i++) {
                        [tstr appendString:[NSString stringWithFormat:@"%@;",model.GZQ_newImages[i]]];
                    }
                    
                    [WebRequest Collection_Add_collectionWithowner:user.Guid url:tstr source:source sourceOwner:model.Creater And:^(NSDictionary *dic) {
                        if ([dic[Y_STATUS] integerValue]==200) {
                            MBFadeAlertView  *alertV =[[MBFadeAlertView alloc]init];
                            [alertV showAlertWith:@"收藏成功"];
                        }
                    }];
                    
                }else if (model.Message.length!=0 && model.GZQ_newImages.count==0)
                {//文字
                    [WebRequest Collection_Add_collectionWithowner:user.Guid title:source ccontent:model.Message tel:user.uname sourceOwner:model.Creater source:source And:^(NSDictionary *dic) {
                        if ([dic[Y_STATUS] integerValue]==200) {
                            MBFadeAlertView  *alertV =[[MBFadeAlertView alloc]init];
                            [alertV showAlertWith:@"收藏成功"];
                        }
                    }];
                    
                }else if (model.Message.length!=0 && model.GZQ_newImages.count!=0)
                {
                    //图文
                    NSMutableString *tstr =[NSMutableString string];
                    for (int i=0; i<model.GZQ_newImages.count; i++) {
                       [tstr appendString:[NSString stringWithFormat:@"%@;",model.GZQ_newImages[i]]];
                    }
                    
                    [WebRequest  Collection_Add_collectionWithowner:user.Guid title:source url:tstr source:source sourceOwner:model.Creater ccontent:model.Message And:^(NSDictionary *dic) {
                        if ([dic[Y_STATUS] integerValue]==200) {
                            MBFadeAlertView  *alertV =[[MBFadeAlertView alloc]init];
                            [alertV showAlertWith:@"收藏成功"];
                        }
                    }];
                    
                    
                }else
                {
                    
                }
            }
        }]];
        
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
}
-(void)pingLunClickCell:(FBindexTapGestureRecognizer*)tap
{
    //评论
    indexPath_pinglun = [NSIndexPath indexPathForRow:tap.index inSection:0];
    [TF_text becomeFirstResponder];
}

-(void)dianzanClickCell:(FBindexTapGestureRecognizer*)tap
{
    //点赞
    GongZuoQunModel *model =arr_gongzuoquan[tap.index];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    
  
    [WebRequest Add_WorkCircle_ZanWithcompanyId:user.companyId userGuid:user.Guid workCircleId:model.Id And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            hud.label.text =@"点赞成功";
            ///获取内容的详情 用请求

            FBGongZuo_img_textTableViewCell *cell =[tableV  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tap.index inSection:0]];
            [cell updateZan_numWithuserphoto:user.iphoto Andmodel:model];
            
        }
        else
        {
            hud.label.text=@"服务器错误";
        }
       
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
}
-(void)zanCLickcell:(FBindexTapGestureRecognizer*)tap
{
    ///进去点赞人的列表
    GongZuoQunModel *model =arr_gongzuoquan[tap.index];
    GZQ_ZanViewController *Zvc =[[GZQ_ZanViewController alloc]init];
   
    Zvc.cell_id =model.Id;
    [self.navigationController pushViewController:Zvc animated:NO];
    
}
-(void)imgClickCell:(FBindexTapGestureRecognizer*)tap
{
    //点击图片的效果
    GongZuoQunModel *model =arr_gongzuoquan[tap.index];
    FBImgShowViewController *ISvc =[[FBImgShowViewController alloc]init];
    ISvc.imgstrs =model.imgurls;
    ISvc.selected =tap.selected_obj;
    [self.navigationController pushViewController:ISvc animated:NO];
    
}

-(void)tapClcikCell:(FBindexTapGestureRecognizer*)tap
{
    //点击头像
    GongZuoQunModel *model =arr_gongzuoquan[tap.index];
    PPersonCardViewController *PCvc =[[PPersonCardViewController alloc]init];
    PCvc.userGuid =model.Creater;
    [self.navigationController pushViewController:PCvc animated:NO];
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongZuoQunModel *model =arr_gongzuoquan[indexPath.row];
    GZQ_PingLunViewController  *Dvc =[[GZQ_PingLunViewController alloc]init];
    
    Dvc.delegate=self;
    Dvc.model =model;
    Dvc.indexPath =indexPath;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
