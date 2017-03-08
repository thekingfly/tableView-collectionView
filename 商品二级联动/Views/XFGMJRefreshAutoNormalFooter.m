//
//  XFGMJRefreshAutoNormalFooter.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/3.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "XFGMJRefreshAutoNormalFooter.h"

@implementation XFGMJRefreshAutoNormalFooter

- (void)prepare {
    [super prepare];
    
    // 设置文字
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
    
}

@end
