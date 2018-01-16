//
//  FB_TimeSectionViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "ThreeSectionModel.h"
@interface FB_TimeSectionViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSArray *arr_IthreeSectionModel;
@end
@protocol FB_TimeSectionViewControllerdelegate <NSObject>
-(void)getThreeSectionModel:(NSArray<ThreeSectionModel*> *)arr_threeSectionModel;
@end
