//
//  HJModel.h
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJModel : NSObject
@property (copy, nonatomic) NSString * img;
@property (copy, nonatomic) NSString * price;
@property (copy, nonatomic) NSString * height;
@property (copy, nonatomic) NSString * width;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
