//
//  AddressSelectBodyTableViewCell.m
//  AddressSelection
//
//  Created by 邵朋磊 on 2017/9/4.
//  Copyright © 2017年 邵朋磊. All rights reserved.
//

#import "AddressSelectBodyTableViewCell.h"

@implementation AddressSelectBodyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //初始化的时候cell的宽是320，所以在这里加横线
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.bounds.size.height-1, self.contentView.bounds.size.width, 0.5)];
//    lineView.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:lineView];
}
- (void)buildUI{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    self.titleLable = label;
    [self.contentView addSubview:label];
    UIImageView *selectImageView = [[UIImageView alloc]init];
    selectImageView.backgroundColor = [UIColor clearColor];
    self.selectImageView = selectImageView;
    [self.contentView addSubview:selectImageView];
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLable.text = self.title;
}
- (void)setModel:(AddressModel *)model{
    _model = model;
    self.titleLable.text = self.model.name;
    self.titleLable.frame = CGRectMake(15, 0, [self autoLayoutWidthWithStrig:self.model.name], self.frame.size.height);
    self.selectImageView.frame = CGRectMake(25+self.titleLable.frame.size.width, 0, 15, 15);
    CGPoint center = self.selectImageView.center;
    center.y = self.contentView.center.y;
    self.selectImageView.center = center;
    if (self.model.isSelect) {
        self.titleLable.textColor = [UIColor redColor];
    [self.selectImageView setImage:[UIImage imageNamed:@"select"]];
    }else {
        self.titleLable.textColor = [UIColor blackColor];
        [self.selectImageView setImage:[UIImage imageNamed:@""]];
    }
}
- (float)autoLayoutWidthWithStrig:(NSString *)string{
    CGSize size = CGSizeMake(100,25); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [string boundingRectWithSize:size options:NSStringDrawingUsesDeviceMetrics attributes:attribute context:nil].size;
    return labelsize.width + 5;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
