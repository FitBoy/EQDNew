//
//  FBImgView.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FBImgView : UIView
@property (nonatomic,strong) NSMutableArray<UIImageView*> *arr_imgVarr;
@property (nonatomic,assign) float height;
@property (nonatomic,strong)  NSArray<NSString*>*imgurls;
-(instancetype)initWithImgurls:(NSArray*)iurls;

@end
