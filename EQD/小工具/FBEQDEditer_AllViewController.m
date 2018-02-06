//
//  FBEQDEditer_AllViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBEQDEditer_AllViewController.h"
#import "ZSSBarButtonItem.h"
#import "WebRequest.h"
#import "FBTextField.h"
@interface FBEQDEditer_AllViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSString *img_url;
    UIImagePickerController *picker;
    FBTextField *TF_title;
    NSString *key;
}

@end

@implementation FBEQDEditer_AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    TF_title = [[FBTextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height+5, DEVICE_WIDTH-30, 40)];
    TF_title.font = [UIFont systemFontOfSize:24];
    TF_title.layer.borderColor=[UIColor grayColor].CGColor;
    TF_title.layer.borderWidth=0.5;
    [self.view addSubview:TF_title];
    self.view.backgroundColor = [UIColor whiteColor];
    self.shouldShowKeyboard =YES;
    self.alwaysShowToolbar=YES;
    
    self.toolbarItemTintColor = [UIColor darkGrayColor];
    self.toolbarItemSelectedTintColor = [UIColor grayColor];
    ZSSBarButtonItem  *item = [[ZSSBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"EQDR_line"] style:UIBarButtonItemStylePlain target:self action:@selector(fengeClick)];
    [self addCustomToolbarItem:item];
    
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarInsertImage,ZSSRichTextEditorToolbarRemoveFormat,ZSSRichTextEditorToolbarBold,ZSSRichTextEditorToolbarItalic,ZSSRichTextEditorToolbarUnderline,ZSSRichTextEditorToolbarInsertLink,ZSSRichTextEditorToolbarTextColor,ZSSRichTextEditorToolbarH1,ZSSRichTextEditorToolbarH2,ZSSRichTextEditorToolbarH3,ZSSRichTextEditorToolbarH4];
    self.receiveEditorDidChangeEvents =YES;
    picker = [[UIImagePickerController alloc]init];
    picker.delegate =self;
    picker.allowsEditing =YES;
    img_url =@" ";
    if(self.temp==1)
    {
        //易企创
        self.navigationItem.title = @"易企创文章";
        TF_title.placeholder = @"创文标题";
        self.placeholder = @"创文会发布在易企创";
        key = @"EQDM_article";
    }else if (self.temp==10)
    {
        //课程大纲
        self.navigationItem.title = @"填写内容即可";
        TF_title.hidden =YES;
        self.placeholder = @"请填写课程大纲";
        key = @"HR_CourceManage";
    }
    
    if (self.editor_htmlText) {
        TF_title.text =self.editor_title;
//        NSString  *tstr = [[NSString alloc]initWithData:self.editor_data encoding:NSUTF8StringEncoding];
//        [self setHTML:tstr];
        [self setHTML:self.editor_htmlText];
    }else
    {
        if(key)
        {
        NSDictionary *dic = [USERDEFAULTS objectForKey:key];
        TF_title.text = dic[@"title"];
        NSString *thtml =dic[@"html"];
        NSString *thtmlStr = [thtml stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        [self setHTML:thtmlStr];
        }
    }
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSString *thtml = [self getHTML];
    NSString *thmlStr = [thtml stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                               @"html":thmlStr
                                                                               }];
    if (TF_title.text.length >0) {
        [dic setObject:TF_title.text forKey:@"title"];
    }else
    {
        
    }
    [USERDEFAULTS setObject:dic forKey:key];
    [USERDEFAULTS synchronize];
}

-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(getEditerTitle:html:text:imgurl:stringData:)]) {
        NSString *tstr =[self getText];
        if (tstr.length >60) {
            tstr = [tstr substringWithRange:NSMakeRange(0, 60)];
        }
        NSData *data = [[self getHTML] dataUsingEncoding:NSUTF8StringEncoding];
        [self.delegate getEditerTitle:TF_title.text html:[self getHTML] text:tstr imgurl:img_url stringData:data];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)fengeClick
{
    NSLog(@"分割线");
    [self insertHTML:@"<p style='border-top :1px solid #d9d9d9; padding: 15px 10px 0px 10px '></p>"];
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
                    if (img_url.length>1) {
                        
                    }else
                    {
                        img_url =[tstr  stringByReplacingOccurrencesOfString:HTTP_PATH withString:@""];
                    }
                    [self insertImage:tstr alt:@"易企点图片"];
                });
            }
        }];
    }];
    
    
    
}

-(void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html
{
 
    
}

@end
