//
//  EQDS_courseNewModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/18.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "EQDS_courseNewModel.h"
#import "WebRequest.h"
@implementation EQDS_courseNewModel
-(NSString*)courseImages
{
    if (_courseImages.length==0) {
        return nil;
    }else
    {
        return [NSString stringWithFormat:@"%@%@",HTTP_HEAD, [_courseImages componentsSeparatedByString:@";"][0]];
    }
}
@end
