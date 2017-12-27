//
//  FBTextImgModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface FBTextImgModel : NSObject
///图片
@property (nonatomic,strong)  UIImage *image;
///判断是否 是添加按钮 1，添加 2 普通图片
@property (nonatomic,copy) NSString* type;
///图片以前的状态
@property (nonatomic,strong)  PHAsset *asset;


-(instancetype)initWithasset:(PHAsset*)aset type:(NSString*)type;
@end
