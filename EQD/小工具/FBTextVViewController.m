//
//  FBTextVViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextVViewController.h"
@interface FBTextVViewController ()<UITextViewDelegate>
{
    UITextView *textV;
    UILabel *L_num;
}

@end

@implementation FBTextVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    textV =[[UITextView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 300)];
    textV.font =[UIFont systemFontOfSize:17];
    textV.delegate =self;
    textV.layer.borderColor = [UIColor grayColor].CGColor;
    textV.layer.borderWidth =0.5;
    [textV becomeFirstResponder];
    if (self.content.length==0) {
        textV.text=@"请输入";
    }
    else
    {
        textV.text =self.content;
    }
    
    
    [self.view addSubview:textV];
    
    if (self.S_maxnum.length==0) {
        
    }
    else
    {
        L_num =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-110, DEVICE_TABBAR_Height+305, 100, 20)];
        [self.view addSubview:L_num];
        L_num.textColor = [UIColor redColor];
        L_num.font=[UIFont systemFontOfSize:15];
        L_num.textAlignment =NSTextAlignmentRight;
        L_num.text =[NSString stringWithFormat:@"%ld/%@",self.content.length,self.S_maxnum];
        
    }
    
    self.navigationItem.title=self.contentTitle;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(textVtext:indexPath:)]) {

        [self.delegate textVtext:textV.text indexPath:self.indexpath];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.S_maxnum.length==0) {
        
    }
    else
    {
        if (textView.text.length>[self.S_maxnum integerValue]) {
            [self.view endEditing:YES];
        }
        L_num.text =[NSString stringWithFormat:@"%ld/%@",textView.text.length,self.S_maxnum];
        
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入"])
    {
        
        textView.text=nil;
    }
}




@end
