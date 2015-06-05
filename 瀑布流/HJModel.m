//
//  HJModel.m
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "HJModel.h"

@implementation HJModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.img = dict[@"img"];
        self.price = dict[@"price"];
        self.height = dict[@"h"];
        self.width = dict[@"w"];
    }
    return  self;
}

@end
