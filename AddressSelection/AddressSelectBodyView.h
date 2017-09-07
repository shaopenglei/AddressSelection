//
//  AddressSelectBodyView.h
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"


@protocol AddressSelectBodyViewDelegate <NSObject>
- (void)AddressSelectBodyViewDidSelect:(NSIndexPath *)indexPath withIndex:(NSInteger)index withModel:(AddressModel *)model;

@end

@interface AddressSelectBodyView : UIView
/**
 *
 */
@property (nonatomic,weak) id<AddressSelectBodyViewDelegate> delegate;
/**
 *  taleView数组
 */
@property (nonatomic,strong) NSArray *tableViewNumArray;
/**
 *  cell数据
 */
@property (nonatomic,strong) NSArray *dateArray;
/**
 *  scrollView页数
 */
@property (nonatomic,assign) NSInteger scrollViewPage;
/**
 * 回显数组
 */
@property (nonatomic,strong) NSArray *backShowArray;

@end
