//
//  Com_UserModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Com_UserModel.h"
#import <MJExtension.h>
@implementation Com_UserModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)img_header
{
    return self.photo==nil?self.headImage:self.photo;
}
-(NSString*)left0
{
    return self.username==nil?self.name:self.username;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"%@-%@",self.department,self.post];
    
}
-(NSString*)right0
{
    return self.uname==nil?self.phone:self.uname;

}
-(NSString*)right1
{
    return self.username==nil?self.company:[NSString stringWithFormat:@"入职时间：暂定"];
   }
@end
