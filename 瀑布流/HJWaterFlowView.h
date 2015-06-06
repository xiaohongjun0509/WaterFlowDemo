//
//  HJWaterFlowView.h
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJWaterFlowViewCell.h"
//#import "HJWaterFlowView.h"
@class HJWaterFlowView;

#define  COLUMNCOUNT 3

@protocol HJWaterFlowViewDelegate <NSObject, UIScrollViewDelegate>

- (CGFloat)waterFlowView:(HJWaterFlowView *)waterView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) waterFlowView:(HJWaterFlowView *)waterView didSelectRowAtIndex :(NSIndexPath *)index;

@end


@protocol HJWaterFlowViewDataSource <NSObject>

- (NSInteger)waterFlowView:(HJWaterFlowView *)waterView numberOfColumns:(NSInteger)section;

- (HJWaterFlowViewCell *)waterFlowView:(HJWaterFlowView *)waterView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//UITableView


- (NSInteger) waterFlow:(HJWaterFlowView *)waterView countOfCellInSection:(NSInteger)section;

@end



@interface HJWaterFlowView : UIScrollView

@property (weak, nonatomic) id<HJWaterFlowViewDelegate> mdelegate;

@property (weak, nonatomic) id<HJWaterFlowViewDataSource> dataSource;

- (void) reloadHJData;

- (id)reuseIdentifier:(NSString *)inedtifier;

@end


//