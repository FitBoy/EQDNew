//
//  TrumModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TrumModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation TrumModel
-(NSString*)createTime{
    return [_createTime formatDateString];
}
-(NSString*)left0
{
    return [self.createTime datefromDatestring];
}
-(NSString*)left1
{
    return self.content;
}
-(NSString*)right0
{
    return  self.trumCode;
   
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
