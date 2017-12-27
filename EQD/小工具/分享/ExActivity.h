//
//  ExActivity.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBShareViewController.h"
@interface ExActivity : UIActivity
+ (UIActivityCategory)activityCategory;
-(NSString*)activityTitle;
-(UIImage*)activityImage;
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;   //

- (UIViewController *)activityViewController;
@property (nonatomic,strong)  RCMessageContent *messageContent;

@end
