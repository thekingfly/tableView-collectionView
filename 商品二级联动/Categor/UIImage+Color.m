//
//  UIImage+Color.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
