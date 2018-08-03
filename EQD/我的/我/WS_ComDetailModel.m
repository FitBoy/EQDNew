//
//  WS_ComDetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "WS_ComDetailModel.h"
#import <MJExtension.h>
@implementation WS_ComDetailModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"ComTeam":@"SC_TeamModel",
             @"ComOrganization":@"Image_textModel",
             @"ComEquipment":@"WS_equipmentModel",
             @"ComImage":@"Image_textModel"
             };
}
@end
