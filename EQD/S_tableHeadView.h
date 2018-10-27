//
//  S_tableHeadView.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBButton.h"
@interface S_tableHeadView : UITableViewHeaderFooterView
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  FBButton *B_more;
-(void)setname:(NSString*)name btnHidden:(BOOL)hidden;
@end
