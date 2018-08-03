//
//  Two_BiaoQian_ViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "BiaoQianModel.h"
@interface Two_BiaoQian_ViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_baioqian;
@end
@protocol Two_BiaoQian_ViewControllerDelegate <NSObject>
-(void)getBiaoQianModel:(BiaoQianModel*)model_biaoqian;
@end

