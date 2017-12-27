//
//  GLLianXiModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLLianXiModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation GLLianXiModel
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
    return self.post;
}
-(NSString*)right0
{
    return self.cellphone;
}
-(NSString*)createTime{
    return [_createTime formatDateString];
}
@end
