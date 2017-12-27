//
//  Com_imgAdd_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "Com_ImgModel.h"
@interface Com_imgAdd_DetailViewController : FBBaseViewController
@property (nonatomic,copy) NSString* number_big;
@property (nonatomic,strong)  Com_ImgModel *model;
@end
