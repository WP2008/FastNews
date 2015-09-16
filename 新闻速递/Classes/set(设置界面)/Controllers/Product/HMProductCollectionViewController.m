//
//  HMProductCollectionViewController.m
//  Demo_彩票_HM
//
//  Created by tarena on 15/8/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HMProductCollectionViewController.h"
#import "HMProduct.h"
#import "HMProductCell.h"

@interface HMProductCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation HMProductCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)products {
    if ( _products == nil) {
       NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource: @"products.json" ofType:nil]];
       NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _products = [NSMutableArray array];
        /**
         *  array -> Dictionaries - > Models
         */
        for(NSDictionary *dict in array) {
            HMProduct *product = [HMProduct productWithDict:dict];
            [_products addObject:product];
            
        }
    }
    return _products;
}
  
 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    /**
     *  🐷 这两个不同
     */
    //NSLog(@"%@---%@",self.view,self.collectionView);
    
}


//🐷collection View 重写 init 方法创建 布局控制器
// cell 必须自己注册
- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //创建流式布局
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // 每一个cell的尺寸
        layout.itemSize = CGSizeMake(80, 80);
        
        // 垂直间距
        layout.minimumLineSpacing = 10;
        
        // 水平间距
        layout.minimumInteritemSpacing = 10;
        
        // 内边距
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
        
    }
    return self;
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HMProduct *product = self.products[indexPath.row];
    // 🐷cell不能代码创建 alloc
    HMProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   
    cell.product = product;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HMProduct *product = self.products[indexPath.row];
    NSLog(@"%@ -- %@",indexPath , product);
}


@end
