//
//  XFGCTowCollectionViewCell.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/3.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "XFGCTowCollectionViewCell.h"

@implementation XFGCTowCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        _nextButton =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width,self.height)];
        [_nextButton setTitleColor:XFGGlobalFoutColor forState:UIControlStateNormal];
        [_nextButton setTitleColor:XFGLogoColor forState:UIControlStateSelected];
        [_nextButton setTitle:@"测试" forState:UIControlStateNormal];
//        [_nextButton setBackgroundColor:[UIColor whiteColor]];

        [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_nextButton];

    }
    
    return self;
}



@end
