//
//  ChuChaiDetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ChuChaiDetailModel.h"
#import "NSString+FBString.h"
@implementation ChuChaiDetailModel
-(NSString*)createTime
{
  return  [_createTime formatDateString];
}
-(NSString*)travelStartTime
{
   return [_travelStartTime formatDateString];
}
-(NSString*)travelEndTime
{
   return [_travelEndTime formatDateString];
}
@end
