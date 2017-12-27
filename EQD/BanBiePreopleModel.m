//
//  BanBiePreopleModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BanBiePreopleModel.h"

@implementation BanBiePreopleModel
-(NSString*)left0
{
    return self.usrename;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"%@-%@",self.department,self.post];
}
-(NSString*)img_header
{
    return self.headimage;
}
@end
