//
//  ProductsController.h
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarAnimationViewController.h"

@interface ProductsController : ShopCarAnimationViewController
@property (nonatomic,strong) UITableView * productsTableView;
@property (nonatomic,strong) UICollectionView * productsCollectionView;
@property (nonatomic, strong) UIButton *cartBtn;
@end
