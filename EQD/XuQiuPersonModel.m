//
//  XuQiuPersonModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "XuQiuPersonModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation XuQiuPersonModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime{
    return [_createTime formatDateString];
}
-(NSString*)left0
{
    return self.postName;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"要求%@到岗",self.demandAtWorkTime];
}
-(NSString*)right0
{
    return  [NSString stringWithFormat:@"需%@人",self.recruitRenShu];
}
-(NSString*)right1
{
    return self.createTime;
}
@end
