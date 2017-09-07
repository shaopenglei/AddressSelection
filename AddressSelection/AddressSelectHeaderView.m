//
//  AddressSelectHeaderView.m
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "AddressSelectHeaderView.h"
#import "AddressModel.h"

@interface AddressSelectHeaderView ()
@property (nonatomic,strong) UIScrollView *scrollView;
@end
@implementation AddressSelectHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self bulidUI];
    }
    return  self;
}
- (void)bulidUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-1)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
}
- (void)addButton{
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *frontWidthArray = [NSMutableArray array];
    float totlewidth = 0;
    for (int i=0; i<self.titleArray.count; i++) {
        AddressModel *model = self.titleArray[i];
        float width = [self autoLayoutWidthWithStrig:model.name];
        totlewidth += width;
        [frontWidthArray addObject:@(width)];
//        float width = 100;
        float height = 20;
        float w = 10+30*i+(i==0?0:totlewidth-width);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(w, height, width, 25);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%@",model.name] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+100;
        [self.scrollView addSubview:button];
        NSLog(@"%f",(10+width)*self.titleArray.count);
        
        self.scrollView.contentSize = CGSizeMake(20+totlewidth, 0);
        if (i!=0 && i==self.titleArray.count-1) {
            button.frame = CGRectMake(w-(30+[frontWidthArray[i-1] intValue]), height, width, 25);
            [UIView animateWithDuration:0.2f animations:^{
                button.frame = CGRectMake(w, height, width, 25);
            }];
        }
    }
}
- (float)autoLayoutWidthWithStrig:(NSString *)string{
    CGSize size = CGSizeMake(100,25); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [string boundingRectWithSize:size options:NSStringDrawingUsesDeviceMetrics attributes:attribute context:nil].size;
    return labelsize.width + 3>100?100:(labelsize.width + 3);
}
- (void)buttonAction:(UIButton *)sender{
    [self.delegate AddressSelectHeaderViewBtnAtn:sender.tag-100];
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self addButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
