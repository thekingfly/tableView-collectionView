//
//  XFGCategoryCell.h
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFGCategoryCell : UITableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView;
@property (nonatomic,strong) UILabel * nameLabel;


@end
