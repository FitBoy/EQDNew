//
//  FB_OnlyForLiuYanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FB_OnlyForLiuYanViewController.h"
#import "UITextView+Tool.h"
@interface FB_OnlyForLiuYanViewController ()
{
    UITextView  *TV_text;
    UIView *V_bottom;
}

@end

@implementation FB_OnlyForLiuYanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    V_bottom = [[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-160, DEVICE_WIDTH, 160)];
    V_bottom.userInteractionEnabled =YES;
    [self.view addSubview:V_bottom];
    V_bottom.backgroundColor = [UIColor whiteColor];
    
    TV_text = [[UITextView alloc]initWithFrame:CGRectMake(15, 10, DEVICE_WIDTH-30, 100)];
    [V_bottom addSubview:TV_text];
    TV_text.font = [UIFont systemFontOfSize:18];
    TV_text.layer.borderWidth=1;
    TV_text.layer.borderColor=[UIColor grayColor].CGColor;
    TV_text.layer.masksToBounds = YES;
    TV_text.layer.cornerRadius =3;
    self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    [TV_text becomeFirstResponder];

    TV_text.font = [UIFont systemFontOfSize:17.f];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = self.placeHolder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [TV_text addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:17.f];
    [TV_text setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
   
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [TV_text setTextFieldInputAccessoryView];
    // 键盘将出现事件监听
    [center addObserver:self selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    // 键盘将隐藏事件监听
    [center addObserver:self selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
    
//    TV_text.returnKeyType = UIReturnKeyDefault;
    
    UIButton  *btnSend =[UIButton buttonWithType:UIButtonTypeSystem];
    [V_bottom addSubview:btnSend];
    btnSend.frame =CGRectMake(DEVICE_WIDTH-100, 120, 80, 30);
    [btnSend setTitle:self.btnName forState:UIControlStateNormal];
    [btnSend setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    btnSend.layer.borderColor = [UIColor greenColor].CGColor;
    btnSend.layer.borderWidth=1;
    [btnSend addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    

}
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:self.placeHolder]) {
//        textView.text =nil;
//        textView.textColor = [UIColor blackColor];
//    }
//}

-(void)sendClick
{
    //点击按钮
    if ([self.delegate respondsToSelector:@selector(getPresnetText:)]) {
        [self.delegate getPresnetText:TV_text.text];
          [self dismissViewControllerAnimated:NO completion:nil];
    }
  
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
    rect.origin.y = DEVICE_HEIGHT-160-height;
    V_bottom.frame =rect;
    
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    V_bottom.frame =CGRectMake(0, DEVICE_HEIGHT-160, DEVICE_WIDTH, 160);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}



@end
