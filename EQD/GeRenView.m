//
//  GeRenView.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define YQDCOLOR   [UIColor colorWithRed:0 green:157/255.0 blue:237/255.0 alpha:1]
#import "GeRenView.h"

@implementation GeRenView
-(instancetype)init{
    if (self =[super init]) {
        //高90
        UIView *tview1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 90)];
        
        [self addSubview:tview1];
        tview1.layer.backgroundColor =YQDCOLOR.CGColor;
        //
        tview1.userInteractionEnabled=YES;
        
        self.B_headimg =[UIButton buttonWithType:UIButtonTypeSystem];
        self.B_headimg.frame = CGRectMake((DEVICE_WIDTH-50)/2.0, 10, 50, 50);
        [tview1 addSubview:self.B_headimg];
        self.B_headimg.layer.masksToBounds=YES;
        self.B_headimg.layer.cornerRadius=25;
        [self.B_headimg setBackgroundImage:[UIImage imageNamed:@"no_login_head"] forState:UIControlStateNormal];
        self.L_content =[[UILabel alloc]initWithFrame:CGRectMake(15, 65, DEVICE_WIDTH-30, 20)];
        [tview1 addSubview:self.L_content];
        self.L_content.font =[UIFont systemFontOfSize:12];
        self.L_content.textAlignment=NSTextAlignmentCenter;
        self.L_content.textColor=[UIColor greenColor];
        /*
        NSMutableParagraphStyle *para =[[NSMutableParagraphStyle alloc]init];
        para.lineSpacing = 6;
        NSAttributedString *attrstr =[[NSAttributedString alloc]initWithString:@"*在职人员信息交由人事部修改或增加，未在职人员信息不可修改\n*以下信息比较隐私，只可个人查看，不可修改、转载。" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:para}];
        
        CGSize size =[attrstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        UIView *tview2 =[[UIView alloc]initWithFrame:CGRectMake(0, 90, DEVICE_WIDTH, size.height+10)];
        [self addSubview:tview2];
        tview2.layer.backgroundColor =[UIColor whiteColor].CGColor;
        
        UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 5, DEVICE_WIDTH, size.height)];
        tlabel.attributedText =attrstr;
        tlabel.numberOfLines=0;
        self.L_shuoming =tlabel;
        [tview2 addSubview:tlabel];
        */
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
