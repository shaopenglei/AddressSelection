//
//  AddressSelectBodyView.m
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "AddressSelectBodyView.h"
#import "AddressSelectBodyTableViewCell.h"
#import "AddressModel.h"
@interface AddressSelectBodyView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *tableViewArray;
@property (nonatomic,strong) NSMutableArray *totleModelArray;
@end
@implementation AddressSelectBodyView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}
- (void)addTableView{
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tableViewArray removeAllObjects];
    for (int i=0; i<self.tableViewNumArray.count; i++) {
        float w = self.frame.size.width*i;
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(w, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.scrollView addSubview:tableView];
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*self.tableViewNumArray.count, 0);
        [self.tableViewArray addObject:tableView];
    }
}
- (NSMutableArray *)totleModelArray{
    if (!_totleModelArray) {
        _totleModelArray = [NSMutableArray array];
    }
    return _totleModelArray;
}
- (NSMutableArray *)tableViewArray{
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}
- (void)setTableViewNumArray:(NSArray *)tableViewNumArray{
    _tableViewNumArray = tableViewNumArray;
    [self addTableView];
}
- (void)setDateArray:(NSArray *)dateArray{
    _dateArray = dateArray;
    if (self.backShowArray.count==0) {
        [self.totleModelArray removeAllObjects];
        [self totleModelArrayAddInitValue];
        for (UITableView *tableView in self.tableViewArray) {
            [tableView reloadData];
        }
    }
}
//给totleModelArray赋初始值
- (void)totleModelArrayAddInitValue{
    NSMutableArray *provinceArray = [NSMutableArray array];
    for (AddressModel *model in self.dateArray) {
        model.isSelect = NO;
        if ([model.level intValue]==1){
            [provinceArray addObject:model];
        }
    }
    [self.totleModelArray addObject:provinceArray];
}
#pragma mark -- tableViewDelagate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.totleModelArray.count>0?self.totleModelArray[tableView.tag]:nil;
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"addressCell";
    AddressSelectBodyTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!Cell) {
        Cell = [[AddressSelectBodyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AddressModel *model = self.totleModelArray[tableView.tag][indexPath.row];
    Cell.model = model;
    return Cell;
}
#pragma mark -- tableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel *selectModel = self.totleModelArray[tableView.tag][indexPath.row];
    if (selectModel.isSelect && tableView.tag!=self.tableViewArray.count-1) {
        [self setScrollViewPage:tableView.tag+1];
        return;
    }
    if (tableView.tag==0) [self totleModelArrayAddInitValue];
    [self.totleModelArray removeObjectsInRange:NSMakeRange(tableView.tag+1, self.totleModelArray.count-tableView.tag-1)];
    if (tableView.tag<2) {//添加第四级在这里添加逻辑，tableView.tag改成<3
        NSMutableArray *cityArray = [NSMutableArray array];
        NSMutableArray *countyArray = [NSMutableArray array];
//        NSMutableArray *townArray = [NSMutableArray array];
        for (AddressModel *model in self.dateArray) {
            if ([model.level intValue]==2 && [selectModel.province intValue]==[model.province intValue]){
                model.isSelect = NO;
                [cityArray addObject:model];
            }else if ([model.level intValue]==3 && [selectModel.city intValue]==[model.city intValue] && [selectModel.province intValue]==[model.province intValue]) {
                model.isSelect = NO;
                [countyArray addObject:model];
            }
        }
        if (tableView.tag==0) {
            [self.totleModelArray addObject:cityArray];
        }else if (tableView.tag==1){
            [self.totleModelArray addObject:countyArray];
        }
    }
    selectModel.isSelect = YES;
    [self.delegate AddressSelectBodyViewDidSelect:indexPath withIndex:tableView.tag withModel:selectModel];
}
- (void)setScrollViewPage:(NSInteger)scrollViewPage{
    _scrollViewPage = scrollViewPage;
    [self.scrollView setContentOffset:CGPointMake(self.scrollViewPage*self.frame.size.width, 0) animated:YES];
}
- (void)setBackShowArray:(NSArray *)backShowArray{
    _backShowArray = backShowArray;
    //添加第四级在这里添加逻辑
    [self.totleModelArray removeAllObjects];
    NSMutableArray *provinceArray = [NSMutableArray array];
    NSMutableArray *cityArray = [NSMutableArray array];
    NSMutableArray *countyArray = [NSMutableArray array];
//    NSMutableArray *townArray = [NSMutableArray array];
    for (int i=0; i<self.backShowArray.count; i++) {
        AddressModel *selectModel = self.backShowArray[i];
        for (AddressModel *model in self.dateArray) {
            if ([model.code intValue]==[selectModel.code intValue]) {
                model.isSelect = YES;
            }
            if ([model.level intValue]==1) {
                [provinceArray addObject:model];
            }else if ([model.level intValue]==2 && [selectModel.province intValue]==[model.province intValue] && i==1){
                [cityArray addObject:model];
            }else if ([model.level intValue]==3 && [selectModel.city intValue]==[model.city intValue] && [selectModel.province intValue]==[model.province intValue] && i==2) {
                [countyArray addObject:model];
            }
            
        }
        if (i==0) {
            [self.totleModelArray addObject:provinceArray];
        }else if (i==1) {
            [self.totleModelArray addObject:cityArray];
        }else if (i==2){
            [self.totleModelArray addObject:countyArray];
        }
    }
    for (UITableView *tableView in self.tableViewArray) {
        [tableView reloadData];
    }
    [self.scrollView setContentOffset:CGPointMake(self.totleModelArray.count*self.frame.size.width, 0) animated:NO];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
