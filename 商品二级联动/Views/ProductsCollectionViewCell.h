//
//  ProductsCollectionViewCell.h
//  商品二级联动
//
//  Created by 方飞 on 17/3/3.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificsLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addCart;

@end
