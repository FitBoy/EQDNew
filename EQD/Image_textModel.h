//
//  Image_textModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image_textModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* ImageUrl;
@property (nonatomic,copy) NSString* describe;
@property (nonatomic,copy) NSString* sort;
@property (nonatomic,assign) float cell_height;

@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* Describe;

@property (nonatomic,copy) NSString* createTime;
-(NSString*)createTime;

@property (nonatomic,copy) NSString* imgUrl;
@end
