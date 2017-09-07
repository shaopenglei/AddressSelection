//
//  ViewController.m
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "ViewController.h"
#import "AddressSelectionView.h"
#import "AddressModel.h"

@interface ViewController ()<AddressSelectionViewDelegate>
@property (nonatomic, strong) NSArray *addressArray;
@property (nonatomic,strong) NSArray *selectAddressArray;
@property (nonatomic,strong) AddressSelectionView *addressSelectionView;
@end

@implementation ViewController
- (void)AddressSelectionViewWithAddress:(NSString *)address withAddressArray:(NSArray *)addressArray{
    NSLog(@"选择的地址:%@",address);
    self.selectAddressArray = addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString* jsonStr = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    jsonStr  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *jaonData   = [[NSData alloc] initWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *allTrack = [NSJSONSerialization JSONObjectWithData:jaonData options:(NSJSONReadingMutableContainers) error:nil];
    NSMutableArray *mutArray = [NSMutableArray array];

    for (NSDictionary *dict in allTrack) {
        AddressModel *model = [[AddressModel alloc]initWithDict:dict];
        [mutArray addObject:model];
    }
    
    self.addressArray = mutArray;
    NSLog(@"地址:%@",self.addressArray);
    
}
- (IBAction)buttonAction:(id)sender {
    AddressSelectionView *addressSelectView = [[AddressSelectionView alloc]init];
    [addressSelectView.areaNumArray  addObjectsFromArray:self.selectAddressArray];
    addressSelectView.addressArray = self.addressArray;
    addressSelectView.delegate = self;
    [addressSelectView show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
