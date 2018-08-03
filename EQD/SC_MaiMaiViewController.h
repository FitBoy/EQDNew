//
//  SC_MaiMaiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface SC_MaiMaiViewController : FBBaseViewController
@property (nonatomic,copy) NSString* productId;
/// 0 是供方信息   1是买方信息
@property (nonatomic,assign) NSInteger temp;
@end
