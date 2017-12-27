//
//  FBTextImgModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextImgModel.h"
#import "NSString+FBString.h"
@implementation FBTextImgModel
-(instancetype)initWithasset:(PHAsset*)aset type:(NSString*)type{
    if (self =[super init]) {
        self.asset =aset;
        PHImageRequestOptions *options= [[PHImageRequestOptions alloc]init];
        options.synchronous = YES;
        [[PHImageManager  defaultManager] requestImageDataForAsset:aset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            self.image = [[UIImage alloc]initWithData:imageData];
            
        }];
        self.type =type;
    }
    return self;
}




@end
