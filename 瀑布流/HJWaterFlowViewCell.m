//
//  HJWaterFlowViewCell.m
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "HJWaterFlowViewCell.h"
#import "UIImageView+WebCache.h"
#define PRICEFONT  [UIFont systemFontOfSize:14]

@implementation HJWaterFlowViewCell

- (instancetype) initWithIdentifier:(NSString *)identifier{
    if (self = [super init]) {
        self.identifier = identifier;
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.priceLabel];
//        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


//- (id)initWithModel:(HJModel *)model{
//    self = [super init];
//    if (self) {
//        [self addSubview:self.imageView];
//        [self addSubview:self.priceLabel];
//    }
//    return self;
//}

- (void)setModel:(HJModel *)model{
    [self.imageView setImageWithURL:[NSURL URLWithString:model.img]];
    self.priceLabel.text = model.price;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}


- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor redColor];
        _priceLabel.textAlignment = UITextAlignmentCenter;
    }
    return  _priceLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
    CGSize size = [self.priceLabel.text sizeWithFont:PRICEFONT];
    if (size.height > 0.5 * self.frame.size.height) {
        size.height = 0.5 * self.frame.size.height;
    }
    [self.priceLabel setFrame:CGRectMake(0, self.frame.size.height - size.height, self.frame.size.width, size.height)];
}



@end
