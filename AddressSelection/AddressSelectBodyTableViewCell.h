//
//  AddressSelectBodyTableViewCell.h
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressSelectBodyTableViewCell : UITableViewCell
/**
 *
 */
@property (nonatomic,strong) NSString *title;
/**
 *
 */
@property (nonatomic,strong) UILabel *titleLable;
/**
 *
 */
@property (nonatomic,strong) AddressModel *model;
/**
 *
 */
@property (nonatomic,strong) UIImageView *selectImageView;
@end
