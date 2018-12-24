//
//  BPC_qiandaoView.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/14.
//  Copyright © 2018 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "BPC_qiandaoView.h"
#import <Masonry.h>
@implementation BPC_qiandaoView
-(FBButton*)btn_qiandao
{
    if (!_btn_qiandao) {
        _btn_qiandao = [FBButton buttonWithType:UIButtonTypeSystem];
        [_btn_qiandao setTitle:@"签到" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:36/255.0 green:46/255.0 blue:179/255.0 alpha:1] font:[UIFont systemFontOfSize:17]];
        _btn_qiandao.layer.masksToBounds = YES;
        _btn_qiandao.layer.cornerRadius = 20;
        [self addSubview:_btn_qiandao];
        [_btn_qiandao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 40));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        
        
        
    }
    return _btn_qiandao;
}
-(void)setSenvenViewWitharrScole:(NSArray*)arr_scole
{
    float width = (DEVICE_WIDTH-20 -20 - 30)/7.0;
    NSMutableArray *tviews = [NSMutableArray arrayWithCapacity:0];
    for(int i=0 ;i<arr_scole.count;i++)
    {
        NSDictionary *tdic = arr_scole[i];
        BPqiandaoShow  *tShow = [[BPqiandaoShow alloc]init];
        [self addSubview:tShow];
        [tShow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
            make.left.mas_equalTo(self.mas_left).mas_offset(10+(width+5)*i);
            make.top.mas_equalTo(self.mas_top).mas_offset(10);
            make.width.mas_equalTo(width);
        }];
       NSArray *tarr = @[@"第一天",@"第二天",@"第三天",@"第四天",@"第五天",@"第六天",@"第七天"];
        
        NSString *tday = tarr[[tdic[@"day"] integerValue]-1];
        NSString *TBP = tdic[@"BP"];
        
        [tShow setTop:tday bottomName:[NSString stringWithFormat:@"+%@",TBP] isQiandao:NO];
        [tviews addObject:tShow];
    }
    
    self.arr_views = tviews;
}

-(void)updateViewWithindex:(NSInteger)index
{
    for (int i=0; i<index; i++) {
        BPqiandaoShow  *tshow = self.arr_views[i];
        tshow.IV_center.image = [UIImage imageNamed:@"C_jifenTrue"];
        tshow.L_bottom.textColor = [UIColor redColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
