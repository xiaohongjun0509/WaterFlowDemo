//
//  HJWaterFlowViewController.m
//  瀑布流
//
//  Created by ihj on 15/6/1.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "HJWaterFlowViewController.h"
#import "HJWaterFlowViewCell.h"
#import "HJWaterFlowView.h"
#import "HJModel.h"
#import "UIImageView+WebCache.h"



@interface HJWaterFlowViewController ()
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) HJWaterFlowView *waterView;
@end


@implementation HJWaterFlowViewController

- (void)loadView
{
     [self loadLocalData];
    _waterView = [[HJWaterFlowView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _waterView.mdelegate = self;
    _waterView.dataSource = self;
     _waterView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = _waterView;
    [_waterView reloadHJData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadLocalData{
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"mogujie" withExtension:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    NSArray * listArray = dict[@"result"][@"list"];
    for (NSDictionary *p in listArray) {
         NSDictionary *dict =  p[@"show"];
        HJModel *model = [[HJModel alloc] initWithDict:dict];
        [self.dataList addObject:model];
    }
//    for(int i = 0; i < 10; i++)
//    {
//         [self.dataList addObjectsFromArray:self.dataList];
//    }
   [self.dataList addObjectsFromArray:self.dataList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CGFloat)waterFlowView:(HJWaterFlowView *)waterView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HJModel *model  = (HJModel *)[self.dataList objectAtIndex:indexPath.row];
    CGFloat imgHeight =  [model.height floatValue];
    CGFloat rowW = [UIScreen mainScreen].bounds.size.width / COLUMNCOUNT;
    CGFloat height = rowW /[model.width floatValue]* imgHeight;
    return height;
}


- (NSInteger)waterFlowView:(HJWaterFlowView *)waterView numberOfColumns:(NSInteger)section{
    return COLUMNCOUNT;
}


- (HJWaterFlowViewCell *)waterFlowView:(HJWaterFlowView *)waterView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HJModel *model  = (HJModel *)[self.dataList objectAtIndex:indexPath.row];
    
//    HJWaterFlowViewCell *cell = [[HJWaterFlowViewCell alloc] init];
    HJWaterFlowViewCell *cell = [waterView reuseIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HJWaterFlowViewCell alloc]init];
    }
    [cell setModel:model];
    return cell;
}


-(NSInteger)waterFlow:(HJWaterFlowView *)waterView countOfCellInSection:(NSInteger)section{
    
    return self.dataList.count;
}


- (void)waterFlowView:(HJWaterFlowView *)waterView didSelectRowAtIndex:(NSIndexPath *)index{
    NSLog(@"didSelect  %ld,%ld",index.section,index.row);
}

- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end
