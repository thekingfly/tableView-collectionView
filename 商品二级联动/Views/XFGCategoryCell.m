//
//  XFGCategoryCell.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "XFGCategoryCell.h"


@implementation XFGCategoryCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *cellId = @"CategoryCellID";
    XFGCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[XFGCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {

        self.backgroundColor = XFGGlobalBg;
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = kFont(14);
        _nameLabel.text = @"测试";
        _nameLabel.textColor = XFGGlobalFoutColor;
        _nameLabel.highlightedTextColor = [UIColor whiteColor];
        //设置圆角
        [_nameLabel hg_setAllCornerWithCornerRadius:(self.height-20)/2];
        [self.contentView addSubview:_nameLabel];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self);
            make.width.equalTo(self.mas_width).offset(-16);
            make.height.equalTo(@(25));
//            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }
    return self;
    
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    self.nameLabel.highlighted = selected;
    if (selected) {
        
        self.nameLabel.backgroundColor = XFGLogoColor;
    }else{
        self.nameLabel.backgroundColor = [UIColor clearColor];
    }
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
