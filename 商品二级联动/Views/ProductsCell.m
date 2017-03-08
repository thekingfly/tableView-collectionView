//
//  ProductsCell.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "ProductsCell.h"
@interface ProductsCell ()




@property (nonatomic,strong) UIView *lineView;

@end
@implementation ProductsCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *cellId = @"ProductsCellID";
    ProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProductsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _goodsImageView = [[UIImageView alloc]init];
        
        _goodsImageView.image = [UIImage imageNamed:@"v2_placeholder_square"];
        [self.contentView addSubview:_goodsImageView];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(13);
        _nameLabel.textColor = XFGGlobalFoutColor;
        _nameLabel.text = @"水果";
        [self.contentView addSubview:_nameLabel];
        

        
        _specificsLabel = [[UILabel alloc]init];
        _specificsLabel.font = kFont(13);
        _specificsLabel.textColor = XFGWeakColor;
        _specificsLabel.text =@"350k";
        [self.contentView addSubview:_specificsLabel];
        
        _price = [[UILabel alloc]init];
        _price.font = kFont(14);
        _price.textColor = XFGStrongColor;
        _price.text = @"¥3.00";
        [self.contentView addSubview:_price];
        UIImage *image = [UIImage imageNamed:@"+"];
        _addCart = [[UIButton alloc]init];
        [_addCart setImage:image forState:UIControlStateNormal];
        [self.contentView addSubview:_addCart];
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = XFGWeakColor;
        [self.contentView addSubview:_lineView];
        
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.leading.equalTo(self);
            make.width.mas_equalTo(self.mas_height);
            make.height.mas_equalTo(self.mas_height);
        }];
        

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_goodsImageView.mas_trailing);
            make.trailing.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(20);
        }];

        [_specificsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLabel);
            make.top.equalTo(self.mas_bottom).offset(-30);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        
        [_addCart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-image.size.width);
            make.top.equalTo(self.mas_bottom).offset(-30);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        

    }
    return self;
}


@end
