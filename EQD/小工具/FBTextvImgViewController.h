//
//  FBTextvImgViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 图文填写

#import "FBBaseViewController.h"
@interface FBTextvImgViewController : FBBaseViewController
///标题
@property (nonatomic,copy) NSString* contentTitle;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) id delegate;
@end
@protocol FBTextvImgViewControllerDelegate <NSObject>

-(void)text:(NSString*)text  imgArr:(NSArray<UIImage*>*)imgArr indexPath:(NSIndexPath*)indexPath;
@end
