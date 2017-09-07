//
//  AddressModel.h
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/5.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
/**
 *  code    编码  前两位代表省  中间两位代表地  最后两位代表县
 */
@property (nonatomic,strong) NSString *code;
/**
 *  省
 */
@property (nonatomic,strong) NSString *province;
/**
 *  市
 */
@property (nonatomic,strong) NSString *city;
/**
 *  县
 */
@property (nonatomic,strong) NSString *county;
/**
 *  乡
 */
@property (nonatomic,strong) NSString *town;
/**
 *  level    省1 地2 县3
 */
@property (nonatomic,strong) NSString *level;
/**
 *  名字
 */
@property (nonatomic,strong) NSString *name;
/**
 *  地级数组
 */
@property (nonatomic,strong) NSArray *diArray;
/**
 *  县级数组
 */
@property (nonatomic,strong) NSArray *xianArray;
/**
 *  是否选中
 */
@property(nonatomic,assign)BOOL isSelect;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
