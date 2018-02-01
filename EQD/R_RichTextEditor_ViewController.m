//
//  R_RichTextEditor_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "R_RichTextEditor_ViewController.h"
#import "ZSSBarButtonItem.h"
#import "FBTextField.h"
#import "FBButton.h"
#import "WebRequest.h"
#import "EQDR_wenjiListModel.h"
#import "EQDR_MyWenJiViewController.h"
#import "EQDR_LeiBieArticle2ViewController.h"
@interface R_RichTextEditor_ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,EQDR_MyWenJiViewControllerDelegate,EQDR_LeiBieArticle2ViewControllerDelegate>
{
    FBTextField  *TF_title;
    FBButton  *B_title;
    UIImagePickerController  *picker;
    UserModel *user;
    NSString *menuId;
    ///第一张图片的地址
    NSString *img_url;
    NSArray *arr_articleLeibie;
}

@end

@implementation R_RichTextEditor_ViewController
-(void)findWenji
{
    [WebRequest  Articles_Get_ArticleMenuWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [WebRequest  Articles_Add_ArticleMenuWIthuserGuid:user.Guid menuName:@"默认文集" And:^(NSDictionary *dic) {
                     [self findWenji];
                }];
            }else
            {
                EQDR_wenjiListModel  *model =[EQDR_wenjiListModel mj_objectWithKeyValues:tarr[0]];
                menuId = model.Id;
                dispatch_async(dispatch_get_main_queue(), ^{
                   [B_title setTitle:model.articleName forState:UIControlStateNormal];
                    
                });
               
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    self.shouldShowKeyboard =YES;
    self.alwaysShowToolbar=YES;
    
    self.toolbarItemTintColor = [UIColor darkGrayColor];
    self.toolbarItemSelectedTintColor = [UIColor grayColor];
    TF_title = [[FBTextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height+5, self.view.frame.size.width-30-130, 40)];
    TF_title.placeholder =@"标题";
    [self.view addSubview:TF_title];
 
    self.placeholder =@"文章将会发布到易企阅";
    TF_title.font = [UIFont systemFontOfSize:24];
    TF_title.layer.borderColor = [UIColor grayColor].CGColor;
    TF_title.layer.borderWidth =1;
    
    FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn addTarget:self action:@selector(tbtnClick) forControlEvents:UIControlEventTouchUpInside];
    tbtn.frame =CGRectMake(CGRectGetMaxX(TF_title.frame)+5, DEVICE_TABBAR_Height+5, 120, 40);

    [tbtn setTitle:@"文章分类" titleColor:  [UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:15]];
    
    [self.view addSubview:tbtn];
    
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(fabuCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    B_title =[FBButton buttonWithType:UIButtonTypeSystem];
    [B_title addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
       [B_title setTitle:@"默认文集" forState:UIControlStateNormal];
    self.navigationItem.titleView= B_title ;
    
    
    NSDictionary *tdic =[USERDEFAULTS objectForKey:@"R_RichTextEditor_ViewController"];
    TF_title.text = tdic[@"title"];
    NSString *hanye = tdic[@"leibie"];
    NSArray *tarr  =[hanye componentsSeparatedByString:@","];
    NSMutableArray *tarr2 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<tarr.count; i++) {
        OptionModel  *model = [[OptionModel alloc]init];
        model.name = tarr[i];
        [tarr2 addObject:model];
    }
    arr_articleLeibie = tarr2;
    img_url = tdic[@"img"];
    NSString *thtml = tdic[@"content"];
    NSString *thtmlStr = [thtml stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    [self setHTML:thtmlStr];
    
    if (self.model) {
        menuId =self.model.menuId;
        B_title.userInteractionEnabled = NO;
        [B_title setTitle:self.model.title forState:UIControlStateNormal];
        [self setHTML:self.model.content];
        NSArray *tarr  =[_model.lable componentsSeparatedByString:@","];
        NSMutableArray *tarr2 = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<tarr.count; i++) {
            OptionModel  *model = [[OptionModel alloc]init];
            model.name = tarr[i];
            [tarr2 addObject:model];
        }
        arr_articleLeibie = tarr2;
        right.title = @"更新";
        TF_title.text =self.model.title;
    }else if(self.menuid)
    {
        menuId = self.menuid;
        B_title.userInteractionEnabled=YES;
        [B_title setTitle:self.articleName forState:UIControlStateNormal];
        
    }else
    {
        B_title.userInteractionEnabled = YES;
    [self findWenji];
    }
    ZSSBarButtonItem  *item = [[ZSSBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"EQDR_line"] style:UIBarButtonItemStylePlain target:self action:@selector(fengeClick)];
    [self addCustomToolbarItem:item];

    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarInsertImage,ZSSRichTextEditorToolbarRemoveFormat,ZSSRichTextEditorToolbarBold,ZSSRichTextEditorToolbarItalic,ZSSRichTextEditorToolbarUnderline,ZSSRichTextEditorToolbarInsertLink,ZSSRichTextEditorToolbarTextColor,ZSSRichTextEditorToolbarH1,ZSSRichTextEditorToolbarH2,ZSSRichTextEditorToolbarH3,ZSSRichTextEditorToolbarH4];
    
    picker = [[UIImagePickerController alloc]init];
    picker.delegate =self;
    picker.allowsEditing =YES;
    img_url =@" ";
    
    
  self.receiveEditorDidChangeEvents =YES;
    
}
-(void)tbtnClick
{
    EQDR_LeiBieArticle2ViewController  *LBvc =[[EQDR_LeiBieArticle2ViewController alloc]init];
    LBvc.delegate =self;
    LBvc.arr_chooses = arr_articleLeibie;
    LBvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:LBvc animated:NO];
  
   
}
-(void)titleClick
{
    EQDR_MyWenJiViewController *WJvc =[[EQDR_MyWenJiViewController alloc]init];
    WJvc.delegate =self;
    [self.navigationController pushViewController:WJvc animated:NO];
    
}
-(void)fengeClick
{
    NSLog(@"分割线");
    [self insertHTML:@"<p style='border-top :1px solid #d9d9d9; padding: 15px 10px 0px 10px '></p>"];
}
-(void)fabuCLick
{
    
    if (self.model) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在更新";
        NSString *content = [self getText];
        if (content.length>60) {
            content = [content substringWithRange:NSMakeRange(0, 60)];
        }
        [WebRequest  Articles_Update_ArticleWithuserGuid:user.Guid articleId:self.model.Id articleTitle:TF_title.text articleContent:[self  getHTML] textContent:content  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
           
        }];
        
        
        
    }else
    {
    NSInteger temp =0;
    if (TF_title.text.length==0) {
        TF_title.text =@" ";
    }else
    {
        if (TF_title.text.length>30) {
            temp =1;
        }
    }
    NSString *content = [self getText];
    if (content.length>60) {
        content = [content substringWithRange:NSMakeRange(0, 60)];
    }
    NSMutableString  *label = [NSMutableString string];
    if (arr_articleLeibie.count==0) {
        [label appendString:@" "];
    }else
    {
        for (int i=0; i<arr_articleLeibie.count; i++) {
            OptionModel  *model =arr_articleLeibie[i];
            if (i==arr_articleLeibie.count-1) {
                [label appendString:model.name];
            }else
            {
                [label appendFormat:@"%@,",model.name];
            }
        }
    }
    
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发布";
        [WebRequest Articles_Add_ArticleWithmenuId:menuId userGuid:user.Guid title:TF_title.text content:[self getHTML] homeImage:img_url label:label source:self.source companyId:user.companyId textContent:content And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                    [USERDEFAULTS removeObjectForKey:@"R_RichTextEditor_ViewController"];
                    [USERDEFAULTS synchronize];
                }
            });
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"标题最长30个字";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
  
    }
}

- (void)showInsertImageDialogWithLink:(NSString *)url alt:(NSString *)alt
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:NO completion:nil];
        }else
        {
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType =UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:NO completion:nil];
        }else
        {
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage  *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:^{
        [WebRequest Articles_CommitImageWithimg:image And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                    NSString *tstr = dic[Y_ITEMS];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(img_url.length >1)
                    {}else
                    {
                        img_url =[tstr  stringByReplacingOccurrencesOfString:HTTP_PATH withString:@""];
                    }
                      [self insertImage:tstr alt:@"易企点图片"];
                });
            }
        }];
    }];
   
    
    
}

#pragma  mark - 自定义的协议代理

-(void)getWenjiModel:(EQDR_wenjiListModel *)wenjiModel
{
    menuId =wenjiModel.Id;
    [B_title setTitle:wenjiModel.articleName forState:UIControlStateNormal];
}

-(void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html
{
    //本地缓存
    if (TF_title.text.length==0) {
        TF_title.text =@" ";
    }
    if (img_url.length==0) {
        img_url=@" ";
    }
   
    NSMutableDictionary *tdic =[NSMutableDictionary dictionaryWithDictionary:@{
                          @"content":html,
                          @"title":TF_title.text,
                          @"img":img_url
                          }];
    if (arr_articleLeibie.count!=0) {
       //少逻辑
        NSMutableString  *tstr = [NSMutableString string];
        for (int i=0; i<arr_articleLeibie.count; i++) {
            OptionModel *model = arr_articleLeibie[i];
            if (i==arr_articleLeibie.count-1) {
                [tstr appendString:model.name];
            }else
            {
                [tstr appendFormat:@"%@,",model.name];
            }
        }
        [tdic setObject:tstr forKey:@"leibie"];
        
    }else
    {
        
    }
    [USERDEFAULTS setObject:tdic forKey:@"R_RichTextEditor_ViewController"];
    [USERDEFAULTS synchronize];
    
}
#pragma  mark - 文章分类的协议代理
-(void)getArticleWithModel:(NSArray<OptionModel *> *)mode
{
    arr_articleLeibie = mode;
}


@end
