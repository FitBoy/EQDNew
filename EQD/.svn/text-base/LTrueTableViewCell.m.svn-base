//
//  LTrueTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "LTrueTableViewCell.h"

@implementation LTrueTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.L_tishi = [[UILabel alloc]initWithFrame:CGRectMake(15, 4, DEVICE_WIDTH-30, 40)];
        [self addSubview:self.L_tishi];
        self.L_tishi.font = [UIFont systemFontOfSize:15];
        self.L_tishi.text = @"拍身份证正面照片的时候，注意反光，保证身份证内容清晰可见";
        self.L_tishi.textColor = [UIColor redColor];
        self.L_tishi.numberOfLines=2;
        float width = (DEVICE_WIDTH-60)/2.0;
        self.B_shenfen = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_shenfen];
        self.B_shenfen.frame = CGRectMake(15, 45, width, width);
        self.B_shenfen.backgroundColor = [UIColor greenColor];
        self.L_shengfen = [[UILabel alloc]initWithFrame:CGRectMake(15, 50+width, width, 20)];
    
        [self addSubview:self.L_shengfen];
        self.L_shengfen.text = @"身份证人像面";
        self.L_shengfen.textColor = [UIColor grayColor];
        self.L_shengfen.textAlignment = NSTextAlignmentCenter;
        
        self.B_camara = [FBButton buttonWithType:UIButtonTypeSystem];
       
        [self.B_camara setTitle:@"拍照片" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:157/255.0 blue:237/255.0 alpha:1] font: [UIFont systemFontOfSize:24]];
        self.B_camara2 = [FBButton buttonWithType:UIButtonTypeSystem];
        [self.B_camara2 setTitle:@"拍照片" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:157/255.0 blue:237/255.0 alpha:1] font: [UIFont systemFontOfSize:24]];
        [self addSubview:self.B_camara2];
        [self addSubview:self.B_camara];
        self.B_camara.frame = CGRectMake(15, 75+width, width, 30);
        self.B_camara2.frame = CGRectMake(width+45, 75+width, width, 30);
        
        
        self.L_zhengjian = [[UILabel alloc]initWithFrame:CGRectMake(width+45, 50+width, width, 25)];
        [self addSubview:self.L_zhengjian];
        self.L_zhengjian.text = @"个人的证件照";
        self.L_zhengjian.textColor = [UIColor grayColor];
        self.L_zhengjian.textAlignment = NSTextAlignmentCenter;
        self.B_zhengjian = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_zhengjian];
        self.B_zhengjian.frame = CGRectMake(width+45, 45, width, width);
        self.B_zhengjian.backgroundColor = [UIColor greenColor];
        UILabel *tlabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, width*0.7, width, 20)];
        tlabel.text = @"仅用于易企点认证";
        tlabel.textAlignment = NSTextAlignmentCenter;
        tlabel.textColor = [UIColor whiteColor];
        tlabel.transform = CGAffineTransformMakeRotation(-M_PI/7.0);
        tlabel.font = [UIFont systemFontOfSize:15];
        tlabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        UILabel *tlabel1  = [[UILabel alloc]initWithFrame:CGRectMake(0, width*0.7, width, 20)];
        tlabel1.text = @"仅用于易企点认证";
        tlabel1.textAlignment = NSTextAlignmentCenter;
        tlabel1.textColor = [UIColor whiteColor];
        tlabel1.transform = CGAffineTransformMakeRotation(-M_PI/7.0);
        tlabel1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        tlabel1.font = [UIFont systemFontOfSize:15];
        [self.B_shenfen addSubview:tlabel1];
        [self.B_zhengjian addSubview:tlabel];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
