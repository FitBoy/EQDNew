//
//  InviteModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "InviteModel.h"
#import <MJExtension.h>
@implementation InviteModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}
-(void)setCompany:(NSString *)company
{
    _company=company;
    self.left0=[NSString stringWithFormat:@"企业名称：%@",_company];
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"部门/职位：%@/%@",self.udepartment,self.upost];
}
@end
