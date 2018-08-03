//
//  RenWuListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RenWuListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation RenWuListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)left0
{
    return self.name;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"编码:%@",self.code];
    }
-(NSString*)right0
{
    return [NSString stringWithFormat:@"编码:%@",self.code];
}
-(NSString*)right1
{
    return [self.creatTime formatDateString];
 
}
-(NSString*)creatTime
{
    return [_creatTime formatDateString];
}
@end
