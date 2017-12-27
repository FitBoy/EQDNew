//
//  CarManagerModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarManagerModel.h"

@implementation CarManagerModel
-(NSString*)img_header
{
    return self.pic1;
}
-(NSString*)left0
{
    return self.vehicleType;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"%@个座位",self.seats];
}
-(NSString*)right0
{
    return self.plateNumber;
}

@end
