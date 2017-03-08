//
//  ProductsCell.h
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsCell : UITableViewCell
// 商品的图片
@property (nonatomic,strong) UIImageView *goodsImageView;
// 商品名字
@property (nonatomic,strong) UILabel *nameLabel;
// 商品单位
@property (nonatomic,strong) UILabel *specificsLabel;
// 商品价格
@property (nonatomic,strong) UILabel *price;
// 加入购物车
@property (nonatomic,strong) UIButton *addCart;

+ (instancetype)cellWithTable:(UITableView *)tableView;

@end
