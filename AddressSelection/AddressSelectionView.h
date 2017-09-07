//
//  AddressSelectionView.h
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddressSelectionViewDelegate <NSObject>
- (void)AddressSelectionViewWithAddress:(NSString*)address withAddressArray:(NSArray *)addressArray;

@end

@interface AddressSelectionView : UIView
/**
 *
 */
@property (nonatomic,weak) id<AddressSelectionViewDelegate> delegate;
/**
 *  所有地址
 */
@property (nonatomic,strong) NSArray *addressArray;
/**
 *  黑色背影
 */
@property (nonatomic,strong) UIView *BGView;
/**
 *  地址model数组
 */
@property (nonatomic,strong) NSMutableArray *areaNumArray;
- (void)show;
- (void)hiden;
@end
