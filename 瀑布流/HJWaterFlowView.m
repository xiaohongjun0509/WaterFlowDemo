//
//  HJWaterFlowView.m
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "HJWaterFlowView.h"


@interface HJWaterFlowView ()
{
    NSInteger columnCount;
    NSInteger totalCount;
    NSInteger currentColumn;
//    NSMutableArray *rowH;
}


//可见试图的数组
@property (strong, nonatomic) NSMutableDictionary *visibleCellDicts;

@property (strong, nonatomic) NSMutableSet *cacheSet;

@property (strong, nonatomic) NSMutableArray *indexArray;

@property (strong, nonatomic) NSMutableArray *cellFrameArray;

@end

@implementation HJWaterFlowView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self generateCache];
    }
    return  self;
}


//判断当前cell是否在屏幕上

- (BOOL) visibleInScreen : (CGRect )frame
{
    return frame.origin.y + frame.size.height > self.contentOffset.y && frame.origin.y < self.contentOffset.y + self.frame.size.height;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
//    [self reloadHJData];
}

- (void)reloadHJData
{
    [self generateCache];
//    1.获得列数目。
    columnCount = 1;
    if ([_dataSource respondsToSelector:@selector(waterFlowView:numberOfColumns:)]) {
       columnCount = [_dataSource waterFlowView:self numberOfColumns:0];
    }
//    2.获得总的图片的数目
     totalCount = [_dataSource waterFlow:self countOfCellInSection:0];
    CGFloat rowH [COLUMNCOUNT];
    for (int i = 0; i < COLUMNCOUNT; i ++) {
        rowH[i] = 0.0;
    }
    CGFloat cellW = self.frame.size.width / COLUMNCOUNT;
    
    for (int i = 0; i < totalCount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.indexArray addObject:indexPath];
        CGFloat height = [_mdelegate waterFlowView:self heightForRowAtIndexPath:indexPath];
        currentColumn = i % COLUMNCOUNT;
        CGFloat rowX = currentColumn * cellW;
        NSValue * value = [NSValue valueWithCGRect:CGRectMake(rowX, rowH[currentColumn], cellW, height)];
        [self.cellFrameArray addObject: value];
        rowH[currentColumn] += height;
    }
    CGFloat maxH = 0;
    for (int i = 0; i < COLUMNCOUNT; i ++) {
        if (rowH[i] > maxH) {
            maxH = rowH[i];
        }
    }
    self.contentSize = CGSizeMake(self.frame.size.width, maxH);
    [self setNeedsDisplay];
}

- (id)reuseIdentifier:(NSString *)inedtifier
{
    HJWaterFlowViewCell *cell = [self.cacheSet anyObject];
    if (cell) {
        [self.cacheSet removeObject:cell];
    }
    return cell;
}


- (void)layoutSubviews{
    
    for (int i = 0; i < totalCount; i ++) {
        NSIndexPath *indexPath = [self.indexArray objectAtIndex:i];
        CGRect frame = [[self.cellFrameArray objectAtIndex:i] CGRectValue];
//        这不得工作由controller在delegate获得Cell的时候来完成。
//        HJWaterFlowViewCell  *cell = [self reuseIdentifier:@"cell"];
        HJWaterFlowViewCell *cell = self.visibleCellDicts[indexPath];
        if (cell ==nil) {
            cell = [_mdelegate waterFlowView:self cellForRowAtIndexPath:indexPath];
            if ([self visibleInScreen:frame]) {
                [self.visibleCellDicts setObject:cell forKey:indexPath];
                [self addSubview:cell];
                [cell setFrame:frame];
            }
            
            
        }else{
            if (![self visibleInScreen:frame]) {
                [cell removeFromSuperview];
                [self.visibleCellDicts removeObjectForKey:indexPath];
                [self.cacheSet addObject:cell];
            }
            
        }
       
    }

    NSLog(@"%ld",self.subviews.count);
}


//懒加载产生相关的数据单元
- (void) generateCache{
    if (_visibleCellDicts == nil) {
        _visibleCellDicts = [NSMutableDictionary dictionary];
    }else{
        [_visibleCellDicts removeAllObjects];
    }
    
    
    if (_indexArray == nil) {
        _indexArray = [NSMutableArray array];
    }else{
        [_indexArray removeAllObjects];
    }
    
    
    if (_cacheSet == nil) {
        _cacheSet = [NSMutableSet set];
    }else{
        [_cacheSet removeAllObjects];
    }
    
    
    if (_cellFrameArray == nil) {
        _cellFrameArray = [NSMutableArray array];
    }else{
        [_cellFrameArray removeAllObjects];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touchView = [touches anyObject];
    CGPoint point = [touchView locationInView:self];
    NSArray * keyArray = [self.visibleCellDicts allKeys];
    for (NSIndexPath *indexPath in keyArray) {
        HJWaterFlowViewCell *cell = self.visibleCellDicts[indexPath];
        if (CGRectContainsPoint(cell.frame, point)) {
            if ([self.mdelegate respondsToSelector:@selector(waterFlowView:didSelectRowAtIndex:)]) {
                [self.mdelegate waterFlowView:self didSelectRowAtIndex :indexPath];
            }
            break;
        }
    }
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.contentOffset.y + self.bounds.size.height > self.contentSize.height)
    {
//        在这里加载更多。
    }
}


@end
