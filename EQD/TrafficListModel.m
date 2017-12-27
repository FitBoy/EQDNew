//
//  TrafficListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TrafficListModel.h"
#import "NSString+FBString.h"
@implementation TrafficListModel
-(NSString*)left0
{
    return [NSString stringWithFormat:@"车号:%@",self.plateNumber];
}
-(NSString*)left1
{
    return [self.isdone integerValue]==0?@"未处理":@"已处理" ;
}
-(NSString*)right0
{
    return [NSString stringWithFormat:@"违章人:%@",self.personLiableName];
}
-(NSString*)right1
{
    return [NSString stringWithFormat:@"违章时间:%@",self.theDate];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)theDate
{
    return [_theDate formatDateString];
}
@end
