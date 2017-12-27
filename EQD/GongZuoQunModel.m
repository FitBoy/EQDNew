//
//  GongZuoQunModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongZuoQunModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation GongZuoQunModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"GZQ_newImages":@"newImages"};
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"UserZan":@"ZanModel"};
}
-(NSString*)bottom_right0
{
    return self.CommentCount;
}
-(NSString*)bottom_right1;
{
    return self.ZanCount;
}
-(NSArray*)zan_imgurls
{
    NSMutableArray *arr_zan =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<self.UserZan.count; i++) {
        ZanModel *model =self.UserZan[i];
        [arr_zan addObject:model.headImage];
    }
    return arr_zan;
}
-(NSString*)head_imgurl
{
    return self.iphoto;
}
-(NSString*)left0
{
    return self.staffName==nil? self.upname:self.staffName;
}
-(NSString*)left1
{
    if (self.departName ==nil) {
        return @" ";
    }else
    {
    return [NSString stringWithFormat:@"%@-%@",self.departName,self.postName];
    }
}
-(NSString*)right1
{
    
        return [self.CreateTime datefromDatestring];
}
-(NSString*)contents
{
    return self.Message;
}
-(NSArray*)imgurls
{
    return self.GZQ_newImages;
}
-(NSString*)isZan_FB
{
    return self.isZan;
}
-(NSString*)address
{
    return self.location;
}
@end
