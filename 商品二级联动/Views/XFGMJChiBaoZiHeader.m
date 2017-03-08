//
//  XFGMJChiBaoZiHeader.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/3.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "XFGMJChiBaoZiHeader.h"

@implementation XFGMJChiBaoZiHeader

- (void)prepare {
    [super prepare];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 自动改变透明度
    self.automaticallyChangeAlpha = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;

}

@end
