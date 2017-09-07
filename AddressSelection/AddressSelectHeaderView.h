//
//  AddressSelectHeaderView.h
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressSelectHeaderViewDelegate <NSObject>
- (void)AddressSelectHeaderViewBtnAtn:(float)tag;

@end
@interface AddressSelectHeaderView : UIView
/**
 *
 */
@property (nonatomic,strong) NSArray *titleArray;
/**
 *
 */
@property (nonatomic,weak) id<AddressSelectHeaderViewDelegate> delegate;
@end
