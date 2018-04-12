//
//  EQDS_VideoModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_VideoModel.h"

@implementation EQDS_VideoModel
-(NSString*)vid
{
    NSArray *tarr = [self.videoUrl componentsSeparatedByString:@"id_"];
    NSString  *vid2 =[tarr lastObject];
   return  [vid2 stringByReplacingOccurrencesOfString:@".html" withString:@""];
}
@end
