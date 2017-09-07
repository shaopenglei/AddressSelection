//
//  AddressSelectionView.m
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "AddressSelectionView.h"
#import "AddressSelectHeaderView.h"
#import "AddressSelectBodyView.h"
#import "AddressModel.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WINDOW [UIApplication sharedApplication].keyWindow

@interface AddressSelectionView ()<UIGestureRecognizerDelegate,AddressSelectHeaderViewDelegate,AddressSelectBodyViewDelegate>
@property (nonatomic,strong) AddressSelectHeaderView *header;
@property (nonatomic,strong) AddressSelectBodyView *body;
@property (nonatomic,strong) AddressModel *lastModel;//“请选择”的model
@end
@implementation AddressSelectionView
#pragma mark -- AddressSelectBodyViewDelegate
-(void)AddressSelectBodyViewDidSelect:(NSIndexPath *)indexPath withIndex:(NSInteger)index withModel:(AddressModel *)model{
    [self.areaNumArray removeObjectsInRange:NSMakeRange(index+1, self.areaNumArray.count-index-1)];
    [self.areaNumArray replaceObjectAtIndex:index withObject:model];
    if (index==2) {
//        NSLog(@"这是AddressSelectBodyViewDidSelect大于1:%ld tableViewTag:%ld",self.body.taleViewNumArray.count,index);
        NSString *addressStr = @"";
        for (int i=0; i<self.areaNumArray.count; i++) {
            AddressModel *model = self.areaNumArray[i];
            addressStr = [addressStr stringByAppendingString:model.name];
        }
        [self.delegate AddressSelectionViewWithAddress:addressStr withAddressArray:self.areaNumArray];
//        NSLog(@"areaNumArray :%@",self.areaNumArray);
        [self hiden];
        return;
    }else {
        [self.areaNumArray addObject:self.lastModel];
    }
    self.body.tableViewNumArray = self.areaNumArray;
    self.header.titleArray = self.areaNumArray;
    self.body.scrollViewPage = self.body.tableViewNumArray.count-1;
//    NSLog(@"这是AddressSelectBodyViewDidSelect:%ld tableViewTag:%ld",self.body.taleViewNumArray.count,index);
}

#pragma mark -- AddressSelectHeaderViewDelegate
-(void)AddressSelectHeaderViewBtnAtn:(float)tag{
//    NSLog(@"这是AddressSelectHeaderViewBtnAtn:%f",tag);
    self.body.scrollViewPage = tag;
}
- (instancetype)init{
    if (self=[super init]) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI{
    [self addBGView];
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    self.backgroundColor = [UIColor whiteColor];
    [WINDOW addSubview:self];
    
    //添加header
    AddressSelectHeaderView *header = [[AddressSelectHeaderView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, 50)];
    self.header = header;
    header.delegate = self;
    [self addSubview:header];
    
    //添加body
    AddressSelectBodyView *body = [[AddressSelectBodyView alloc]initWithFrame:CGRectMake(0, header.frame.size.height+20, self.frame.size.width, self.frame.size.height-header.frame.size.height-20)];
    body.delegate = self;
    [self addSubview:body];
    self.body = body;
}
//添加黑色背影
- (void)addBGView{
    self.BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.BGView.backgroundColor = [UIColor blackColor];
    self.BGView.alpha = 0.4;
    //给背影添加点击手势
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    PrivateLetterTap.delegate = self;
    self.BGView.contentMode = UIViewContentModeScaleToFill;
    [self.BGView addGestureRecognizer:PrivateLetterTap];
    [WINDOW addSubview:self.BGView];
}
- (void)show{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hiden{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    } completion:^(BOOL finished) {
        [self removeBGView];
        [self removeFromSuperview];
    }];
}
#pragma mark ---点击触发的方法
- (void)tapAvatarView: (UITapGestureRecognizer *)gesture
{
    NSLog(@"点击");
    [self hiden];
  
}
- (NSMutableArray *)areaNumArray{
    if (!_areaNumArray) {
        _areaNumArray = [NSMutableArray array];
    }
    return _areaNumArray;
}
- (void)removeBGView{
    [self.BGView removeFromSuperview];
}
- (AddressModel *)lastModel{
    if (!_lastModel) {
        _lastModel = [[AddressModel alloc]init];
        _lastModel.name = @"请选择";
    }
    return _lastModel;
}
- (void)setAddressArray:(NSArray *)addressArray{
    _addressArray = addressArray;
    self.body.dateArray = self.addressArray;
    if (self.areaNumArray.count == 0) {
        [self.areaNumArray removeAllObjects];
        [self.areaNumArray addObject:self.lastModel];
    }else{
        self.body.backShowArray = self.areaNumArray;
    }
    self.header.titleArray = self.areaNumArray;
    self.body.tableViewNumArray = self.areaNumArray;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
