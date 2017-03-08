//
//  ProductsController.m
//  商品二级联动
//
//  Created by 方飞 on 17/3/2.
//  Copyright © 2017年 方飞demo. All rights reserved.
//

#import "ProductsController.h"
#import "LMJRefreshHeader.h"
#import "ProductsCell.h"
#import "ProductsCollectionViewCell.h"
#import "RKNotificationHub.h"
#import "XFGMJRefreshAutoNormalFooter.h"
#import "XFGMJChiBaoZiHeader.h"


@interface ProductsController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>{
    
    RKNotificationHub *hub;
    RKNotificationHub *barHub;
    XFGMJChiBaoZiHeader *header;
    XFGMJRefreshAutoNormalFooter *footer;

}
@property (nonatomic, strong)  UIImageView *animateImgV;
@property (strong, nonatomic) DWPromptAnimation *animation;


@end

@implementation ProductsController

static NSString * const reuseIdentifier = @"ProductsCollectionViewCell";
-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(UISCREENWIDTH * 0.25, 64+35, UISCREENWIDTH * 0.75, UISCREENHEIGHT - 64-35)];
}

- (DWPromptAnimation *)animation {
    
    if (!_animation) {
        
        _animation = [[DWPromptAnimation alloc] init];
    }
    
    return _animation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpProductsTableView];
    [self setUpProductsCollectionView];
    [self creatCart];


    
}
- (void)setupRefresh
{
    header = [XFGMJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    footer = [XFGMJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


#pragma mark - 数据处理
/**
 * 加载新数据
 */
- (void)loadNewData{
    // 结束上啦
    [self.productsTableView.mj_footer endRefreshing];
    [self.productsCollectionView.mj_footer endRefreshing];
    //发送请求
    
//    [self loadDataSize:@"10"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.productsTableView reloadData];
        [self.productsCollectionView reloadData];
    });
    // 结束刷新
    [self.productsTableView.mj_header endRefreshing];
    [self.productsCollectionView.mj_header endRefreshing];
    
}

/**
 * 加载更多数据
 */
- (void)loadMoreData{
    // 结束下拉
    // 结束刷新
    [self.productsTableView.mj_header endRefreshing];
    [self.productsCollectionView.mj_header endRefreshing];
    
    //发送请求
//    self.size = [NSString stringWithFormat:@"%d",[self.size intValue]+10];
    //发送请求
    
//    [self loadDataSize:self.size];
    
    // 刷新表格
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.productsTableView reloadData];
        [self.productsCollectionView reloadData];
    });
    
    // 结束刷新状态
    [self.productsTableView.mj_footer endRefreshing];
    [self.productsCollectionView.mj_footer endRefreshing];
    
    //    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    //    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    
}



-(void)setUpProductsTableView
{
    self.productsTableView = ({
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.backgroundColor = [UIColor whiteColor];
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
    [self.view addSubview:self.productsTableView];
    [self.productsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // 添加刷新控件
    [self setupRefresh];
    // 设置
    self.productsTableView.mj_header = header;
    self.productsTableView.mj_footer = footer;
//    LMJRefreshHeader * header =[LMJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];
//    self.productsTableView.mj_header  = header;
}


-(void)setUpProductsCollectionView{

   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //定义每个UICollectionView 的大小
    flowLayout.itemSize = CGSizeMake((self.view.width-12) * 0.5, (self.view.width-8) * 0.5 + 76);
    
    self.productsCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:flowLayout];
    self.productsCollectionView.delegate = self;
    self.productsCollectionView.dataSource = self;
    self.productsCollectionView.backgroundColor = [UIColor whiteColor];
    //这个是两行cell之间的间距（上下行cell的间距）
    flowLayout.minimumLineSpacing = 4;
    //两个cell之间的间距（同一行的cell的间距）
    flowLayout.minimumInteritemSpacing = 4;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(4, 4, 0, 4);//上左下右
    //自适应大小
    self.productsCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.view addSubview:self.productsCollectionView];

    //注册cell
    [self.productsCollectionView registerNib:[UINib nibWithNibName:@"ProductsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    // 添加刷新控件
    [self setupRefresh];
    // 设置
    self.productsCollectionView.mj_header = header;
    self.productsCollectionView.mj_footer = footer;
//    LMJRefreshHeader * header =[LMJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];
//    self.productsCollectionView.mj_header  = header;

}



-(void)creatCart{
    
    UIImage *cart = [UIImage imageNamed:@"cart"];
    _cartBtn = [[UIButton alloc]init];
    _cartBtn.enabled = NO;
    [_cartBtn setImage:cart forState:UIControlStateNormal];
    [self.view addSubview:_cartBtn];
    //通知动画
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testIncrement) name:@"shopCarAnimationEnd" object:nil];
    //badge,圆点
    hub = [[RKNotificationHub alloc]initWithView:_cartBtn];
    [hub moveCircleByX:0 Y:0];
    [hub setCircleAtFrame:CGRectMake(cart.size.width/2, 0, cart.size.width/2, cart.size.width/2)];
    
    [_cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.width.mas_equalTo(cart.size.width);
        make.height.mas_equalTo(cart.size.height);
    }];
    
}

//-(void)headerFresh
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.productsTableView.mj_header endRefreshing];
//        [self.productsCollectionView.mj_header endRefreshing];
//    });
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductsCell *cell = [ProductsCell cellWithTable:tableView];
    [cell.addCart addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
    cell.addCart.tag = indexPath.row;
    
//    cell.goods = self.superMarketData.categories[indexPath.section].products[indexPath.row];
    return cell;
}

#pragma mark - Collection View Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


////定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((self.view.width-8) * 0.5, (self.view.width-8) * 0.5 + 76);
//}
//
//// 该方法是设置一个section的上左下右边距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0,0);
////
//   
//}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier  forIndexPath:indexPath];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:0.5];
    [cell.layer setBorderColor:XFGWeakColor.CGColor];
    [cell.layer setCornerRadius:5.0];
    
    [cell.addCart addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
    cell.addCart.tag = 1000+indexPath.row;
    
    [cell sizeToFit];
    return cell;
}


-(void)addCart:(UIButton *)btn{
//    FF(weakSelf);
    btn.enabled = NO;
    if(btn.tag<1000){
    
    
        ProductsCell * cell=(ProductsCell *)[[btn superview] superview];

        
        [self addProductsAnimation:cell.goodsImageView dropToPoint:CGPointMake(self.view.width-40, self.view.height-100) isNeedNotification:YES];
        self.addShopCarFinished = ^{
            
            NSLog(@"完成了动画（如果不使用通知的方式，可以使用这种方式）");
            btn.enabled = YES;
        };
    }else{
        ProductsCollectionViewCell *cell = (ProductsCollectionViewCell *)[[btn superview] superview];
        
        [self addProductsAnimation:cell.goodsImageView dropToPoint:CGPointMake(self.view.width-40, self.view.height-100) isNeedNotification:YES];
        self.addShopCarFinished = ^{
            
            NSLog(@"完成了动画（如果不使用通知的方式，可以使用这种方式）");
            btn.enabled = YES;
        };
    
    
    }


    XFGLogFunc;
    
}

#pragma mark - NSNotification
-(void)testIncrement
{
    [hub increment];
    [hub pop];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
