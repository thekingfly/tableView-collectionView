//
//  ViewController.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/1.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "ViewController.h"

#import "XFGCategoryCell.h"
#import "UIButton+LXMImagePosition.h"
#import "ProductsController.h"
#import "LZCartViewController.h"
#import "XFGCTowCollectionViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UITableView * categoriesTableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UIButton *zhBtn;
@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *nextCurrentButton;
@property (nonatomic, strong) UIButton *nextSelectButton;
@property (nonatomic, strong) UIView *nextBgView;
@property (nonatomic, strong) UIView *nextView;
@property (nonatomic, strong) NSArray *nextCategoriesAll;
@property (nonatomic, strong) NSMutableArray *allNextBtn;

@property (nonatomic,strong) ProductsController *productsController;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cartBtn;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger clickBtnCount;
@property (nonatomic, assign) NSInteger clickBtnCount2;
@property (nonatomic, assign) NSInteger lastClickT;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城";
    self.view.backgroundColor = XFGGlobalBg;

    [self setUpcategoriesTableView];
    
    [self setUpProductsTableView];
    
    [self setTopView];
    
    [self creatBgView];
    
    [self creatCart];

    NSInteger selectedIndex = 0;
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.categoriesTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];


    
}

-(void)setUpcategoriesTableView
{
    self.categoriesTableView = ({
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.backgroundColor = XFGGlobalBg;
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
    [self.view addSubview:self.categoriesTableView];
    [self.categoriesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.25);
    }];
}

-(void)setUpProductsTableView
{
    self.productsController = [[ProductsController alloc]init];
    [self addChildViewController:self.productsController];
    [self.view addSubview:self.productsController.view];
    _productsController.productsTableView.hidden = NO;
    _productsController.productsCollectionView.hidden = YES;
//    self.delegate = self.productsController;
//    self.productsController.delegate =self;
}

-(void)setUpCategoriesCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    float collectionView_W = UISCREENWIDTH*0.75;
    //定义每个UICollectionView 的大小
    flowLayout.itemSize = CGSizeMake(UISCREENWIDTH/4, 29);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, collectionView_W, self.view.height-35-64) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    //这个是两行cell之间的间距（上下行cell的间距）
    flowLayout.minimumLineSpacing = 0;
    //两个cell之间的间距（同一行的cell的间距）
    flowLayout.minimumInteritemSpacing = 0;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
    //自适应大小
//    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //注册cell和ReusableView（相当于头部）
    [_collectionView registerClass:[XFGCTowCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_nextBgView addSubview:self.collectionView];

}

#pragma mark - Collection View Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _nextCategoriesAll.count;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    XFGCTowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    

    

    [cell.nextButton setTitle:self.nextCategoriesAll[indexPath.item] forState:UIControlStateNormal];
    

    cell.nextButton.tag = indexPath.item;
    [cell.nextButton addTarget:self action:@selector(clickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.nextButton.selected = NO;
    if (_allBtn.selected) {
        
        if (_nextCategoriesAll.count && indexPath.item == _clickBtnCount) {
            cell.nextButton.selected = YES;
            _nextSelectButton = cell.nextButton;
        }
    }else if(_zhBtn.selected){
        if (_nextCategoriesAll.count && indexPath.item == _clickBtnCount2) {
            cell.nextButton.selected = YES;
            _nextSelectButton = cell.nextButton;
        }
    }


    NSInteger rows;
    rows = (_nextCategoriesAll
            .count%3)?(_nextCategoriesAll.count/3+1):(_nextCategoriesAll.count/3);
    rows = rows?rows:1;//row>0为原值，否则为1；
    
    CGFloat h =29;
    [_nextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.top.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width);
        make.height.equalTo(@(h*rows));
    }];

    
    [cell sizeToFit];
    return cell;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XFGLog(@"indexPath.item = %ld",indexPath.item);
    
}

-(void)creatCart{
    
    UIImage *cart = [UIImage imageNamed:@"cart"];
    _cartBtn = [[UIButton alloc]init];
//    [_cartBtn setImage:cart forState:UIControlStateNormal];
    [_cartBtn addTarget:self action:@selector(clickCartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cartBtn];
    
    [_cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.width.mas_equalTo(cart.size.width);
        make.height.mas_equalTo(cart.size.height);
    }];
    
}

-(void)setTopView{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = XFGGlobalBg;
    [_topView addSubview:line];
    
    UIImage *imgV = [UIImage imageNamed:@"V"];
    CGFloat imgVW = imgV.size.width;
    _allBtn = [[UIButton alloc]init];
    [_allBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [_allBtn setImage:imgV forState:UIControlStateNormal];
    [_allBtn setTitleColor:XFGGlobalFoutColor forState:UIControlStateNormal];
    [_allBtn setTitleColor:XFGLogoColor forState:UIControlStateSelected];
    [_allBtn addTarget:self action:@selector(clickAllBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [_allBtn.titleLabel setFont: [UIFont systemFontOfSize:12]];
    
    CGSize size = [_allBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
    CGFloat spacing = 2;
     //image在右
    _allBtn.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + spacing/2, 0, -(size.width + spacing/2));
   
    _allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgVW + spacing/2), 0, imgVW + spacing/2);
    [_allBtn setImagePosition:LXMImagePositionRight spacing:spacing];
    [_topView addSubview:_allBtn];
    
    
    _zhBtn = [[UIButton alloc]init];
    [_zhBtn setTitle:@"综合排序" forState:UIControlStateNormal];
    [_zhBtn setImage:imgV forState:UIControlStateNormal];
    [_zhBtn.titleLabel setFont: [UIFont systemFontOfSize:12]];
    [_zhBtn setTitleColor:XFGGlobalFoutColor forState:UIControlStateNormal];
    [_zhBtn setTitleColor:XFGLogoColor forState:UIControlStateSelected];
    [_zhBtn addTarget:self action:@selector(clickZhBtn)
     forControlEvents:UIControlEventTouchUpInside];

    [_topView addSubview:_zhBtn];
    [_zhBtn setImagePosition:LXMImagePositionRight spacing:spacing];
    
    UIImage *image = [UIImage imageNamed:@"zh1"];
    UIImage *image2 = [UIImage imageNamed:@"zh2"];
    _typeBtn = [[UIButton alloc]init];
    [_typeBtn setImage:image forState:UIControlStateNormal];
    [_typeBtn setImage:image2 forState:UIControlStateSelected];
    [_typeBtn addTarget:self action:@selector(clickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_typeBtn];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = XFGWeakColor;
    [_topView addSubview:_lineView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.categoriesTableView.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(35));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView.mas_centerX).offset(-20);
        make.centerY.equalTo(_topView.mas_centerY);
        make.width.equalTo(@(2));
        make.height.equalTo(_topView.mas_height).offset(-6);
    }];
    
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.right.equalTo(line.mas_left);
        make.centerY.equalTo(_topView.mas_centerY);
        make.height.equalTo(_topView.mas_height);
    }];
    
    [_zhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right);
        make.right.equalTo(_topView.mas_right).offset(-40);
        make.top.equalTo(_topView.mas_top);
        make.height.equalTo(_topView.mas_height);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zhBtn.mas_right);
        make.centerY.equalTo(_topView.mas_centerY);
        make.width.equalTo(@(image.size.width));
        make.height.equalTo(@(image.size.height));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_topView.mas_leading);
        make.trailing.equalTo(_topView.mas_trailing);
        make.bottom.equalTo(_topView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    
}
-(void)creatBgView{

    _nextBgView = [[UIView alloc]init];
    _nextBgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_nextBgView addGestureRecognizer:tap];
    [self.view addSubview:_nextBgView];
    

    
    [_nextBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.top.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    _nextView = [[UIView alloc]init];
    _nextView.backgroundColor = XFGGlobalBg;
    [_nextBgView addSubview:_nextView];
    
    
    _nextCategoriesAll =@[@"全部分类",@"中老年",@"青少年",@"女性",@"儿童"];
    
    NSInteger rows;
    rows = (_nextCategoriesAll
            .count%3)?(_nextCategoriesAll.count/3+1):(_nextCategoriesAll.count/3);
    rows = rows?rows:1;//row>0为原值，否则为1；
    
    CGFloat h =29;
    [_nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.top.equalTo(_topView.mas_bottom);
        make.width.equalTo(_topView.mas_width);
        make.height.equalTo(@(h*rows));
    }];
    
    

    
    [self setUpCategoriesCollectionView];
    

//    [self creatNextView:_nextCategoriesAll];
    
    _nextBgView.hidden = YES;
    

}
-(void)tap{
    
    _nextBgView.hidden = YES;
    _allBtn.selected = NO;
    _zhBtn.selected = NO;
    
}
-(void)creatNextView:(NSArray *)arr{
//    _nextCategoriesAll = [[NSMutableArray alloc]initWithCapacity:0];


    
//    for (int i = 0; i<arr.count; i++) {
//        _nextButton =  [[UIButton alloc]init];
//        [_nextButton setTitle:arr[i] forState:UIControlStateNormal];
//        [_nextButton setTitleColor:XFGGlobalFoutColor forState:UIControlStateNormal];
//        [_nextButton setTitleColor:XFGLogoColor forState:UIControlStateSelected];
//        _nextButton.tag = i;
//        [_nextButton addTarget:self action:@selector(clickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
////        [_nextButton setBackgroundColor:[UIColor redColor]];
//        [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
//        [_nextView addSubview:_nextButton];
//        
//        if (!i) {
//            _nextButton.selected = YES;
//            _nextSelectButton = _nextButton;
//        }
//        
//        if (i%3==0) {
//            
//            [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_nextView.mas_left);
//                make.top.equalTo(_nextView.mas_top).offset(h*i/3);
//                make.width.equalTo(_nextView.mas_width).multipliedBy(0.333333);
//                make.height.equalTo(@(h));
//            }];
//            
//        }else{
//                [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(_nextCurrentButton.mas_right);
//                    make.top.equalTo(_nextCurrentButton.mas_top);
//                    make.width.equalTo(_nextView.mas_width).multipliedBy(0.333333);
//                    make.height.equalTo(@(h));
//                }];
//        }
//
//        _nextCurrentButton = _nextButton;
//        
//    }

    

    
}



//-(void)changeNextView:(NSArray *)arr
//{
//    
//    for (UIView*view in _nextBgView.subviews) {
//        [view removeFromSuperview];
//    }
//    [self creatNextView:arr];
//    
//}

-(void)clickAllBtn{
    if (_zhBtn.selected) {
        _nextBgView.hidden = NO;
        
    }else{
        
        _nextBgView.hidden = _nextBgView.hidden?NO:YES;
    }
    _allBtn.selected = _allBtn.selected?NO:YES;
    _zhBtn.selected = NO;

    _nextCategoriesAll =@[@"全部分类",@"中老年",@"青少年",@"女性",@"儿童"];
    [self.collectionView reloadData];
//    [self creatNextView:_nextCategoriesAll];


}
-(void)clickZhBtn{
    
    if (_allBtn.selected) {
        _nextBgView.hidden = NO;
    }else{
        
        _nextBgView.hidden = _nextBgView.hidden?NO:YES;
    }
    _zhBtn.selected = _zhBtn.selected?NO:YES;

    _allBtn.selected = NO;
    
    _nextCategoriesAll =@[@"综合排序",@"销量最高",@"价格最高",@"价格最低"];
    
    [self.collectionView reloadData];
//    [self changeNextView:arr];
    
}

-(void)clickNextBtn:(UIButton *)btn{


    XFGLog(@"btn.tag =%ld,btn.titleLabel.text = %@",btn.tag,btn.titleLabel.text);
    if (_allBtn.selected) {
        _clickBtnCount = btn.tag;
        
    }else{
        _clickBtnCount2 = btn.tag;
    }
    _nextSelectButton.selected = NO;
    btn.selected = YES;
     _nextSelectButton = btn;
    
    [_allBtn.selected?_allBtn:_zhBtn setTitle:btn.titleLabel.text forState:UIControlStateNormal];
    
    _allBtn.selected?(_allBtn.selected = NO):(_zhBtn.selected = NO);
    
    _nextBgView.hidden =YES;

    
}
-(void)clickTypeBtn:(UIButton *)btn{
    
    _typeBtn.selected = _typeBtn.selected?NO:YES;
    _nextBgView.hidden = YES;
    _productsController.productsTableView.hidden = _productsController.productsTableView.hidden?NO:YES;
    _productsController.productsCollectionView.hidden = _productsController.productsTableView.hidden?NO:YES;
    
    
}
-(void)clickCartBtn{
    
    XFGLogFunc;
    LZCartViewController*vc = [[LZCartViewController alloc]init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - tableViewDelegete

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<1) {
        return 35;
    }else{
        return 44;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XFGCategoryCell *cell = [XFGCategoryCell cellWithTable:tableView];
    if (indexPath.row == 1) {
        
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(cell.mas_centerY).offset(-10);

        }];
    }
    cell.backgroundColor = XFGGlobalBg;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != _lastClickT) {
        [_allBtn setTitle:@"全部分类" forState:UIControlStateNormal];
        [_zhBtn setTitle:@"综合排序" forState:UIControlStateNormal];
        _clickBtnCount = 0;
        _clickBtnCount2 = 0;
        [self.collectionView reloadData];
    }
    XFGLog(@"indexPath.row = %ld",indexPath.row);
    [self tap];
    _lastClickT = indexPath.row;
}


@end
