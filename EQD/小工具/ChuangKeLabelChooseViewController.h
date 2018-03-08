//
//  ChuangKeLabelChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChuangKeLabelChooseViewController : UIViewController
@property (nonatomic,weak)  id delegate;
@end
@protocol ChuangKeLabelChooseViewControllerDelegate <NSObject>
-(void)getChuangkeLabel:(NSArray *)arr_str;
@end
