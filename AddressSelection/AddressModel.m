//
//  AddressModel.m
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/5.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.code = dict[@"code"];
        self.city = dict[@"di"];
        self.province = dict[@"sheng"];
        self.county = dict[@"xian"];
        self.name = dict[@"name"];
        self.level = dict[@"level"];
    }
    return self;
}
@end
