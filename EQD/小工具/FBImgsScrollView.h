//
//  FBImgsScrollView.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBImgsScrollView : UIScrollView
@property (nonatomic,strong)  NSMutableArray *arr_imageViews;
@property (nonatomic,strong) NSArray *arr_stringImgs;
///特殊情况下的indexPath
@property (nonatomic,strong)  NSIndexPath *indexPath;
-(void)setArr_stringImgs:(NSArray *)arr_stringImgs Withsize:(CGSize)size;

///单元格的大小
@property (nonatomic,assign) CGSize size;
@property (nonatomic,weak) id delegate_imgviews;
@end
@protocol FBImgsScrollViewDelegate <NSObject>
-(void)getImgsScrollViewSelectedViewWithtag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath;
@end
