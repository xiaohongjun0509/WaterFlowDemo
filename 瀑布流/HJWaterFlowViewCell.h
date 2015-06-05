//
//  HJWaterFlowViewCell.h
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HJModel.h"

@interface HJWaterFlowViewCell : UIView

@property (strong, nonatomic) UIImageView *imageView;


@property (strong, nonatomic) UILabel *priceLabel;
- (void) setModel :(HJModel *)model;

@end
