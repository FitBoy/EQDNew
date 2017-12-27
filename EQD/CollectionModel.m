//
//  CollectionModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CollectionModel.h"
#import "NSString+FBString.h"
@implementation CollectionModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
-(NSArray*)arr_urls
{
    if (self.url.length>1) {
        NSArray *tarr = [self.url componentsSeparatedByString:@";"];
        NSMutableArray *tarr2 =[NSMutableArray arrayWithArray:tarr];
        [tarr2 removeLastObject];
        return tarr2;
    }else
    {
        return nil;
    }
    
}
@end
