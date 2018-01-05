//
//  EQDR_LeiBieArticle2ViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 文章的分类选择

#import <UIKit/UIKit.h>
#import "OptionModel.h"
@interface EQDR_LeiBieArticle2ViewController : UIViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSArray  *arr_chooses;
@end
@protocol EQDR_LeiBieArticle2ViewControllerDelegate <NSObject>
-(void)getArticleWithModel:(NSArray<OptionModel*>*)mode;
@end
